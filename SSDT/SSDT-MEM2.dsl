//
// Add MEM2 device (Search for PNP0C01, if it is missing, add SSDT-MEM2) as macOS expects
// Credit to jsassu20 (OC-little) and daliansky (Xiaomi Pro)
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "MEM2", 0)
{
#endif
    External (_SB_.PCI0.GFX0, DeviceObj)
    
    Scope (_SB.PCI0.GFX0)
    {
        Device (^^MEM2)
        {
            Name (_HID, EisaId ("PNP0C01")) // _HID: Hardware ID
            Name (_UID, 0x02)
            Name (CRS, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0x20000000,         // Address Base
                    0x00200000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x40000000,         // Address Base
                    0x00200000,         // Address Length
                    )
            })
            
            Method (_CRS, 0, NotSerialized) // _CRS: Current Resource Settings
            {
                Return (CRS)  /* \_SB_.MEM2.CRS_ */
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
#ifndef NO_DEFINITIONBLOCK
}
#endif