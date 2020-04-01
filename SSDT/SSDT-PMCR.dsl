//
// Add PMCR device (Search for 'PMCR' and 'APP9876', if missing, add SSDT-PMCR)
// PPMC and PMCR combine together for macOS to load LPCB correctly
// Credit to jsassu20 (OC-little) and daliansky (Xiaomi Pro)
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "ACDT", "PMCR", 0)
{
#endif
    External(_SB.PCI0.LPCB, DeviceObj)
    Scope (_SB.PCI0.LPCB)
    {
        Device (PMCR)
        {
            Name (_HID, EisaId ("APP9876"))
            Name (_CRS, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0xFE000000,
                    0x00010000 
                    )

            })
            Method (_STA, 0, NotSerialized)
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