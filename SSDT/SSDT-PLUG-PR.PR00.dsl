//
// XCPM power management compatibility table
// Inject X86 for CPU power management (search for 'Processor' in DSDT)
// Credit to daliansky (OC-little) and acindanthera (OpenCorePkg)
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "ACDT", "CpuPlug", 0x00003000)
{
#endif
    External (_PR_.CPPC, FieldUnitObj)
    External (_PR_.PR00, ProcessorObj)
    
    If (_OSI ("Darwin"))
    {
    
        Method (PMPM, 4, NotSerialized)
        {
            If (LEqual (Arg2, Zero))
            {
                Return (Buffer (One) { 0x03 })
            }
            
            Return (Package (0x02)
            {
                "plugin-type", 
                One
            })
        }

        If (CondRefOf (\_PR.PR00))
        {
            If ((ObjectType (\_PR.PR00) == 0x0C))
            {
                Scope (\_PR.PR00)
                {
                    Method (_PPC, 0, NotSerialized) // _PPC: Performance Present Capabilities
                    {
                        Return (\_PR.CPPC) /* External reference */
                    }
                
                    Method (_DSM, 4, NotSerialized)
                    {
                        Return (PMPM (Arg0, Arg1, Arg2, Arg3))
                    }
                }
            }
        }
    }



/*
    Scope (_PR.PR00)
    {
        Method (DTGP, 5, NotSerialized)
        {
            If ((Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b")))
            {
                If ((Arg1 == One))
                {
                    If ((Arg2 == Zero))
                    {
                        Arg4 = Buffer (One)
                            {
                                 0x03                                             // .
                            }
                        Return (One)
                    }

                    If ((Arg2 == One))
                    {
                        Return (One)
                    }
                }
            }

            Arg4 = Buffer (One)
                {
                     0x00                                             // .
                }
            Return (Zero)
        }

        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
        {
            Local0 = Package (0x02)
                {
                    "plugin-type", 
                    One
                }
            DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
            Return (Local0)
        }
    }
*/
#ifndef NO_DEFINITIONBLOCK
}
#endif