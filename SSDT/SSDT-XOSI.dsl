//
// This SSDT reports the system is Windows 10 (Windows 2015).
// Huawei only really expects Windows 10 to be run on this,
// so reporting to be Windows 10 enables most hardware.
//
// Pair with 'Rename _OSI to XOSI' patch in config.plist
// Override for host defined _OSI to handle "Darwin"
// Credit to rehabman
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "_XOSI", 0x00000000)
{
#endif
    Method (XOSI, 1, NotSerialized)
    {
        Local0 = Package (0x0A)
            {
                "Windows", 
                "Windows 2001", 
                "Windows 2001 SP2", 
                "Windows 2006", 
                "Windows 2006 SP1", 
                "Windows 2006.1", 
                "Windows 2009", 
                "Windows 2012", 
                "Windows 2013", 
                "Windows 2015"
            }
        Return ((Ones != Match (Local0, MEQ, Arg0, MTR, Zero, Zero)))
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif