//
// Hotpatch for disabling the discrete GPU
// Credit to stevezhengshiqi, daliansky (Xiaomi-Pro), Zero-zero (Matebook D 2018)
// 
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "_DDGPU", 0)
{
#endif
    External (_SB_.PCI0.RP01.PXSX._OFF, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP01.PXSX._DSM, MethodObj)    // 4 Arguments
    External (_SB_.PCI0.RP01.PXSX._PS3, MethodObj)    // 0 Arguments

    Device (RMD1)
    {
        Name (_HID, "RMD10000")  // _HID: Hardware ID
        
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            // If conditional methods reference creation successful
            If ((CondRefOf (\_SB.PCI0.RP01.PXSX._DSM) && CondRefOf (\_SB.PCI0.RP01.PXSX._PS3)))
            {
                // Card Off Request
                \_SB.PCI0.RP01.PXSX._DSM (ToUUID ("a486d8f8-0bda-471b-a72b-6042a6b5bee0"), 0x0100, 0x1A, Buffer (0x04)
                    {
                        0x01, 0x00, 0x00, 0x03                         
                    })
                // Card Off
                \_SB.PCI0.RP01.PXSX._PS3 ()
            }
            If (CondRefOf (\_SB.PCI0.RP01.PXSX._OFF))
            {
                \_SB.PCI0.RP01.PXSX._OFF ()
            }
        }

        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
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