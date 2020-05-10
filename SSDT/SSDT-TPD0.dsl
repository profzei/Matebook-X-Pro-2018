//
// Enable trackpad APIC interrupt mode: work with VoodooI2C.kext and VoodooI2CHID.kext
//
// Credit to daliansky XiaomiPro
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "_TPD0", 0)
{
#endif
    External (_SB.PCI0.I2C0.TPD0, DeviceObj)
    
    Scope (_SB.PCI0.I2C0.TPD0)
    {
        If (_OSI ("Darwin"))
        {
            Name (OSYS, 0x07DC)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif