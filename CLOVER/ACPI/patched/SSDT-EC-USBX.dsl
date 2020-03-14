//
// Hotpatch for injecting Fake EC device to load AppleBusPowerController and USB power injection
// AppleUsbPower compatibility table for legacy hardware (Search 'PNP0C09' in DSDT)
// Credit to PMheart, daliansky (OC-little) and jsassu20 (OC-little)
//
// Rename OEM vendor to ACDT
// Try NOT to rename EC0 or H_EC to EC: these devices are incompatible with macOS and 
// may break at any time. AppleACPIEC kext must NOT load.
// Reference: https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/AcpiSamples/SSDT-EC-USBX.dsl
//
// Tweaked USB power levels to MacBookPro 14,1
// Credit to the-darkvoid (Dell XPS 9360)
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "ACDT", "SsdtEC", 0x00001000)
{
#endif
    External (_SB_.PCI0.LPCB, DeviceObj)
    
    External (_SB_.PCI0.LPCB.EC0, DeviceObj)
    
    Scope (\_SB.PCI0.LPCB.EC0)
    {
        Method (_STA, 0, NotSerialized) // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0)
            }
            Else
            {
                Return (0x0F)
            }
        }    
    }

    Scope (\_SB)
    {
        Device (USBX)
        {
            Name (_ADR, Zero) // _ADR: Address
            Method (_DSM, 4, NotSerialized) // _DSM: Device-Specific Method
            {
                If ((Arg2 == Zero))
                {
                    Return (Buffer ()
                    {
                        0x03
                    })    
                }
            
                Return (Package ()
                {
                    "kUSBSleepPortCurrentLimit", 
                    3000,
                    "kUSBSleepPowerSupply", 
                    2600, 
                    "kUSBWakePortCurrentLimit",     
                    3000, 
                    "kUSBWakePowerSupply", 
                    3200
                })
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
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif