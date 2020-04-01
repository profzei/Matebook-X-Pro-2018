//
// Credit to daliansky (Xiaomi Pro) and gnodipac886 (Matebook X Pro)
// Hotpatch for disabling Intel Wireless Card 8265-8275 (RP11) to save power
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "_DRP11", 0)
{
#endif
    External (_SB_.PCI0.RP11, DeviceObj)

    Scope (_SB.PCI0.RP11)
    {
        OperationRegion (DE01, PCI_Config, 0x50, One)
        Field (DE01, AnyAcc, NoLock, Preserve)
        {
                ,   1, 
                ,   3, 
            DDDD,   1
        }
    }

    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            \_SB.PCI0.RP11.DDDD = One
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif