//
// This SSDT adds the missing Memory (DRAM) Controller to the system
// Add MCHC device (Search for 'MCHC', if it is missing, add SSDT-MCHC)
// Credit to jsassu20 (OC-little)
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "MCHC", 0)
{
#endif
    External (_SB_.PCI0, DeviceObj)
    Scope (_SB.PCI0)
    {
        Device (MCHC)
        {
            Name (_ADR, Zero)
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