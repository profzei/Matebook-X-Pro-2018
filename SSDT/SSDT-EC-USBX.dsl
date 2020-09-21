//
// Hotpatch for injecting Fake EC device to load AppleBusPowerController and USB power injection
// AppleUsbPower compatibility table for legacy hardware (Search 'PNP0C09' in DSDT)
// Credit to acidanthera (OpenCorePkg)
//
// Try NOT to rename EC0 or H_EC to EC: these devices are incompatible with macOS and 
// may break at any time. AppleACPIEC kext must NOT load.
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HUAWEI", "SsdtEC", 0x00001000)
{
#endif
    External (_SB_.PCI0.LPCB, DeviceObj)

    Scope (\_SB)
    {
        Device (USBX)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If ((Arg2 == Zero))
                {
                    Return (Buffer (One)
                    {
                         0x03                                             // .
                    })
                }

                Return (Package (0x08)
                {
                    "kUSBSleepPowerSupply", 
                    0x13EC, 
                    "kUSBSleepPortCurrentLimit", 
                    0x0834, 
                    "kUSBWakePowerSupply", 
                    0x13EC, 
                    "kUSBWakePortCurrentLimit", 
                    0x0834
                })
            }
            Method (_STA, 0, NotSerialized) // _STA: Status
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
    }
    
    Scope (\_SB.PCI0.LPCB)
    {
        Device (EC)
        {
            Name (_HID, "ACID0001")  // _HID: Hardware ID
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
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif