//
// Overriding _PTS and _WAK
// Credit to the-darkvoid (XPS13 9360), daliansky (XPS15 7590), Zero-zero (Matebook D 2018), Dukro (Matebook D15)
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "_PTSWAK", 0)
{
#endif
    External(ZPTS, MethodObj)
    External(ZWAK, MethodObj)

    //External(_SB.PCI0.PEG0.PEGP._ON, MethodObj)
    //External(_SB.PCI0.PEG0.PEGP._OFF, MethodObj)
    //External(_SB.PCI0.PGOF, MethodObj)
    //External(_SB.PCI0.PEGP.DGFX._ON, MethodObj)
    //External(_SB.PCI0.PEGP.DGFX._OFF, MethodObj)
    
    //External(_SB.PCI0.RP01._OFF, MethodObj)    // 0 Arguments
    //External(_SB.PCI0.RP01._ON_, MethodObj)    // 0 Arguments
    External(_SB.PCI0.RP01.PXSX._OFF, MethodObj)    // 0 Arguments
    External(_SB.PCI0.RP01.PXSX._ON_, MethodObj)    // 0 Arguments
    External(_SB.PCI0.RP01.PXSX._PS0, MethodObj)    // 0 Arguments
    External(_SB.PCI0.RP01.PXSX._PS3, MethodObj)    // 0 Arguments
    //External(_SB.PCI0.RP01.PXSX.HGOF, MethodObj)    // 0 Arguments
    //External(_SB.PCI0.RP01.PXSX.HGON, MethodObj)    // 0 Arguments

    External(RMCF.DPTS, IntObj)
    External(RMCF.SHUT, IntObj)
    External(RMCF.XPEE, IntObj)
    External(RMCF.SSTF, IntObj)
    External(_SB.LID_, DeviceObj)
    External(_SB.PCI0.GFX0.CLID, FieldUnitObj)
    External(_SB.PCI0.XHC.PMEE, FieldUnitObj)
    External(_SI._SST, MethodObj)

    // In DSDT, native _PTS and _WAK are renamed ZPTS/ZWAK
    // As a result, calls to these methods land here.
    Method(_PTS, 1, NotSerialized) // _PTS: Prepare to Sleep
    {
        if (0x05 == Arg0)
        {
            // Shutdown fix, if enabled
            If (CondRefOf(\RMCF.SHUT))
            {
                If (\RMCF.SHUT & One) { Return (Zero)}
                If (\RMCF.SHUT & 0x02)
                {
                    OperationRegion(PMRS, SystemIO, 0x1830, One)
                    Field(PMRS, ByteAcc, NoLock, Preserve)
                    {
                            , 4,
                        SLPE, 1,
                    }
                    // alternate shutdown fix using SLPE (mostly provided as an example)
                    // likely very specific to certain motherboards
                    SLPE = Zero
                    Sleep (0x10)
                    //Store(0, SLPE)
                    //Sleep(16)
                }
            }
        }

        If (CondRefOf(\RMCF.DPTS))
        {
            If (\RMCF.DPTS)
            {
                // enable discrete graphics
                If (CondRefOf(\_SB.PCI0.RP01.PXSX._PS0)) { \_SB.PCI0.RP01.PXSX._PS0() }
                If (CondRefOf(\_SB.PCI0.RP01.PXSX._ON)) { \_SB.PCI0.RP01.PXSX._ON() }
            }
        }

        // call into original _PTS method
        ZPTS(Arg0)

        If (0x05 == Arg0)
        {
            // XHC.PMEE fix, if enabled
            If (CondRefOf(\RMCF.XPEE)) 
            { 
                If (\RMCF.XPEE && CondRefOf(\_SB.PCI0.XHC.PMEE)) 
                { 
                    \_SB.PCI0.XHC.PMEE = Zero 
                } 
            }
        }
    }
    
    Method(_WAK, 1, Serialized) // _WAK: Wake
    {
        // Take care of bug regarding Arg0 in certain versions of OS X...
        // (starting at 10.8.5, confirmed fixed 10.10.2)
        If (((Arg0 < One) || (Arg0 > 0x05))) 
        { 
            Arg0 = 0x03 
        }

        // call into original _WAK method
        Local0 = ZWAK(Arg0)

        If (CondRefOf(\RMCF.DPTS))
        {
            If (\RMCF.DPTS)
            {
                // disable discrete graphics
                If (CondRefOf(\_SB.PCI0.RP01.PXSX._PS3)) { \_SB.PCI0.RP01.PXSX._PS3() }
                If (CondRefOf(\_SB.PCI0.RP01.PXSX._OFF)) { \_SB.PCI0.RP01.PXSX._OFF() }
            }
        }

        If (CondRefOf(\RMCF.SSTF))
        {
            If (\RMCF.SSTF)
            {
                // call _SI._SST to indicate system "working"
                // for more info, read ACPI specification
                If (((0x03 == Arg0) && CondRefOf(\_SI._SST))) 
                {
                    \_SI._SST(One)
                    /*
                    \_SB.PCI0.GFX0.CLID = One
                    Notify (\_SB.LID, 0x80) // Status Change
                    */ 
                }
            }
        }

        // return value from original _WAK
        Return (Local0)
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif