//
// This SSDT adds IOPMDeepIdleSupported to IOPMRootDomain
// (found at IOService://AppleACPIPlatformExpert/IOPMRootDomain)
// Credit to darkhandz and jardenliu (XPS15 9560)
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "DIDLE", 0)
{
#endif
    Scope (\_SB)
    {
        Method (LPS0, 0, NotSerialized)
        {
            Return (One)
        }
    }
    
    Scope (\_GPE)
    {
        Method (LXEN, 0, NotSerialized)
        {
            Return (One)
        }
    }
    
    Scope (\)
    {
        Name (SLTP, Zero)
        
        Method (_TTS, 1, NotSerialized)
        {
            Store (Arg0, SLTP)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif