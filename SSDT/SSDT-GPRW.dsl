//
// This SSDT provides USB sleep properties. Namely, this fixes 'instant wake' 
// on sleep while USB devices are plugged in
// Hotpatch for solving 'instant wake' by hooking GPRW
// Pair with "Rename Method (GPRW,2,N) to XPRW" rename patch
// Credit to Rehabman, daliansky (Xiaomi Pro) and thedarkvoid (Dell XPS 9360)
//
// In DSDT native GPRW is renamed to XPRW with Clover binpatch
// As a result, calls to GPRW land here.
// The purpose of this implementation is avoiding 'instant wake' by 
// returning 0 in the second position (sleep state supported) of the return package
//
// In config ACPI, GPRW to XPRW
// Find:        47505257 02
// Replace:     58505257 02
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "_GPRW", 0)
{
#endif
    External (XPRW, MethodObj)    // 2 Arguments

    Method (GPRW, 2, NotSerialized)
    {
        If ((0x6D == Arg0))
        {
            Return (Package (0x02)
            {
                0x6D, 
                Zero
            })
        }

        If ((0x0D == Arg0))
        {
            Return (Package (0x02)
            {
                0x0D, 
                Zero
            })
        }

        Return (XPRW (Arg0, Arg1))
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif