//
// SSDT injector working with NullEthernet.kext
// Add Fake LAN (i.e. a fake Ethernet card) to make the system still allow Mac App Store access 
// Credit to jsassu20 (OC-little), daliansky (Xiaomi Pro)
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "_RMNE", 0x00001000)
{
#endif
    Device (RMNE)
    {
        Name (_ADR, Zero)  // _ADR: Address
        Name (_HID, "NULE0000")  // _HID: Hardware ID
        Name (MAC, Buffer (0x06)
        {
             0x11, 0x22, 0x33, 0x44, 0x55, 0x66
        })
        
        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
        {
            If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) } //equivalent to previous DTGP method
            Return (Package ()
                {
                    "built-in", Buffer () { 0x00 }, 
                    "IOName", "ethernet", 
                    "name", Buffer () { "ethernet" }, 
                    "model", Buffer () { "RM-NullEthernet-1001" }, 
                    "device_type", Buffer () { "ethernet" },
                })
        }
        Method (_STA, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif