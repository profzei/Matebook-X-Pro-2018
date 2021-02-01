// This SSDT demonstrates a custom configuration for ALC298.
//
// It is reportedly needed to solve problems of jack sense and
// distorted sound with headphone.
//
// See here for details:
// http://www.tonymacx86.com/threads/alc3266-10ec0298-files-for-applehdapatcher.191231/page-5#post-1323829
//

// Customize to suit your needs.
// Compile to SSDT-ALC298.aml, place in ACPI/patched.  Make sure SortedOrder includes it.

DefinitionBlock ("", "SSDT", 1, "hack", "_ALC298a", 0)
{
    External(_SB.PCI0.HDEF, DeviceObj)
    Name(_SB.PCI0.HDEF.RMCF, Package()
    {
        "CodecCommander", Package()
        {
            "Custom Commands", Package()
            {
                Package(){}, // signifies Array instead of Dictionary
                Package()
                {
                    // 0x01 SET_CODEC_RESET 0x00
                    "Command", Buffer() { 0x00, 0x17, 0xff, 0x00 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">n",
                },
                Package()
                {
                    // 0x01 SET_CODEC_RESET 0x00
                    "Command", Buffer() { 0x00, 0x17, 0xff, 0x00 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">n",
                },
                Package()
                {
                    // 0x1 SET_POWER_STATE 0x03
                    "Command", Buffer() { 0x00, 0x17, 0x05, 0x03 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">n",
                },
                Package()
                {
                    // 0x21 SET_UNSOLICITED_ENABLE 0x83
                    "Command", Buffer() { 0x02, 0x17, 0x08, 0x83 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
            },
            //"Perform Reset", ">n", // enable if using AppleALC
            //"Perform Reset on External Wake", ">n", // enable if using AppleALC
        },
    })
}
//EOF
