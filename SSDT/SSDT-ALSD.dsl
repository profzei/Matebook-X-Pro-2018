//
// Better support for native Ambient Light Sensor Device
// Credit to profzei
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HUAWEI", "ALSD", 0)
{
#endif
    External (ALSE, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC0_.EALS, FieldUnitObj)

    Scope (_SB)
    {
        Method (_INI, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                ALSE = 0x02
                \_SB.PCI0.LPCB.EC0.EALS = One
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif