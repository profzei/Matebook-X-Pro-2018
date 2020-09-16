//
// Enabling Power Button Device
// Credit to daliansky (OC-little) and profzei
//
// Rename PWRB._STA -> PWRB.XSTA 5F535441 00A40A0B -> 58535441 00A40A0B
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HUAWEI", "PWRB", 0)
{
#endif
    External (_SB_.PWRB, DeviceObj)
    External (_SB_.PWRB.XSTA, MethodObj)
        
    Scope (\_SB.PWRB)
    {
        Method (_STA, 0, NotSerialized) // _STA: status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (\_SB.PWRB.XSTA ())
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif