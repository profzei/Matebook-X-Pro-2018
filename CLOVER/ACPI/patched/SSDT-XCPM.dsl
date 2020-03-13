//
// Credit to Rehabman and daliansky (Xiaomi Pro)
// Hotpatch for injecting "plugin-type=1" on _PR.PR00
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "_XCPM", 0)
{
#endif
    External (_PR_.PR00, DeviceObj)

    Scope (\_PR.PR00)
    {
        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
        {
            If (!Arg2)
            {
                Return (Buffer (One)
                {
                     0x03                                             // .
                })
            }

            Return (Package (0x02)
            {
                "plugin-type", 
                One
            })
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif