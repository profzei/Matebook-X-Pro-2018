//
// Credit to The-Darkvoid
// Dell XPS9360
// Tweaked USB power levels to MacBookPro 14,1
//
// USB power properties via USBX device
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "_USBX", 0)
{
#endif
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
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif