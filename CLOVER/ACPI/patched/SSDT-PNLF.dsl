//
// Adding PNLF device for WhateverGreen.kext
// This is a modified PNLF version originally taken from rehabman repository
// Adding PNLF device for IntelBacklight.kext or AppleBacklight.kext + AppleBacklightFixup.kext
// Credit to rehabman and Zero-zero (Matebook D 2018)
//
#define FBTYPE_SANDYIVY 1
#define FBTYPE_HSWPLUS 2
#define FBTYPE_CFL 3

#define SANDYIVY_PWMMAX 0x710
#define HASWELL_PWMMAX 0xad9
#define SKYLAKE_PWMMAX 0x56c
#define CUSTOM_PWMMAX_07a1 0x07a1
#define CUSTOM_PWMMAX_1499 0x1499
#define COFFEELAKE_PWMMAX 0xffff

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "_PNLF", 0)
{
#endif
    External (_SB_.PCI0.GFX0, DeviceObj)
    External (RMCF.BKLT, IntObj)
    External (RMCF.FBTP, IntObj)
    External (RMCF.GRAN, IntObj)
    External (RMCF.LEVW, IntObj)
    External (RMCF.LMAX, IntObj)

    Scope (_SB.PCI0.GFX0)
    {
        OperationRegion (RMP3, PCI_Config, Zero, 0x14)
    }

    Device (_SB.PCI0.GFX0.PNLF) // for backlight control
    {
        Name (_ADR, Zero)  // _ADR: Address
        Name (_HID, EisaId ("APP0002"))  // _HID: Hardware ID
        Name (_CID, "backlight")  // _CID: Compatible ID
        Name (_UID, Zero)  // _UID: Unique ID
        
        Field (^RMP3, AnyAcc, NoLock, Preserve)
        {
            Offset (0x02), 
            GDID,   16, 
            Offset (0x10), 
            BAR1,   32,
        }

        OperationRegion (RMB1, SystemMemory, (BAR1 & 0xFFFFFFFFFFFFFFF0), 0x000E1184)
        Field (RMB1, AnyAcc, Lock, Preserve)
        {
            Offset (0x48250), 
            LEV2,   32, 
            LEVL,   32, 
            Offset (0x70040), 
            P0BL,   32, 
            Offset (0xC2000), 
            GRAN,   32, 
            Offset (0xC8250), 
            LEVW,   32, 
            LEVX,   32, 
            LEVD,   32, 
            Offset (0xE1180), 
            PCHL,   32,
        }

        Method (INI1, 1, NotSerialized) // INI1 is common code used by FBTYPE_HSWPLUS and FBTYPE_CFL
        {
            If ((Zero == (0x02 & Arg0)))
            {
                Local5 = 0xC0000000
                If (CondRefOf (\RMCF.LEVW))
                {
                    If ((Ones != \RMCF.LEVW))
                    {
                        Local5 = \RMCF.LEVW /* External reference */
                    }
                }

                ^LEVW = Local5
            }

            If ((0x04 & Arg0))
            {
                If (CondRefOf (\RMCF.GRAN))
                {
                    ^GRAN = \RMCF.GRAN /* External reference */
                }
                Else
                {
                    ^GRAN = Zero
                }
            }
        }

        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            // IntelBacklight.kext takes care of this at load time...
            // If RMCF.BKLT does not exist, it isi assumed you want to use AppleBacklight.kext
            Local4 = One
            If (CondRefOf (\RMCF.BKLT))
            {
                Local4 = \RMCF.BKLT /* External reference */
            }

            If (!(One & Local4))
            {
                Return (Zero)
            }

            // Adjustment required when using AppleBacklight.kext
            Local0 = ^GDID /* \_SB_.PCI0.GFX0.PNLF.GDID */
            Local2 = Ones
            If (CondRefOf (\RMCF.LMAX))
            {
                Local2 = \RMCF.LMAX /* External reference */
            }

            Local3 = Zero
            If (CondRefOf (\RMCF.FBTP))
            {
                Local3 = \RMCF.FBTP /* External reference */
            }

            // Now fixup the backlight PWM depending on the framebuffer type
            // At this point:
            //     Local4 is RMCF.BLKT value, if specified (default 1)
            //     Local0 is device-id for GFX0
            //     Local2 is LMAX, if specified (based on device-id)
            //     Local3 is framebuffer type
            If (((One == Local3) || (Ones != Match (Package (0x10)
                                {
                                    0x010B, 
                                    0x0102, 
                                    0x0106, 
                                    0x1106, 
                                    0x1601, 
                                    0x0116, 
                                    0x0126, 
                                    0x0112, 
                                    0x0122, 
                                    0x0152, 
                                    0x0156, 
                                    0x0162, 
                                    0x0166, 
                                    0x016A, 
                                    0x46, 
                                    0x42
                                }, MEQ, Local0, MTR, Zero, Zero))))
            {
                If ((Ones == Local2))
                {
                    Local2 = SANDYIVY_PWMMAX
                }

                Local1 = (^LEVX >> 0x10)
                If (!Local1)
                {
                    Local1 = Local2
                }

                If ((!(0x08 & Local4) && (Local2 != Local1)))
                {
                    Local0 = ((^LEVL * Local2) / Local1)
                    Local3 = (Local2 << 0x10)
                    If ((Local2 > Local1))
                    {
                        ^LEVX = Local3
                        ^LEVL = Local0
                    }
                    Else
                    {
                        ^LEVL = Local0
                        ^LEVX = Local3
                    }
                }
            }
            // check COFFEELAKE
            ElseIf (((FBTYPE_CFL == Local3) || (Ones != Match (Package (0x04)
                                {
                                    0x3E9B, 
                                    0x3EA5, 
                                    0x3E92, 
                                    0x3E91
                                }, MEQ, Local0, MTR, Zero, Zero))))
            {
                If ((Ones == Local2))
                {
                    Local2 = COFFEELAKE_PWMMAX
                }

                INI1 (Local4)
                Local1 = ^LEVX /* \_SB_.PCI0.GFX0.PNLF.LEVX */
                If (!Local1)
                {
                    Local1 = Local2
                }

                If ((!(0x08 & Local4) && (Local2 != Local1)))
                {
                    Local0 = ((^LEVD * Local2) / Local1)
                    If ((Local2 > Local1))
                    {
                        ^LEVX = Local2
                        ^LEVD = Local0
                    }
                    Else
                    {
                        ^LEVD = Local0
                        ^LEVX = Local2
                    }
                }
            }
            // otherwise must be Haswell/Broadwell/Skylake/KabyLake/KabyLake-R (FBTYPE_HSWPLUS)
            Else
            {
                If ((Ones == Local2))
                {
                    If ((Ones != Match (Package (0x16)
                                    {
                                        0x0D26, 
                                        0x0A26, 
                                        0x0D22, 
                                        0x0412, 
                                        0x0416, 
                                        0x0A16, 
                                        0x0A1E, 
                                        0x0A1E, 
                                        0x0A2E, 
                                        0x041E, 
                                        0x041A, 
                                        0x0BD1, 
                                        0x0BD2, 
                                        0x0BD3, 
                                        0x1606, 
                                        0x160E, 
                                        0x1616, 
                                        0x161E, 
                                        0x1626, 
                                        0x1622, 
                                        0x1612, 
                                        0x162B
                                    }, MEQ, Local0, MTR, Zero, Zero)))
                    {
                        Local2 = HASWELL_PWMMAX
                    }
                    Else
                    {
                        // assume Skylake/KabyLake/KabyLake-R both 0x56c
                        Local2 = SKYLAKE_PWMMAX
                    }
                }

                INI1 (Local4)
                Local1 = (^LEVX >> 0x10)
                If (!Local1)
                {
                    Local1 = Local2
                }

                If ((!(0x08 & Local4) && (Local2 != Local1)))
                {
                    Local0 = ((((^LEVX & 0xFFFF) * Local2) / Local1) | 
                        (Local2 << 0x10))
                    ^LEVX = Local0
                }
            }

            // Now Local2 is the new PWMMAX, set _UID accordingly
            // The _UID selects the correct entry in AppleBacklightFixup.kext
            If ((Local2 == SANDYIVY_PWMMAX))
            {
                _UID = 0x0E
            }
            ElseIf ((Local2 == HASWELL_PWMMAX))
            {
                _UID = 0x0F
            }
            ElseIf ((Local2 == SKYLAKE_PWMMAX))
            {
                _UID = 0x10
            }
            ElseIf ((Local2 == CUSTOM_PWMMAX_07a1))
            {
                _UID = 0x11
            }
            ElseIf ((Local2 == CUSTOM_PWMMAX_1499))
            {
                _UID = 0x12
            }
            ElseIf ((Local2 == COFFEELAKE_PWMMAX))
            {
                _UID = 0x13
            }
            Else
            {
                _UID = 0x63
            }
        }

        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0B)
            }
            Else
            {
                Return (Zero)
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif