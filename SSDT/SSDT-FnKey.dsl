//
// This SSDT contains a fix for brightness keys F1 and F2
// Credit to Zero-zero (Matebook D 2018)
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "ACDT", "BrightFN", 0)
{
#endif
    External (_SB_.PCI0.LPCB.EC0_, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_.XQ0A, MethodObj)    // EC0 to EC
    External (_SB_.PCI0.LPCB.EC0_.XQ0B, MethodObj)    // EC0 to EC
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)

    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (_Q0A, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                Notify (\_SB.PCI0.LPCB.PS2K, 0x0405)
                Notify (\_SB.PCI0.LPCB.PS2K, 0x20) // Reserved
            }
            Else
            {
                \_SB.PCI0.LPCB.EC0.XQ0A ()
            }
        }

        Method (_Q0B, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                Notify (\_SB.PCI0.LPCB.PS2K, 0x0406)
                Notify (\_SB.PCI0.LPCB.PS2K, 0x10) // Reserved
            }
            Else
            {
                \_SB.PCI0.LPCB.EC0.XQ0B ()
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif