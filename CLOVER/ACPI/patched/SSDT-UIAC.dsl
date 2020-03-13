// SSDT-UIAC-ALL.dsl
//
// This SSDT can be used as a template to build your own
// customization for USBInjectAll.kext.
//
// This SSDT contains all ports, so using it is the same as without
// a custom SSDT.  Delete ports that are not connected or ports you
// do not need.
//
// Patching USB ports, pair with USBInjectAll.kext
// Credit to RZ
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "_UIAC", 0)
{
#endif
    Device(UIAC)
    {
        Name(_HID, "UIA00000")

        Name(RMCF, Package()
        {
            "8086_9d2f", Package()  // examples: 0x9d2f, 0x9ded
            {
                "port-count", Buffer() { 18, 0, 0, 0 },
                "ports", Package()
                {
                    // USB type-C like USB2
                    "HS01", Package()
                    {
                        "UsbConnector", 9,
                        "port", Buffer() { 1, 0, 0, 0 },
                    },
                    // USB type-A like USB2
                    "HS02", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 2, 0, 0, 0 },
                    },
                    // TB3 like USB2
                    "HS03", Package()
                    {
                        "UsbConnector", 9,
                        "port", Buffer() { 3, 0, 0, 0 },
                    },
                    // internal port for Bluetooth
                    "HS05", Package()
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 5, 0, 0, 0 },
                    },
                    // internal port for HD Camera
                    "HS07", Package()
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 7, 0, 0, 0 },
                    },
                    // USB type-C like USB3
                    "SS01", Package()
                    {
                        "UsbConnector", 9,
                        "port", Buffer() { 13, 0, 0, 0 },
                    },
                    // USB type-A like USB3
                    "SS02", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 14, 0, 0, 0 },
                    },
                },
            },
        })
        Method (_STA, 0, NotSerialized) // STA: Status
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