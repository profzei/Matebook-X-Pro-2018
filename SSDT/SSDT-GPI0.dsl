/* 
 * Find _STA:          5F 53 54 41
 * Replace XSTA:       58 53 54 41
 * Target Bridge GPI0: 47 50 49 30
 */
//
// Source: https://github.com/daliansky/OC-little
// Credit to dortania and williambj1
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "GPI0", 0)
{
#endif
    External(_SB.PCI0.GPI0, DeviceObj)
    Scope (_SB.PCI0.GPI0)
    {
        Method (_STA, 0, NotSerialized)
        {
            Return (0x0F)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif