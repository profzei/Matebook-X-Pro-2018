/*
 * Find _CRS:          5F 43 52 53
 * Replace XCRS:       58 43 52 53
 * Target Bridge TPL1: 54504c31
 */
//
// Enable trackpad GPIO interrupt mode: work with VoodooI2C.kext and VoodooI2CHID.kext
//
// Source: https://github.com/daliansky/OC-little
// Credit to dortania and williambj1
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "I2Cpatch", 0)
{
#endif
    External(_SB.PCI0.I2C1.TPL1, DeviceObj)
    External(_SB.PCI0.I2C1.TPL1.SBFB, IntObj)
    External(_SB.PCI0.I2C1.TPL1.SBFG, IntObj)
    External(OSYS, FieldUnitObj)
    External(SDM1, FieldUnitObj)
    
    Scope(_SB.PCI0.I2C1.TPL1)
    {
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            If (LLess (OSYS, 0x07DC))
            {
                Return (ConcatenateResTemplate (SBFB, SBFG)) // Usually this return won't function, please check your Windows Patch
            }

            If (LEqual (SDM1, Zero))
            {
                Return (ConcatenateResTemplate (SBFB, SBFG))
            }

            Return (ConcatenateResTemplate (SBFB, SBFG))
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif