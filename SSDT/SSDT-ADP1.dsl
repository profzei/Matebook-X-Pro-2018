//
// Power fix - cause AppleACPIACAdapter to be loaded
// Credit to daliansky (XPS15 7590) and jardenliu (XPS15 9560)
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "ADP1", 0)
{
#endif
    External (_SB_.PCI0.ADP1, DeviceObj)

    If (_OSI ("Darwin"))
    {
        Scope (\_SB.PCI0.ADP1)
        {
            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x18, 
                0x03
            })
            
            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif