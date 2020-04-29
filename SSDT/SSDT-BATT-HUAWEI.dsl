//
// Battery Hotpatch for Huawei Matebook X Pro 2018
// Credit to GZXiaobai, XStar-dev and profzei
//
// Method BIF0,0,S to XIF0    42494630 08 -> 58494630 08
// Method BIF1,0,S to XIF1    42494631 08 -> 58494631 08
// Method BIF2,0,S to XIF2    42494632 08 -> 58494632 08
// Method BIF3,0,S to XIF3    42494633 08 -> 58494633 08
// Method BIF4,0,S to XIF4    42494634 08 -> 58494634 08
// Method BIFA,0,S to XIFA    42494641 08 -> 58494641 08
// Method BCRT,0,S to XCRT    42435254 08 -> 58435254 08
// Method BRCP,0,S to XRCP    42524350 08 -> 58524350 08
// Method BSTS,0,S to XSTS    42535453 08 -> 58535453 08
// Method BVOT,0,S to XVOT    42564F54 08 -> 58564F54 08
// Method ECBM,1,S to XCBM    4543424D 09 -> 5843424D 09
// Method ECDE,0,S to XCDE    45434445 08 -> 58434445 08
// Method _QA8,0,N to XQA8    5F514138 00 -> 58514138 00
// Method _QA9,0,N to XQA9    5F514139 00 -> 58514139 00
// Method ALSD._INI,0,N to XINI    5F494E49 0070 53 -> 58494E49 0070 53
// Method ALSD.S3WK,0,N to X3WK    5333574B 00 -> 5833574B 00
// Method ALSD.S3PT,0,N to X3PT    53335054 00 -> 58335054 00
// Method BAT0.FBST,4,N to XFBS    46425354 04 -> 58464253 04
// Method BAT0._BIX to XBIX forse no
// Method BAT0._BST to XBST forse no
// Method TPWR.ACUR,0,S to XCUR    41435552 08 -> 58435552 08
// Method TPWR.AVOL,0,S to XVOL    41564F4C 08 -> 58564F4C 08
// Method TPWR.PBSS,0,N to XBSS    50425353 00 -> 58425353 00
// Method TPWR.PMAX,0,S to XMAX    504D4158 08 -> 584D4158 08
// Method TPWR.PSOC,0,N to XSOC    50534F43 00 -> 58534F43 00
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HUAWEI", "BATT", 0)
{
#endif
    External (_SB.PCI0.BAT0, DeviceObj)
    External (_SB.PCI0.BAT0.CLFG, IntObj)
    External (_SB.PCI0.BAT0.DVOT, IntObj)
    External (_SB.PCI0.BAT0.LFCC, IntObj)
    External (_SB.PCI0.BAT0.PBST, PkgObj)
    External (_SB.PCI0.BAT0.PUNT, IntObj)
    External (_SB.PCI0.BAT0.XFBS, MethodObj) // 4 Arguments
    //External (_SB.PCI0.BAT0.XBIX, MethodObj) // 0 Arguments
    //External (_SB.PCI0.BAT0.XBST, MethodObj) // 0 Arguments
    
    External (_SB.PCI0.LPCB.EC__, DeviceObj) //EC0 to EC
    
    External (_SB.PCI0.LPCB.EC_.ALSD, DeviceObj)
    External (_SB.PCI0.LPCB.EC_.ALSD.ALRC, MethodObj) // 1 Arguments
    External (_SB.PCI0.LPCB.EC_.ALSD.ALSC, MethodObj) // 1 Arguments
    External (_SB.PCI0.LPCB.EC_.ALSD.ALSI, IntObj) // 1 Arguments
    External (_SB.PCI0.LPCB.EC_.ALSD.GLOV, MethodObj) // 1 Arguments
    External (_SB.PCI0.LPCB.EC_.ALSD.GUPV, MethodObj) // 1 Arguments
    External (_SB.PCI0.LPCB.EC_.ALSD.SLLV, IntObj)
    External (_SB.PCI0.LPCB.EC_.ALSD.SULV, IntObj)
    External (_SB.PCI0.LPCB.EC_.ALSD.SWAP, MethodObj) // 1 Arguments
    External (_SB.PCI0.LPCB.EC_.ALSD.XINI, MethodObj) // 0 Arguments
    External (_SB.PCI0.LPCB.EC_.ALSD.X3WK, MethodObj) // 0 Arguments
    External (_SB.PCI0.LPCB.EC_.ALSD.X3PT, MethodObj) // 0 Arguments
    External (_SB.PCI0.LPCB.EC_.ACAP, MethodObj) // 0 Arguments
    External (_SB.PCI0.LPCB.EC_.BALS, FieldUnitObj)
        
    External (_SB.PCI0.LPCB.EC__.ECAV, MethodObj) // 0 Arguments
    External (_SB.PCI0.LPCB.EC__.XIF0, MethodObj) //BIF0 to XIF0 0 Arguments
    External (_SB.PCI0.LPCB.EC__.XIF1, MethodObj) //BIF1 to XIF1 0 Arguments
    External (_SB.PCI0.LPCB.EC__.XIF2, MethodObj) //BIF2 to XIF2 0 Arguments
    External (_SB.PCI0.LPCB.EC__.XIF3, MethodObj) //BIF3 to XIF3 0 Arguments
    External (_SB.PCI0.LPCB.EC__.XIF4, MethodObj) //BIF4 to XIF4 0 Arguments
    External (_SB.PCI0.LPCB.EC__.XIFA, MethodObj) //BIFA to XIFA 0 Arguments
    External (_SB.PCI0.LPCB.EC__.XCRT, MethodObj) //BCRT to XCRT 0 Arguments
    External (_SB.PCI0.LPCB.EC__.XRCP, MethodObj) //BRCP to XRCP 0 Arguments
    External (_SB.PCI0.LPCB.EC__.XSTS, MethodObj) //BSTS to XSTS 0 Arguments
    External (_SB.PCI0.LPCB.EC__.XVOT, MethodObj) //BVOT to XVOT 0 Arguments
    External (_SB.PCI0.LPCB.EC__.XCBM, MethodObj) //ECBM to XCBM 1 Arguments
    External (_SB.PCI0.LPCB.EC__.XCDE, MethodObj) //ECDE to XCDE 0 Arguments
    External (_SB.PCI0.LPCB.EC__.XQA8, MethodObj) //_QA8 to XQA8 0 Arguments
    External (_SB.PCI0.LPCB.EC__.XQA9, MethodObj) //_QA9 to XQA9 0 Arguments
    External (_SB.PCI0.LPCB.EC__.MUEC, MutexObj)
    External (_SB.PCI0.LPCB.EC__.RRAM, MethodObj) // 1 Arguments
    External (_SB.PCI0.LPCB.EC__.ESEM, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC__.CMD1, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC__.EDA1, FieldUnitObj)
    /*
    External (_SB.TPWR, DeviceObj)
    External (_SB.TPWR.PSRC, MethodObj) // 0 Arguments
    External (_SB.TPWR.XCUR, MethodObj) //ACUR to XCUR  0 Arguments
    External (_SB.TPWR.XVOL, MethodObj) //AVOL to XVOL 0 Arguments
    External (_SB.TPWR.XBSS, MethodObj) //PBSS to XBSS 0 Arguments
    External (_SB.TPWR.XMAX, MethodObj) //PMAX to XMAX 0 Arguments
    External (_SB.TPWR.XSOC, MethodObj) //PSOC to XSOC 0 Arguments
    */
    External (ADBG, MethodObj) // 1 Arguments
    External (ALSK, FieldUnitObj)
    External (BSLF, IntObj)
    External (CHGS, MethodObj) // 1 Arguments
    External (NTOC, MethodObj) // 1 Arguments

    Method (B1B2, 2, NotSerialized)
    {
        Return ((Arg0 | (Arg1 << 0x08)))
    }
    
    Method (B1B4, 4, NotSerialized)
    {
        Local0 = (Arg2 | (Arg3 << 0x08))
        Local0 = (Arg1 | (Local0 << 0x08))
        Local0 = (Arg0 | (Local0 << 0x08))
        Return (Local0)
    }
    
    Method (W16B, 3, NotSerialized)
    {
        Arg0 = Arg2
        Arg1 = (Arg2 >> 0x08)
    }
    
    Scope (_SB.PCI0.BAT0)
    {
        Method (FBST, 4, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                And (Arg1, 0xFFFF, Local1)
                Store (Zero, Local0)
                If (^^LPCB.EC_.ACAP ()) // EC0 to EC
                {
                    Store (One, Local0)
                }

                If (Local0)
                {
                    If (LAnd (CHGS (Zero), LNot (^^LPCB.EC_.ECDE ()))) // EC0 to EC
                    {
                        Store (0x02, Local0)
                    }
                    //ElseIf (LAnd (^^LPCB.EC0.ECDE (), And (0x8000, ^^LPCB.EC0.B0CC)))
                    ElseIf (LAnd (^^LPCB.EC_.ECDE (), And (0x8000, B1B2 (^^LPCB.EC_.BCC0, ^^LPCB.EC_.BCC1)))) // EC0 to EC
                    {
                        Store (One, Local0)
                    }
                    Else
                    {
                        Store (Zero, Local0)
                    }
                }
                Else
                {
                    Store (One, Local0)
                }

                And (Arg0, 0x0300, Local2)
                If (Local2)
                {
                    Store (0x04, Local2)
                    Or (Local0, Local2, Local0)
                }

                If (LGreaterEqual (Local1, 0x8000))
                {
                    Subtract (0xFFFF, Local1, Local1)
                }

                Store (Arg2, Local2)
                If (LEqual (PUNT, Zero))
                {
                    Multiply (Local1, DVOT, Local1)
                    Divide (Local1, 0x03E8, Local2, Local1)
                    Multiply (Local2, 0x0A, Local2)
                }

                And (Local0, 0x02, Local3)
                If (LNot (Local3))
                {
                    Subtract (LFCC, Local2, Local3)
                    Divide (LFCC, 0xC8, Local4, Local5)
                    //If (LOr (LLess (Local3, Local5), LEqual (^^LPCB.EC0.B0PN, 0x64)))
                    If (LOr (LLess (Local3, Local5), LEqual (B1B2(^^LPCB.EC_.BPN0, ^^LPCB.EC_.BPN1), 0x64))) // EC0 to EC
                    {
                        Store (LFCC, Local2)
                    }

                    Multiply (LFCC, 0x0E, Local4)
                    Divide (Local4, 0x03E8, Local4, Local5)
                    If (LLess (Local2, Local5))
                    {
                        If (LEqual (CLFG, Zero))
                        {
                            Store (One, CLFG)
                        }
                    }
                }
                Else
                {
                    Divide (LFCC, 0xC8, Local4, Local5)
                    Subtract (LFCC, Local5, Local4)
                    If (LGreater (Local2, Local4))
                    {
                        Store (Local4, Local2)
                    }
                }

                If (LNot (^^LPCB.EC_.ACAP ())) // EC0 to EC
                {
                    Divide (Local2, 0x0A, Local3, Local4)
                    If (LLess (Local1, Local4))
                    {
                        Store (Local4, Local1)
                    }
                }

                Store (Local0, Index (PBST, Zero))
                Store (Local1, Index (PBST, One))
                Store (Local2, Index (PBST, 0x02))
                Store (Arg3, Index (PBST, 0x03))
            }
            Else
            {
                XFBS (Arg0, Arg1, Arg2, Arg3)
            }
        }
        
    } //End Scope _SB.PCI0.BAT0
    
    Scope (_SB.PCI0.LPCB.EC) //EC0 to EC
    {
        OperationRegion (XCW1, SystemMemory, 0xFEFF0380, 0x80) //ECW1 to XCW1
        Field (XCW1, ByteAcc, Lock, Preserve)
        {
            Offset (0x04),
            UDV0,    8,
            UDV1,    8,
            UDC0,    8,
            UDC1,    8,
            MXP0,    8,
            MXP1,    8,
            SUS0,    8,
            SUS1,    8,
            Offset (0x10),
            BPN0,    8,
            BPN1,    8,
            BVL0,    8,
            BVL1,    8,
            BRC0,    8,
            BRC1,    8,
            BFC0,    8,
            BFC1,    8,
            BST0,    8,
            BST1,    8,
            BCC0,    8,
            BCC1,    8,
            Offset (0x22),
            BDC0,    8,
            BDC1,    8,
            BDV0,    8,
            BDV1,    8,
            BSN0,    8,
            BSN1,    8,
            BMD0,    8,
            BMD1,    8,
            Offset (0x6A),
            EUL1,    8,
            EUL2,    8,
            ELL1,    8,
            ELL2,    8,
            CLS1,    8,
            CLS2,    8,
            ELU1,    8,
            ELU2,    8
        }
        
        //METHOD BIF0 variabile B0MD 16 (fatto)
        Method (BIF0, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                If (ECAV ())
                {
                    If (BSLF)
                    {
                        Store (Ones, Local0)
                    }
                    Else
                    {
                        Store (B1B2 (BMD0, BMD1), Local0) //Store (B0MD, Local0)
                    }
                    If (LNotEqual (Local0, 0xFFFF))
                    {
                        ShiftRight (Local0, 0x0F, Local1)
                        And (Local1, One, Local1)
                        XOr (Local1, One, Local0)
                    }
                }
                Else
                {
                    Store (Ones, Local0)
                }
                Return (Local0)
            }
            Else
            {
                XIF0 ()
            }
        }
        
        //METHOD BIF1 variabile B0DC 16 (fatto)
        Method (BIF1, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                If (ECAV ())
                {
                    If (BSLF)
                    {
                        Store (Ones, Local0)
                    }
                    Else
                    {
                        Store (B1B2 (BDC0, BDC1), Local0) //Store (B0DC, Local0)
                    }

                    And (Local0, 0xFFFF, Local0)
                }
                Else
                {
                    Store (Ones, Local0)
                }
                Return (Local0)
            }
            Else
            {
                XIF1 ()
            }
        }
        
        //METHOD BIF2 variabile B0FC 16 (fatto)
        Method (BIF2, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                If (ECAV ())
                {
                    If (BSLF)
                    {
                        Store (Ones, Local0)
                    }
                    Else
                    {
                        Store (B1B2 (BFC0, BFC1), Local0) //Store (B0FC, Local0)
                    }
                    And (Local0, 0xFFFF, Local0)
                }
                Else
                {
                    Store (Ones, Local0)
                }
                Return (Local0)
            }
            Else
            {
                XIF2 ()
            }
        }
        
        //METHOD BIF3 variabile B0MD 16 (fatto)
        Method (BIF3, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                If (ECAV ())
                {
                    If (BSLF)
                    {
                        Store (Ones, Local0)
                    }
                    Else
                    {
                        Store (B1B2 (BMD0, BMD1), Local0) //Store (B0MD, Local0)
                    }
                    If (LNotEqual (Local0, 0xFFFF))
                    {
                        ShiftRight (Local0, 0x09, Local0)
                        And (Local0, One, Local0)
                        XOr (Local0, One, Local0)
                    }
                }
                Else
                {
                    Store (Ones, Local0)
                }
                Return (Local0)
            }
            Else
            {
                XIF3 ()
            }
        }
        
        //METHOD BIF4 variabile B0DV 16 (fatto)
        Method (BIF4, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                If (ECAV ())
                {
                    If (BSLF)
                    {
                        Store (Zero, Local0)
                    }
                    Else
                    {
                        Store (B1B2 (BDV0, BDV1), Local0) //Store (B0DV, Local0)
                    }
                }
                Else
                {
                    Store (Ones, Local0)
                }
                Return (Local0)
            }
            Else
            {
                XIF4 ()
            }
        }
        
        //METHOD BIFA variabile B0SN 16 (fatto)
        Method (BIFA, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                If (ECAV ())
                {
                    If (BSLF)
                    {
                        Store (Ones, Local0)
                    }
                    Else
                    {
                        Store (B1B2 (BSN0, BSN1), Local0) //Store (B0SN, Local0)
                    }
                }
                Else
                {
                    Store (Ones, Local0)
                }
                Return (Local0)
            }
            Else
            {
                XIFA ()
            }
        }
        
        //METHOD BCRT variabile B0CC 16 (fatto)
        Method (BCRT, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                If (ECAV ())
                {
                    If (BSLF)
                    {
                        Store (Ones, Local0)
                    }
                    Else
                    {
                        Store (B1B2 (BCC0, BCC1), Local0) //Store (B0CC, Local0)
                    }
                }
                Else
                {
                    Store (Ones, Local0)
                }
                Return (Local0)
            }
            Else
            {
                XCRT ()
            }
        }
        
        //METHOD BRCP variabile B0RC 16 (fatto)
        Method (BRCP, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                If (ECAV ())
                {
                    If (BSLF)
                    {
                        Store (Ones, Local0)
                    }
                    Else
                    {
                        Store (B1B2 (BRC0, BRC1), Local0) //Store (B0RC, Local0)
                    }
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (Ones, Local0)
                    }
                }
                Else
                {
                    Store (Ones, Local0)
                }
                Return (Local0)
            }
            Else
            {
                XRCP ()
            }
        }

        //METHOD BSTS variabile B0ST 16 (fatto)
        Method (BSTS, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                If (ECAV ())
                {
                    If (BSLF)
                    {
                        Store (Ones, Local0)
                    }
                    Else
                    {
                        Store (B1B2 (BST0, BST1), Local0) //Store (B0ST, Local0)
                    }
                }
                Else
                {
                    Store (Ones, Local0)
                }
                Return (Local0)
            }
            Else
            {
                XSTS ()
            }
        }
        
        //METHOD BVOT variabile B0VL 16 (fatto)
        Method (BVOT, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                If (ECAV ())
                {
                    If (BSLF)
                    {
                        Store (Ones, Local0)
                    }
                    Else
                    {
                        Store (B1B2 (BVL0, BVL1), Local0) //Store (B0VL, Local0)
                    }
                }
                Else
                {
                    Store (Ones, Local0)
                }
                Return (Local0)
            }
            Else
            {
                XVOT ()
            }
        }
        
        //METHOD ECBM variabile EDAB 256 (fatto), B0SN 16 (fatto)
        Method (ECBM, 1, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                Name (BMB1, Buffer (0x40){})
                If (LOr (LEqual (Arg0, Zero), LEqual (Arg0, One)))
                {
                    If (LEqual (Acquire (MUEC, 0xFFFF), Zero))
                    {
                        Store (0xFA, Local0)
                        While (LAnd (Local0, And (0x0F, ESEM)))
                        {
                            Sleep (0x02)
                            Decrement (Local0)
                        }

                        If (LEqual (Arg0, Zero))
                        {
                            Store (0x8A, CMD1)
                        }

                        If (LEqual (Arg0, One))
                        {
                            Store (0x89, CMD1)
                        }

                        Store (0x0F, ESEM)
                        Store (0xFA, Local0)
                        While (LAnd (Local0, CMD1))
                        {
                            Sleep (0x02)
                            Decrement (Local0)
                        }

                        If (LAnd (LEqual (CMD1, Zero), LNotEqual (EDA1, Zero)))
                        {
                            Store (EDA1, Local0)
                            Store (RECB (0x40, 0x100), BMB1) //Store (EDAB, BMB1)
                            Name (BMB2, Buffer (Add (Local0, One)){})
                            Store (Zero, Local2)
                            While (LLess (Local2, Local0))
                            {
                                Store (DerefOf (Index (BMB1, Add (Local2, One))), Index (BMB2, Local2))
                                Increment (Local2)
                            }

                            Release (MUEC)
                            Return (BMB2)
                        }

                        Release (MUEC)
                    }
                }

                If (LEqual (Arg0, 0x02))
                {
                    Store (B1B2 (BSN0, BSN1), Local0) //Store (B0SN, Local0)
                    Store (NTOC (Local0), Index (BMB1, 0x03))
                    Store (NTOC (ShiftRight (Local0, 0x04)), Index (BMB1, 0x02))
                    Store (NTOC (ShiftRight (Local0, 0x08)), Index (BMB1, One))
                    Store (NTOC (ShiftRight (Local0, 0x0C)), Index (BMB1, Zero))
                    Return (BMB1)
                }

                Return (Package (0x08)
                {
                    0x55, 
                    0x6E, 
                    0x6B, 
                    0x6E, 
                    0x6F, 
                    0x77, 
                    0x6E, 
                    Zero
                })
            }
            Else
            {
                Return (XCBM (Arg0)) //ECBM to XCBM
            }
        }
        
        //METHOD ECDE variabile B0ST 16 (fatto)
        Method (ECDE, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                Store (B1B2 (BST0, BST1), Local0) //Store (B0ST, Local0)
                ShiftRight (Local0, 0x06, Local0)
                And (Local0, One, Local0)
                Return (Local0)
            }
            Else
            {
                XCDE ()
            }
        }        
        
        //METHOD _QA8 variabile EULV 16, ELLV 16, CALS 16, ELUX 16
        Method (_QA8, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Store (^ALSD.SWAP (B1B2 (ELU1, ELU2)), Local0) //Store (^ALSD.SWAP (ELUX), Local0)
                Store (^ALSD.ALSC (Local0), Local0)
                Store (Local0, ^ALSD.ALSI)
                W16B (CLS1, CLS2, ^ALSD.SWAP (Local0)) //Store (^ALSD.SWAP (Local0), CALS)
                Store (^ALSD.GUPV (Local0), Local1)
                Store (^ALSD.GLOV (Local0), Local2)
                Store (^ALSD.ALRC (Local1), Local1)
                Store (^ALSD.ALRC (Local2), Local2)
                W16B (EUL1, EUL2, ^ALSD.SWAP (Local1)) //Store (^ALSD.SWAP (Local1), EULV)
                W16B (ELL1, ELL2, ^ALSD.SWAP (Local2)) //Store (^ALSD.SWAP (Local2), ELLV)
                Store (One, BALS)
                Notify (ALSD, 0x80)
            }
            Else
            {
                XQA8 ()
            }
        }
        
        //METHOD _QA9 variabile EULV 16, ELLV 16, CALS 16, ELUX 16
        Method (_QA9, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Store (RRAM (0x0CEC), Local0)
                Store (RRAM (0x0CED), Local1)
                ShiftLeft (Local0, 0x08, Local0)
                Add (Local0, Local1, Local0)
                Store (Local0, ALSK)
                Store (^ALSD.SWAP (B1B2 (ELU1, ELU2)), Local0) //Store (^ALSD.SWAP (ELUX), Local0)
                Store (^ALSD.ALSC (Local0), Local0)
                Store (Local0, ^ALSD.ALSI)
                W16B (CLS1, CLS2, ^ALSD.SWAP (Local0)) //Store (^ALSD.SWAP (Local0), CALS)
                Store (^ALSD.GUPV (Local0), Local1)
                Store (^ALSD.GLOV (Local0), Local2)
                Store (^ALSD.ALRC (Local1), Local1)
                Store (^ALSD.ALRC (Local2), Local2)
                W16B (EUL1, EUL2, ^ALSD.SWAP (Local1)) //Store (^ALSD.SWAP (Local1), EULV)
                W16B (ELL1, ELL2, ^ALSD.SWAP (Local2)) //Store (^ALSD.SWAP (Local2), ELLV)
                Store (One, BALS)
                Notify (ALSD, 0x80)
                ADBG ("Update-ALS-K")
            }
            Else
            {
                XQA9 ()
            }
        }
        
        
        Scope (ALSD)
        {
            Method (_INI, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                    Store (SWAP (B1B2 (ELU1, ELU2)), Local0) //Store (SWAP (ELUX), Local0)
                    Store (ALSC (Local0), Local0)
                    Store (SWAP (Local0), Local3)
                    W16B (CLS1, CLS2, Local3) //Store (Local3, CALS)
                    Store (Local0, ALSI)
                    Store (GUPV (Local0), Local1)
                    Store (GLOV (Local0), Local2)
                    Store (ALRC (Local1), Local1)
                    Store (ALRC (Local2), Local2)
                    W16B (EUL1, EUL2, SWAP (Local1)) //Store (SWAP (Local1), EULV)
                    W16B (ELL1, ELL2, SWAP (Local2)) //Store (SWAP (Local2), ELLV)
                    Store (One, BALS)
                }
                Else
                {
                    XINI ()
                }
            }
            
            Method (S3WK, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                    W16B (EUL1, EUL2, SULV) //Store (SULV, EULV)
                    W16B (ELL1, ELL2, SLLV) //Store (SLLV, ELLV)
                    Store (One, BALS)
                }
                Else
                {
                    X3WK ()
                }
            }
            
            Method (S3PT, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                    Store (B1B2 (EUL1, EUL2), SULV) //Store (EULV, SULV)
                    Store (B1B2 (ELL1, ELL2), SLLV) //Store (ELLV, SLLV)
                }
                Else
                {
                    X3PT ()
                }
            }
        }//End Scope ALSD
        
        
        
        
        
        
        
        
        
        
        
        Method (RE1B, 1, NotSerialized)
        {
            Local0 = ( 0xFEFF0A00 + Arg0) // Offset OperationRegionECWB
            OperationRegion(ECWB, SystemMemory, Local0, 0x80)
            Field(ECWB, ByteAcc, Lock, Preserve) { BYTE, 8 }
            Return (BYTE) /* \RE1B.BYTE */
        }
        
        Method (RECB, 2, Serialized)
        {
            //Arg0 - offset in bytes from zero-based \_SB.PCI0.LPCB.EC0
            //Arg1 - size of buffer in bits
            Arg1 = ((Arg1 + 0x07) >> 0x03)
            Name(TEMP, Buffer(Arg1) { })
            Arg1 += Arg0
            Local0 = Zero
            While ((Arg0 < Arg1))
            {
                Store(RE1B(Arg0), Index(TEMP, Local0))
                Increment(Arg0)
                Increment(Local0)
            }
            Return (TEMP)
        }
        /*
        Method (WE1B, 2, NotSerialized)
        {
            Local0 = ( 0xFEFF0A00 + Arg0) // Offset OperationRegionECWB
            OperationRegion(ECWB, EmbeddedControl, Local0, 0x80)
            Field(ECWB, ByteAcc, Lock, Preserve) { BYTE, 8 }
            BYTE = Arg1
        }
        
        Method (WECB, 3, Serialized)
        {
            //Arg0 - offset in bytes from zero-based EC
            //Arg1 - size of buffer in bits
            //Arg2 - value to write
            Arg1 = ((Arg1 + 0x07) >> 0x03)
            Name(TEMP, Buffer(Arg1) { })
            TEMP = Arg2
            Arg1 += Arg0
            Local0 = Zero
            While ((Arg0 < Arg1))
            {
                WE1B(Arg0, DerefOf(Index(TEMP, Local0)))
                Increment(Arg0)
                Increment(Local0)
            }
        }
        */
    } //End Scope _SB.PCI0.LPCB.EC
    
    /*
    Scope (_SB.TPWR)
    {
        Method (ACUR, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                If (LEqual (PSRC (), Zero))
                {
                    Return (Zero)
                }

                Return (B1B2 (\_SB.PCI0.LPCB.EC_.UDC0, \_SB.PCI0.LPCB.EC_.UDC1)) //Return (\_SB.PCI0.LPCB.EC0.URDC)
            }
            Else
            {
                XCUR ()
            }
        }
        
        Method (AVOL, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                If (LEqual (PSRC (), Zero))
                {
                    Return (Zero)
                }

                Return (B1B2 (\_SB.PCI0.LPCB.EC_.UDV0, \_SB.PCI0.LPCB.EC_.UDV1)) //Return (\_SB.PCI0.LPCB.EC0.UPDV)
            }
            Else
            {
                XVOL ()
            }
        }
        
        Method (PBSS, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Return (B1B2 (\_SB.PCI0.LPCB.EC_.SUS0, \_SB.PCI0.LPCB.EC_.SUS1)) //Return (\_SB.PCI0.LPCB.EC0.SUSP)
            }
            Else
            {
                XBSS ()
            }
        }
        
        Method (PMAX, 0, Serialized)
        {
            If (_OSI ("Darwin"))
            {
                Return (B1B2 (\_SB.PCI0.LPCB.EC_.MXP0, \_SB.PCI0.LPCB.EC_.MXP1)) //Return (\_SB.PCI0.LPCB.EC0.MAXP)
            }
            Else
            {
                XMAX ()
            }
        }
        
        Method (PSOC, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If (LEqual (\_SB.PCI0.LPCB.EC_.ECAV (), Zero))
                {
                    Return (Zero)
                }

                If (LEqual (B1B2 (\_SB.PCI0.LPCB.EC_.BFC0, \_SB.PCI0.LPCB.EC_.BFC1), Zero)) //If (LEqual (\_SB.PCI0.LPCB.EC0.B0FC, Zero))
                {
                    Return (Zero)
                }

                If (LGreater (B1B2 (\_SB.PCI0.LPCB.EC_.BRC0, \_SB.PCI0.LPCB.EC_.BRC1), B1B2 (\_SB.PCI0.LPCB.EC_.BFC0, \_SB.PCI0.LPCB.EC_.BFC1))) //If (LGreater (\_SB.PCI0.LPCB.EC0.B0RC, \_SB.PCI0.LPCB.EC0.B0FC))
                {
                    Return (Zero)
                }

                If (LEqual (B1B2 (\_SB.PCI0.LPCB.EC_.BRC0, \_SB.PCI0.LPCB.EC_.BRC1), B1B2 (\_SB.PCI0.LPCB.EC_.BFC0, \_SB.PCI0.LPCB.EC_.BFC1))) //If (LEqual (\_SB.PCI0.LPCB.EC0.B0RC, \_SB.PCI0.LPCB.EC0.B0FC))
                {
                    Return (0x64)
                }

                If (LLess (B1B2 (\_SB.PCI0.LPCB.EC_.BRC0, \_SB.PCI0.LPCB.EC_.BRC1), B1B2 (\_SB.PCI0.LPCB.EC_.BFC0, \_SB.PCI0.LPCB.EC_.BFC1))) //If (LLess (\_SB.PCI0.LPCB.EC0.B0RC, \_SB.PCI0.LPCB.EC0.B0FC))
                {
                    Multiply (B1B2 (\_SB.PCI0.LPCB.EC_.BRC0, \_SB.PCI0.LPCB.EC_.BRC1), 0x64, Local0) //Multiply (\_SB.PCI0.LPCB.EC0.B0RC, 0x64, Local0)
                    Divide (Local0, B1B2 (\_SB.PCI0.LPCB.EC_.BFC0, \_SB.PCI0.LPCB.EC_.BFC1), Local2, Local1) //Divide (Local0, \_SB.PCI0.LPCB.EC0.B0FC, Local2, Local1)
                    Divide (Local2, 0x64, , Local2)
                    Divide (B1B2 (\_SB.PCI0.LPCB.EC_.BFC0, \_SB.PCI0.LPCB.EC_.BFC1), 0xC8, , Local3) //Divide (\_SB.PCI0.LPCB.EC0.B0FC, 0xC8, , Local3)
                    If (LGreaterEqual (Local2, Local3))
                    {
                        Add (Local1, One, Local1)
                    }

                    Return (Local1)
                }
                Else
                {
                    Return (Zero)
                }
            }
            Else
            {
                XSOC ()
            }
        }
    } //End Scope _SB.TPWR
    */  
#ifndef NO_DEFINITIONBLOCK
}
#endif