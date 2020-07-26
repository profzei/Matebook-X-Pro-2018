//
// Enable trackpad GPIO interrupt mode: work with VoodooI2C.kext and VoodooI2CHID.kext
// Credit to profzei
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "HUAWEI", "TPXX", 0)
{
#endif
    External (_SB_.GNUM, MethodObj)      // 1 Argument
    External (_SB_.INUM, MethodObj)      // 1 Argument
    External (_SB_.PCI0.GPI0, DeviceObj)
    External (_SB_.PCI0.HIDD, MethodObj) // 5 Arguments
    External (_SB_.PCI0.HIDG, BuffObj)
    External (_SB_.PCI0.I2C0, DeviceObj)
    External (_SB_.PCI0.I2C1, DeviceObj)
    External (_SB_.PCI0.TP7D, MethodObj) // 6 Arguments
    External (_SB_.PCI0.TP7G, BuffObj)
    External (_SB_.SHPO, MethodObj)      // 2 Arguments
    //External (_SB_.SRXO, MethodObj)      // 2 Arguments
    External (GPEN, FieldUnitObj)
    //External (OSYS, FieldUnitObj)
    External (SDM0, FieldUnitObj)
    External (SDM1, FieldUnitObj)
    External (SDS0, FieldUnitObj)
    External (SDS1, FieldUnitObj)
    //External (TPLB, FieldUnitObj)
    //External (TPLH, FieldUnitObj)
    //External (TPLS, FieldUnitObj)
    External (TPDB, FieldUnitObj)
    External (TPDH, FieldUnitObj)
    External (TPDS, FieldUnitObj)
    
    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            GPEN = One  // enable GPI0 for GPIO pinning
            SDS1 = Zero // disable TPL1 -> TouchPad
            SDS0 = Zero // disable TPD0 -> TouchScreen
        }
    }
    
    // TouchPad
    Scope (_SB.PCI0.I2C1)
    {
        Device (TPLX)
        {
            Name (HID2, Zero)
            Name (SBFB, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x004C, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.PCI0.I2C1",
                    0x00, ResourceConsumer, _Y24, Exclusive,
                    )
            })
            Name (SBFG, ResourceTemplate ()
            {
                GpioInt (Level, ActiveLow, Exclusive, PullDefault, 0x0000,
                    "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0055
                    }
            })
            Name (SBFI, ResourceTemplate ()
            {
                Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, _Y25)
                {
                    0x00000000,
                }
            })
            CreateWordField (SBFB, \_SB.PCI0.I2C1.TPLX._Y24._ADR, BADR)  // _ADR: Address
            CreateDWordField (SBFB, \_SB.PCI0.I2C1.TPLX._Y24._SPE, SPED)  // _SPE: Speed
            CreateDWordField (SBFI, \_SB.PCI0.I2C1.TPLX._Y25._INT, INT2)  // _INT: Interrupts
            CreateWordField (SBFG, 0x17, INT1)
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                Store (GNUM (0x0203000D), INT1)
                Store (INUM (0x0203000D), INT2)
                If (LEqual (SDM1, Zero))
                {
                    SHPO (0x0203000D, One)
                }
                
                Store ("SYNA1D31", _HID)
                Store (0x20, HID2)
                Store (0x15, BADR)
                Store (0x00061A80, SPED)
                Return (Zero)
                
            }
            
            Name (_HID, "XXXX0000")  // _HID: Hardware ID
            Name (_CID, "PNP0C50")  // _CID: Compatible ID
            Name (_S0W, 0x04)  // _S0W: S0 Device Wake State
            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                If (LEqual (Arg0, HIDG))
                {
                    Return (HIDD (Arg0, Arg1, Arg2, Arg3, HID2))
                }

                If (LEqual (Arg0, TP7G))
                {
                    Return (TP7D (Arg0, Arg1, Arg2, Arg3, SBFB, SBFG))
                }

                Return (Buffer (One)
                {
                     0x00                                           
                })
            }
            
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }

                Return (Zero)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                If (_OSI ("Darwin"))
                {
                    Return (ConcatenateResTemplate (SBFB, SBFG))
                }

                If (LEqual (SDM1, Zero))
                {
                    Return (ConcatenateResTemplate (SBFB, SBFG))
                }

                Return (ConcatenateResTemplate (SBFB, SBFI))
            }
        } // End Device
    } // End Scope

    // TouchScreen
    Scope (_SB.PCI0.I2C0)
    {
        Device (TPDX)
        {
            Name (HID2, Zero)
            Name (SBFB, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x0020, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.PCI0.I2C0",
                    0x00, ResourceConsumer, _Y1E, Exclusive,
                    )
            })
            Name (SBFI, ResourceTemplate ()
            {
                Interrupt (ResourceConsumer, Level, ActiveLow, ExclusiveAndWake, ,, _Y1F)
                {
                    0x00000000,
                }
            })
            Name (SBFG, ResourceTemplate ()
            {
                GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                    "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0091
                    }
            })
            CreateWordField (SBFB, \_SB.PCI0.I2C0.TPDX._Y1E._ADR, BADR)  // _ADR: Address
            CreateDWordField (SBFB, \_SB.PCI0.I2C0.TPDX._Y1E._SPE, SPED)  // _SPE: Speed
            CreateWordField (SBFG, 0x17, INT1)
            CreateDWordField (SBFI, \_SB.PCI0.I2C0.TPDX._Y1F._INT, INT2)  // _INT: Interrupts
            
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                Store (GNUM (0x02060001), INT1)
                Store (INUM (0x02060001), INT2)
                If (LEqual (SDM0, Zero))
                {
                    SHPO (0x02060001, One)
                }

                If (LEqual (SDS0, One))
                {
                    Store ("SYNA2393", _HID)
                    Store (0x20, HID2)
                    Return (Zero)
                }

                If (LEqual (SDS0, 0x02))
                {
                    Store ("06CB2846", _HID)
                    Store (0x20, HID2)
                    Return (Zero)
                }

                If (LEqual (SDS0, 0x06))
                {
                    Store ("ALPS0000", _HID)
                    Store (0x20, HID2)
                    Store (0x2C, BADR)
                    Return (Zero)
                }

                If (LEqual (SDS0, 0x05))
                {
                    Store ("SYNA2393", _HID)
                    Store (TPDH, HID2)
                    Store (TPDB, BADR)
                    If (LEqual (TPDS, Zero))
                    {
                        Store (0x000186A0, SPED)
                    }

                    If (LEqual (TPDS, One))
                    {
                        Store (0x00061A80, SPED)
                    }

                    If (LEqual (TPDS, 0x02))
                    {
                        Store (0x000F4240, SPED)
                    }

                    Return (Zero)
                }
            }
            
            Name (_HID, "XXXX0000")  // _HID: Hardware ID
            Name (_CID, "PNP0C50")  // _CID: Compatible ID
            Name (_S0W, 0x03)  // _S0W: S0 Device Wake State
            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                If (LEqual (Arg0, HIDG))
                {
                    Return (HIDD (Arg0, Arg1, Arg2, Arg3, HID2))
                }

                If (LEqual (Arg0, TP7G))
                {
                    Return (TP7D (Arg0, Arg1, Arg2, Arg3, SBFB, SBFG))
                }

                Return (Buffer (One)
                {
                     0x00                                           
                })
            }
            
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                If (_OSI ("Darwin"))
                {
                    Return (ConcatenateResTemplate (SBFB, SBFG))
                }
                
                If (LEqual (SDM0, Zero))
                {
                    Return (ConcatenateResTemplate (SBFB, SBFG))
                }

                Return (ConcatenateResTemplate (SBFB, SBFG))
            }
        } // End Device
    } // End Scope
#ifndef NO_DEFINITIONBLOCK
}
#endif