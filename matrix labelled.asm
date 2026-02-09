        processor 6502
        org $8000

; --- CBM80 cartridge header ---
WarmVec: .word $8009           ; warm start vector
ColdVec: .word $8009           ; cold start vector
        .byte $C3,$C2,$CD,$38,$30    ; "CBM80" (PETSCII, high bit set)

; --- Code entry ---
Start:
        LDX #$FF
        TXS
        LDA #$01
        STA $13
        JMP L9FFA
L8013:
        LDA #$08
        STA $5A
L8017:
        DEY
        BNE L8017
        DEC $5A
        BNE L8017
        RTS
        .byte $D0,$F2,$60
L8022:
        LDA #$04
        STA $49
        LDA #$00
        STA $48
        LDX #$00
L802C:
        LDA $48
        STA $0340,X
        LDA $49
        STA $0360,X
        LDA $48
        CLC
        ADC #$28
        STA $48
        LDA $49
        ADC #$00
        STA $49
        INX
        CPX #$18
        BNE L802C
        RTS
L8049:
        LDX $03
        LDY $02
        LDA $0340,X
        STA $48
        LDA $0360,X
        STA $49
        RTS
L8058:
        JSR L8049
        LDA ($48),Y
        RTS
L805E:
        JSR L8049
        LDA $04
        STA ($48),Y
        LDA $49
        CLC
        ADC #$D4
        STA $49
        LDA $05
        STA ($48),Y
        RTS
L8071:
        LDX #$00
L8073:
        LDA #$20
        STA $0400,X
        STA $0500,X
        STA $0600,X
        STA $0700,X
        DEX
        BNE L8073
        RTS
L8085:
        LDA #$00
        LDX #$18
L8089:
        STA $D400,X
        DEX
        BNE L8089
        LDA #$00
        STA $4000
        STA $D40C
        STA $D413
        LDA #$30
        LDX #$07
L809E:
        STA $14F0,X
        DEX
        BNE L809E
        LDA #$A0
        STA $D406
        STA $D40D
        STA $D414
        LDA #$80
        STA $0291
        LDA #$00
        NOP
        STA $D021
        STA $D020
        LDA #$18
        STA $D018
        JSR L8071
        JSR L8022
        JMP L80FB
L80CB:
        LDA #$11
        STA $D40B
        RTS
L80D1:
        LDA #$21
        STA $D412
        RTS
L80D7:
        LDA #$81
        STA $D404
        RTS
L80DD:
        LDA #$00
        STA $D412
        STA $D404
        STA $D40B
        RTS
L80E9:
        LDX #$2E
L80EB:
        LDA $8103,X
        STA $03FF,X
        LDA $8131,X
        STA $D7FF,X
        DEX
        BNE L80EB
        RTS
L80FB:
        JSR L80E9
        JSR L9880
        JMP L81BC
        .byte $23,$24,$22,$25,$26,$27,$20,$19,$1A,$20,$30,$30,$30,$30,$30,$30
	;byte $30,$20,$20,$07,$20,$35 this last byte is the number of ships
        .byte $30,$20,$20,$07,$20,$39,$20,$53,$48,$49,$50,$53,$20,$52,$45,$4D
        .byte $41,$49,$4E,$49,$4E,$47,$20,$20,$21,$21,$21,$21,$21,$21,$43,$43
        .byte $43,$43,$43,$43,$40,$44,$44,$40,$47,$47,$47,$47,$47,$47,$47,$40
        .byte $40,$45,$40,$43,$40,$44,$44,$44,$44,$44,$43,$47,$47,$47,$47,$47
        .byte $47,$47,$47,$47,$47,$47,$44,$44,$44,$44,$44,$44,$06,$02,$04,$05
        .byte $03,$07,$01
L8167:
        JSR L80DD
        LDA #$0F
        STA $D418
        RTS
L8170:
        LDX $02
L8172:
        LDY $03
L8174:
        DEY
        BNE L8174
        DEX
        BNE L8172
        RTS
L817B:
        LDA #$04
        STA $49
        LDA #$A0
        STA $48
L8183:
        LDA #$00
        LDY #$26
L8187:
        STA ($48),Y
        DEY
        BNE L8187
        LDA $49
        PHA
        CLC
        ADC #$D4
        STA $49
        LDX $06
        LDA $815F,X
        LDY #$26
L819B:
        STA ($48),Y
        DEY
        BNE L819B
        LDA $48
        ADC #$28
        STA $48
        PLA
        ADC #$00
        STA $49
        INC $06
        LDA $06
        CMP #$08
        BNE L81B7
        LDA #$01
        STA $06
L81B7:
        DEC $07
        BNE L8183
        RTS
L81BC:
        LDA #$02
        STA $D40F
        LDA #$03
        STA $D408
        JSR L80CB
        JSR L80D1
        LDA #$00
        LDX #$08
L81D0:
        STA $1FFF,X
        DEX
        BNE L81D0
        LDA #$13
        STA $08
        LDA #$01
        STA $09
L81DE:
        LDA $09
        STA $06
        LDA #$14
        SEC
        SBC $08
        STA $07
        LDA $4000
        STA $D418
        INC $4000
        LDA $4000
        CMP #$10
        BNE L81FC
        DEC $4000
L81FC:
        JSR L817B
        LDX #$00
L8201:
        LDA #$FF
        STA $2000,X
        TXA
        PHA
        LDA #$80
        STA $02
        LDA #$10
        STA $03
        JSR L8170
        PLA
        TAX
        JSR L8013
        LDA #$00
        STA $2000,X
        INX
        CPX #$08
        BNE L8201
        DEC $09
        BNE L822A
        LDA #$07
        STA $09
L822A:
        DEC $08
        BNE L81DE
        LDX #$08
L8230:
        LDA #$FF
        STA $1FFF,X
        TXA
        PHA
        LDA #$F0
        STA $02
        LDA #$10
        STA $03
        JSR L8170
        PLA
        TAX
        DEX
        BNE L8230
        LDA #$66
        LDX #$00
L824B:
        STA $D878,X
        STA $D900,X
        STA $DA00,X
        STA $DB00,X
        INX
        BNE L824B
        LDA #$03
        STA $06
        LDA #$00
        STA $07
        JSR L80DD
        JSR L80CB
L8268:
        LDX #$60
        LDA #$0F
        STA $4000
L826F:
        STX $D408
        LDY #$00
L8274:
        DEY
        BNE L8274
        DEX
        BNE L826F
        LDY #$08
L827C:
        LDX $07
        LDA $22D8,X
        STA $1FFF,Y
        INC $07
        DEY
        BNE L827C
        LDA $4000
        SBC #$04
        STA $4000
        STA $D418
        DEC $06
        BNE L8268
L8298:
        JSR L9300
        JSR L80DD
        JSR L9382
        LDA #$90
        STA $4001
        STA $D401
        JSR L80D7
        LDA #$15
        STA $0B
        LDA #$14
        STA $0A
        LDA #$09
        STA $06
L82B8:
        LDA #$0F
        SEC
        SBC $06
        STA $D418
        LDA $0A
        SEC
        SBC $06
        STA $02
        LDA $0B
        SBC $06
        SEC
        STA $03
        LDA #$00
        STA $04
        LDA #$66
        STA $05
        JSR L805E
        LDA $0A
        CLC
        ADC $06
        STA $02
        JSR L805E
        DEC $06
        DEC $02
        INC $03
        LDA #$17
        STA $04
        LDA #$03
        STA $05
        JSR L805E
        LDA $0A
        SEC
        SBC $06
        STA $02
        DEC $04
        JSR L805E
        LDA $06
        CLC
        ADC #$01
        ASL
        ASL
        ASL
        STA $02
        LDA #$00
        STA $03
        JSR L8170
        LDA $06
        CMP #$00
        BNE L82B8
        JSR L80DD
        LDA #$0F
        STA $4000
        JSR L80D1
        LDA #$03
        STA $06
L8326:
        LDA #$65
        CLC
        ADC $06
        LDX #$00
L832D:
        STA $D878,X
        STA $D900,X
        STA $DA00,X
        STA $DB00,X
        DEX
        BNE L832D
        LDA $0A
        STA $02
        LDA $0B
        STA $03
        LDA #$07
        STA $04
        LDA #$05
        STA $05
        JSR L805E
        LDA #$C0
        STA $4004
L8354:
        LDY #$00
L8356:
        DEY
        BNE L8356
        DEC $4004
        LDA $4004
        STA $D40F
        CMP #$80
        BNE L8354
        LDA $4000
        SBC #$05
        STA $4000
        STA $D418
        DEC $06
        BNE L8326
        JSR L8167
        LDA #$00
        LDX #$20
L837C:
        STA $1320,X
        DEX
        BNE L837C
        STA $10
        STA $17
        STA $39
        STA $1E
        STA $28
        STA $31
        STA $36
        STA $3D
        STA $40
        STA $0E
        LDA #$03
        STA $15
        LDA #$01
        STA $14
        STA $16
        LDA #$02
        STA $35
        LDA #$20
        STA $26
        STA $27
        STA $2D
        STA $2E
        LDA #$13
        STA $29
        LDA #$40
        STA $2B
        STA $2C
        LDA #$04
        STA $41
        LDA #$0F
        STA $4000
        STA $D418
L83C4:
        JSR L83F5
        JSR L8530
        JSR L85C6
        JSR L8699
        JSR L893E
        JSR L90E5
        JSR L850A
        JMP L83C4
L83DC:
        LDA $DC01
        EOR #$1F
        STA $0D
        RTS
        .byte $02,$0D,$0E,$0F,$10,$11,$12,$0A,$08,$03,$04,$05,$06,$0A,$13,$14
        .byte $15
L83F5:
        DEC $0E
        DEC $0E
        BEQ L8405
        LDA $0E
        CMP #$80
        BEQ L8402
        RTS
L8402:
        JMP L84EB
L8405:
        JSR L83DC
        JSR L94A6
        LDA $0A
        STA $02
        CMP #$03
        BEQ L8417
        CMP #$25
        BNE L841D
L8417:
        LDA $41
        AND #$FB
        STA $41
L841D:
        LDA $0B
        STA $03
        LDA #$00
        STA $04
        LDA #$66
        STA $05
        JSR L805E
        LDA $0D
        AND #$01
        BEQ L843C
        DEC $03
        LDA $03
        CMP #$06
        BNE L843C
        INC $03
L843C:
        LDA $0D
        AND #$02
        BEQ L844C
        INC $03
        LDA $03
        CMP #$16
        BNE L844C
        DEC $03
L844C:
        LDA #$00
        STA $0C
        LDA $0D
        AND #$04
        BEQ L8464
        LDA #$01
        STA $0C
        DEC $02
        BNE L8464
        INC $02
        LDA #$00
        STA $0C
L8464:
        LDA $0D
        AND #$08
        BEQ L847C
        LDA #$02
        STA $0C
        INC $02
        LDA $02
        CMP #$27
        BNE L847C
        DEC $02
        LDA #$00
        STA $0C
L847C:
        JSR L882E
        LDA $0D
        AND #$10
        BEQ L84A2
        LDA $10
        BNE L84A2
        LDA $0A
        STA $11
        LDA $0B
        STA $12
        DEC $12
        LDA #$01
        STA $10
        LDA #$70
        STA $4001
        STA $D401
        JSR L80D7
L84A2:
        LDA $0C
        BNE L84B9
L84A6:
        LDA $0A
        STA $02
        LDA $0B
        STA $03
        LDA #$07
        STA $04
        LDA #$05
        STA $05
        JMP L805E
L84B9:
        LDA $0B
        STA $03
        LDA #$05
        STA $05
        LDA $0C
        CMP #$02
        BEQ L84D9
        LDA #$0B
        STA $04
        LDA $0A
        STA $02
        JSR L805E
        INC $04
        INC $02
        JMP L805E
L84D9:
        LDA #$0C
        STA $04
        LDA $0A
        STA $02
        JSR L805E
        DEC $04
        DEC $02
        JMP L805E
L84EB:
        LDA $0C
        BNE L84F0
        RTS
L84F0:
        JSR L84A6
        LDA #$00
        STA $04
        LDA #$66
        STA $05
        INC $02
        LDA $0C
        CMP #$02
        BNE L8507
        DEC $02
        DEC $02
L8507:
        JMP L805E
L850A:
        LDA #$06
        LDA $C5
        CMP #$40
        BNE L8513
L8512:
        RTS
L8513:
        LDA $028D
        AND #$07
        CMP #$07
        BEQ L852D
        CMP #$02
        BNE L8512
L8520:
        LDA $C5
        CMP #$40
        BNE L8520
L8526:
        LDA $C5
        CMP #$40
        BEQ L8526
        RTS
L852D:
        JMP L94B6
L8530:
        DEC $13
        BEQ L8535
L8534:
        RTS
L8535:
        LDA #$20
        STA $13
        LDA $4001
        BEQ L8551
        DEC $4001
        DEC $4001
        LDA $4001
        STA $D401
        BNE L8551
        LDA #$00
        STA $D404
L8551:
        LDA $10
        BEQ L8534
        AND #$F0
        BEQ L856E
        CMP #$10
        BNE L8560
        JMP L9010
L8560:
        CMP #$20
        BNE L8567
        JMP L90A4
L8567:
        CMP #$30
        BNE L856E
        JMP L905F
L856E:
        LDA $10
        AND #$02
        BNE L8590
        LDA #$01
        STA $05
        LDA $11
        STA $02
        LDA $12
        STA $03
        JSR L8856
        LDA #$09
        STA $04
        LDA $10
        EOR #$02
        STA $10
        JMP L805E
L8590:
        LDA $11
        STA $02
        LDA $12
        STA $03
        LDA #$66
        STA $05
        LDA #$00
        STA $04
        JSR L805E
        DEC $12
        DEC $03
        LDA $03
        CMP #$02
        BNE L85B2
        LDA #$00
        STA $10
        RTS
L85B2:
        LDA #$01
        STA $05
        LDA #$08
        STA $04
        LDA $10
        EOR #$02
        STA $10
        JSR L8856
        JMP L805E
L85C6:
        LDA $0E
        CMP #$30
        BEQ L85CD
L85CC:
        RTS
L85CD:
        DEC $16
        BNE L85CC
        JSR L88AE
        LDA #$02
        STA $16
        JSR L93F3
        JSR L8794
        LDA $17
        BNE L8616
        LDA #$3C
        STA $04
        LDA #$03
        STA $05
        LDA #$00
        STA $02
        LDA $15
        STA $03
        JSR L805E
        INC $04
        INC $03
        JSR L805E
        LDA #$16
        STA $03
        LDA #$3A
        STA $04
        LDA $14
        STA $02
        JSR L805E
        INC $02
        INC $04
        LDA #$01
        STA $17
        JMP L805E
L8616:
        LDA #$20
        STA $04
        LDA #$00
        STA $02
        LDA $15
        STA $03
        JSR L805E
        INC $03
        JSR L805E
        LDA #$16
        STA $03
        LDA $14
        STA $02
        JSR L805E
        INC $02
        JSR L805E
        INC $14
        LDA $14
        CMP #$27
        BNE L8646
        LDA #$01
        STA $14
L8646:
        INC $15
        LDA $15
        CMP #$16
        BNE L8652
        LDA #$03
        STA $15
L8652:
        LDA #$00
        STA $17
        LDA #$03
        STA $05
        LDA $14
        STA $02
        LDA #$02
        STA $04
        JSR L805E
        LDA #$00
        STA $02
        LDA $15
        STA $03
        LDA #$01
        STA $04
        JSR L805E
        LDA $36
        AND #$80
        BEQ L8684
        LDA $14
        CMP $0A
        BNE L8684
        LDA #$01
        STA $18
L8684:
        LDA $18
        BEQ L869F
        DEC $18
        BNE L869F
        LDA $14
        STA $1B
        LDA $15
        STA $1C
        LDA #$01
        STA $1A
        RTS
L8699:
        LDA $13
        CMP #$02
        BEQ L86A0
L869F:
        RTS
L86A0:
        JSR L88B8
        JSR L8CDB
        LDA $18
        BNE L869F
        LDA $1A
        CMP $1B
        BEQ L86DF
        LDA #$00
        STA $04
        LDA #$66
        STA $05
        LDA $1A
        STA $02
        LDA $1C
        STA $03
        JSR L805E
        INC $1A
        INC $02
        JMP L86CD
L86CA:
        JMP L94D3
L86CD:
        LDA #$01
        STA $05
        INC $1D
        LDA $1D
        AND #$01
        CLC
        ADC #$03
        STA $04
        JSR L805E
L86DF:
        LDA #$15
        STA $03
        LDA $1B
        STA $02
        LDA $1D
        AND #$01
        CLC
        ADC #$05
        STA $04
L86F0:
        JSR L805E
        DEC $03
        LDA $03
        CMP #$02
        BNE L86F0
        LDA $1B
        CMP $0A
        BEQ L86CA
        LDA $1A
        CMP $1B
        BEQ L8708
        RTS
L8708:
        LDA #$15
        STA $03
        LDA #$66
        STA $05
        LDA #$00
        STA $04
        LDA $1B
        STA $02
L8718:
        JSR L805E
        DEC $03
        LDA $03
        CMP #$02
        BNE L8718
        LDA $1C
        STA $03
        LDA #$07
        STA $05
        LDA #$0F
        STA $04
        JSR L805E
        LDA $19
        STA $18
        LDA #$A0
        STA $06
        LDA #$04
        STA $07
        LDA $41
        ORA #$08
        STA $41
        LDY #$00
L8746:
        LDA ($06),Y
        BEQ L874D
        JSR L875A
L874D:
        INC $06
        BNE L8746
        INC $07
        LDA $07
        CMP #$08
        BNE L8746
        RTS
L875A:
        CMP #$20
        BNE L875F
        RTS
L875F:
        LDX #$07
L8761:
        CMP $83E3,X
        BEQ L876A
        DEX
        BNE L8761
        RTS
L876A:
        LDA $83E4,X
        STA ($06),Y
        LDA $41
        AND #$F7
        STA $41
        CPX #$07
        BEQ L877A
        RTS
L877A:
        LDX #$20
L877C:
        LDA $1320,X
        BEQ L8789
        DEX
        BNE L877C
        LDA #$0D
        STA ($06),Y
        RTS
L8789:
        LDA $06
        STA $1300,X
        LDA $07
        STA $1320,X
        RTS
L8794:
        LDX #$20
L8796:
        LDA $1320,X
        BEQ L879E
        JSR L87AA
L879E:
        DEX
        BNE L8796
        RTS
        .byte $07,$0B,$0C,$0C,$20,$02,$3A,$3B
L87AA:
        STX $08
        LDA $1300,X
        STA $06
        LDA $1320,X
        STA $07
        LDY #$00
        TYA
        STA ($06),Y
        LDA $07
        PHA
        CLC
        ADC #$D4
        STA $07
        LDA #$66
        STA ($06),Y
        PLA
        STA $07
        LDA $06
        CLC
        ADC #$28
        STA $06
        LDA $07
        ADC #$00
        STA $07
        LDA ($06),Y
        LDX #$04
L87DB:
        CMP $87A1,X
        BNE L87E3
        JMP L86CA
L87E3:
        CMP $87A5,X
        BEQ L8807
        DEX
        BNE L87DB
        LDA #$0A
        STA ($06),Y
        LDA $07
        PHA
        CLC
        ADC #$D4
        STA $07
        LDA #$01
        STA ($06),Y
        LDX $08
        LDA $06
        STA $1300,X
        PLA
        STA $1320,X
        RTS
L8807:
        LDX $08
        LDA #$00
        STA $1320,X
        RTS
L880F:
        JSR L8058
        BEQ L8825
        LDX $83EC
L8817:
        CMP $83EC,X
        BEQ L8822
        DEX
        BNE L8817
        STX $0C
        RTS
L8822:
        JMP L86CA
L8825:
        LDA $02
        STA $0A
        LDA $03
        STA $0B
        RTS
L882E:
        LDA $02
        CMP $0A
        BEQ L880F
        LDA $03
        CMP $0B
        BEQ L880F
        LDA $02
        PHA
        LDA $0A
        STA $02
        JSR L8058
        BNE L884C
        PLA
        STA $02
        JMP L880F
L884C:
        LDA $0B
        STA $03
        PLA
        STA $02
        JMP L880F
L8856:
        JSR L8058
        CMP #$08
        BEQ L8893
        LDX #$07
L885F:
        CMP $83E3,X
        BEQ L886A
        DEX
        BNE L885F
        JMP L8B81
L886A:
        LDA $83E2,X
        STA $04
        LDA #$07
        STA $05
        CPX #$02
        BNE L888A
        LDA #$00
        STA $04
        LDA #$66
        STA $05
        LDX #$06
        LDY #$01
        JSR L8894
        LDA #$04
        STA $1E
L888A:
        JSR L805E
        LDA #$00
        STA $10
        PLA
        PLA
L8893:
        RTS
L8894:
        TXA
        PHA
L8896:
        INC $0409,X
        LDA $0409,X
        CMP #$3A
        BNE L88A8
        LDA #$30
        STA $0409,X
        DEX
        BNE L8896
L88A8:
        PLA
        TAX
        DEY
        BNE L8894
        RTS
L88AE:
        LDA $2109
        ROL
        ADC #$00
        STA $1509
        RTS
L88B8:
        JSR L88FD
        LDA $1E
        BNE L88C0
        RTS
L88C0:
        LDA $4003
        CMP #$16
        BNE L88DD
        LDA $1E
        ASL
        ASL
        CLC
        ADC $1E
        STA $D418
        LDA #$10
        STA $4003
        STA $D408
        JSR L80CB
        RTS
L88DD:
        INC $4003
        LDA $4003
        STA $D408
        CMP #$16
        BEQ L88EB
L88EA:
        RTS
L88EB:
        DEC $1E
        BNE L88EA
        LDA #$0F
        STA $D418
        STA $4003
        LDA #$00
        STA $D40B
        RTS
L88FD:
        LDA $3D
        BNE L892A
        LDA $39
        BNE L8906
        RTS
L8906:
        LDA $4004
        CMP #$30
        BEQ L8917
        DEC $4004
        LDA $4004
        STA $D40F
        RTS
L8917:
        DEC $39
        BEQ L8924
        LDA #$40
        STA $4004
        JSR L80D1
        RTS
L8924:
        LDA #$00
        STA $D412
L8929:
        RTS
L892A:
        DEC $3D
        LDA $3D
        STA $D418
        BNE L8929
        LDA #$00
        STA $D412
        LDA #$0F
        STA $D418
        RTS
L893E:
        DEC $22
        LDA $22
        CMP #$01
        BEQ L8947
L8946:
        RTS
L8947:
        LDA #$C0
        STA $22
        JSR L8F3D
        LDA $25
        BNE L8955
        JMP L89CC
L8955:
        LDA $26
        BEQ L8946
        CMP #$01
        BEQ L8962
        DEC $26
        JMP L89CC
L8962:
        LDA $24
        CMP $23
        BNE L89A3
        INC $28
        LDX $28
        LDA #$03
        STA $1980,X
        LDA $D012
        AND #$01
        BEQ L8985
        LDA #$1A
        STA $1900,X
        LDA #$81
        STA $1A00,X
        JMP L898F
L8985:
        LDA #$1C
        STA $1900,X
        LDA #$80
        STA $1A00,X
L898F:
        LDA $3F
        AND #$80
        BEQ L89A3
        LDA $25
        AND #$01
        BEQ L89A3
        LDA $1A00,X
        ORA #$04
        STA $1A00,X
L89A3:
        INC $28
        LDX $28
        LDA #$1B
        STA $1900,X
        LDA #$03
        STA $1980,X
        LDA #$00
        STA $1A00,X
        DEC $24
        BEQ L89BD
        JMP L89CC
L89BD:
        LDA #$40
        STA $1A00,X
        LDA $27
        STA $26
        LDA $23
        STA $24
        DEC $25
L89CC:
        INC $29
        LDA $29
        CMP #$15
        BNE L89D8
        LDA #$13
        STA $29
L89D8:
        LDX $28
        LDA $28
        BNE L89DF
        RTS
L89DF:
        LDA $1A00,X
        AND #$80
        BNE L89E9
        JMP L8A92
L89E9:
        JSR L8C73
        LDA $1A00,X
        AND #$04
        BEQ L89F6
        JMP L8AE2
L89F6:
        LDA $1900,X
        STA $02
        LDA $1980,X
        STA $03
        LDA $1A00,X
        AND #$40
        BEQ L8A16
        LDA #$00
        STA $04
        LDA #$66
        STA $05
        STX $07
        JSR L805E
        LDX $07
L8A16:
        LDA $1A00,X
        AND #$01
        BEQ L8A21
        DEC $02
        DEC $02
L8A21:
        INC $02
        LDA $02
        BEQ L8A2E
        CMP #$27
        BEQ L8A2E
        JMP L8A31
L8A2E:
        JMP L8A6E
L8A31:
        STX $07
        JSR L8058
        LDX $07
        CMP #$00
        BEQ L8A4E
        CMP #$07
        BEQ L8A4B
        CMP #$0B
        BEQ L8A4B
        CMP #$0C
        BEQ L8A4B
        JMP L8A6E
L8A4B:
        JMP L86CA
L8A4E:
        LDA $02
        STA $1900,X
        LDA $03
        STA $1980,X
        LDA #$03
        STA $05
        LDA $29
        STA $04
        STX $07
        JSR L805E
        LDX $07
L8A67:
        DEX
        BEQ L8A6D
        JMP L89DF
L8A6D:
        RTS
L8A6E:
        INC $03
        LDA $1900,X
        STA $02
        LDA $1A00,X
        EOR #$01
        STA $1A00,X
        LDA $03
        CMP #$15
        BNE L8A4E
        DEC $03
        LDA $1A00,X
        EOR #$01
        ORA #$06
        STA $1A00,X
        JMP L8A4E
L8A92:
        LDA $1900,X
        STA $02
        LDA $1980,X
        STA $03
        LDA #$00
        STA $04
        LDA #$66
        STA $05
        LDA $1A00,X
        AND #$40
        BEQ L8AB2
        STX $07
        JSR L805E
        LDX $07
L8AB2:
        LDA $18FF,X
        STA $1900,X
        STA $02
        LDA $197F,X
        STA $1980,X
        STA $03
        STX $07
        JSR L8058
        LDX $07
        CMP #$07
        BNE L8AD0
        JMP L86CA
L8AD0:
        LDA #$03
        STA $05
        LDA #$13
        STA $04
        STX $07
        JSR L805E
        LDX $07
        JMP L8A67
L8AE2:
        LDA $1900,X
        STA $02
        LDA $1980,X
        STA $03
        LDA #$00
        STA $04
        LDA #$66
        STA $05
        LDA $1A00,X
        AND #$40
        BEQ L8B02
        STX $07
        JSR L805E
        LDX $07
L8B02:
        LDA $1A00,X
        STA $08
        AND #$01
        BEQ L8B0F
        DEC $02
        DEC $02
L8B0F:
        INC $02
        LDA $08
        AND #$02
        BEQ L8B1B
        DEC $03
        DEC $03
L8B1B:
        INC $03
        STX $07
        JSR L8058
        LDX $07
        CMP #$07
        BEQ L8B37
        CMP #$0B
        BEQ L8B37
        CMP #$0C
        BNE L8B3A
        CMP #$00
        BEQ L8B3A
        JMP L8B5A
L8B37:
        JMP L86CA
L8B3A:
        LDA #$00
        STA $09
        LDA $02
        BEQ L8B5A
        CMP #$27
        BEQ L8B5A
L8B46:
        LDA $03
        CMP #$02
        BEQ L8B6D
        CMP #$16
        BEQ L8B6D
L8B50:
        LDA $09
        BNE L8B57
        JMP L8A4E
L8B57:
        JMP L8B02
L8B5A:
        LDA $08
        EOR #$01
        STA $1A00,X
        LDA $1980,X
        STA $03
        LDA #$01
        STA $09
        JMP L8B46
L8B6D:
        LDA $1A00,X
        EOR #$02
        STA $1A00,X
        LDA $1900,X
        STA $02
        LDA #$01
        STA $09
        JMP L8B50
L8B81:
        CMP #$13
        BEQ L8B90
        CMP #$14
        BEQ L8B90
        CMP #$15
        BEQ L8B90
        JMP L8E68
L8B90:
        PHA
        LDA $03
        CMP #$03
        BNE L8BA1
        LDA $24
        CMP $23
        BEQ L8BA1
        PLA
        JMP L8E68
L8BA1:
        PLA
        LDX $28
L8BA4:
        LDA $1900,X
        CMP $02
        BEQ L8BAF
L8BAB:
        DEX
        BNE L8BA4
        RTS
L8BAF:
        LDA $1980,X
        CMP $03
        BNE L8BAB
        LDA $10
        AND #$30
        BEQ L8BC2
        LDA $41
        ORA #$80
        STA $41
L8BC2:
        LDA #$00
        STA $10
        LDA #$04
        STA $39
        LDA #$36
        STA $4004
        JSR L80D1
        LDA $1A00,X
        AND #$C0
        CMP #$C0
        BNE L8BE2
        LDA #$04
        STA $08
        JMP L8C43
L8BE2:
        CMP #$40
        BNE L8BF6
        LDA $1A00,X
        ORA $19FF,X
        STA $19FF,X
        LDA #$01
        STA $08
        JMP L8C43
L8BF6:
        CMP #$80
        BEQ L8C2A
        STX $07
L8BFC:
        DEX
        LDA $1A00,X
        AND #$80
        BEQ L8BFC
        LDA $1A00,X
        LDX $07
        ORA $1A01,X
        STA $1A01,X
        AND #$04
        BEQ L8C1B
        LDA $1A01,X
        EOR #$01
        STA $1A01,X
L8C1B:
        LDA #$01
        STA $08
        LDA #$40
        ORA $19FF,X
        STA $19FF,X
        JMP L8C43
L8C2A:
        LDA $1A00,X
        ORA $1A01,X
        STA $1A01,X
        AND #$04
        BEQ L8C3F
        LDA $1A01,X
        EOR #$01
        STA $1A01,X
L8C3F:
        LDA #$04
        STA $08
L8C43:
        LDA $1901,X
        STA $1900,X
        LDA $1981,X
        STA $1980,X
        LDA $1A01,X
        STA $1A00,X
        CPX $28
        BEQ L8C5D
        INX
        JMP L8C43
L8C5D:
        DEC $28
        LDX #$05
        LDY $08
        JSR L8894
        LDA #$07
        STA $05
        LDA #$0E
        STA $04
        PLA
        PLA
        JMP L805E
L8C73:
        LDA $2A
        CMP #$02
        BPL L8C7A
L8C79:
        RTS
L8C7A:
        DEC $2B
        BEQ L8C94
        LDA $2A
        CMP $04
        BMI L8C79
        LDA $1900,X
        CMP $0A
        BNE L8C79
        DEC $2D
        BEQ L8C90
L8C8F:
        RTS
L8C90:
        LDA $2E
        STA $2D
L8C94:
        LDA $2C
        STA $2B
        LDA $0B
        SEC
        SBC $1980,X
        BVS L8C8F
        CMP #$04
        BMI L8C8F
        STX $07
        LDX #$20
L8CA8:
        LDA $1320,X
        BEQ L8CB1
        DEX
        BNE L8CA8
        RTS
L8CB1:
        STX $08
        LDX $07
        LDA $1900,X
        STA $02
        LDA $1980,X
        STA $03
        STX $07
        JSR L8049
        TYA
        CLC
        ADC $48
        STA $48
        LDA $49
        ADC #$00
        LDX $08
        STA $1320,X
        LDA $48
        STA $1300,X
        LDX $07
        RTS
L8CDB:
        DEC $2F
        BEQ L8CE0
        RTS
L8CE0:
        LDA $30
        STA $2F
        LDA $23
        BNE L8CEB
        JSR L9B30
L8CEB:
        LDA $32
        BNE L8CF0
        RTS
L8CF0:
        LDA $34
        BNE L8CF7
        JMP L8D20
L8CF7:
        DEC $32
        BEQ L8CFE
        JMP L8D20
L8CFE:
        LDA $33
        STA $32
        INC $31
        LDX $31
        LDA #$03
        STA $1B00,X
        LDA $D012
        AND #$0F
        CLC
        ADC #$04
        STA $1A80,X
        LDA $D012
        AND #$40
        STA $1B80,X
        DEC $34
L8D20:
        LDX $31
        CPX #$00
        BNE L8D27
        RTS
L8D27:
        LDA $1B80,X
        AND #$20
        BEQ L8D31
        JMP L8EF0
L8D31:
        LDA $1B80,X
        AND #$01
        BEQ L8D3B
        JMP L8DF4
L8D3B:
        LDA #$00
        STA $04
        LDA #$66
        STA $05
        LDA $1A80,X
        STA $02
        LDA $1B00,X
        STA $03
        LDA $1B80,X
        AND #$40
        BEQ L8D58
        INC $02
        INC $02
L8D58:
        DEC $02
        STX $07
        JSR L805E
        LDX $07
L8D61:
        LDA $1A80,X
        STA $02
        LDA #$07
        STA $05
        LDA #$5E
        STA $04
        LDA $1B80,X
        AND #$40
        BEQ L8D79
        LDA #$61
        STA $04
L8D79:
        STX $07
        JSR L805E
        LDX $07
        LDA $1B80,X
        AND #$40
        BEQ L8D8B
        DEC $02
        DEC $02
L8D8B:
        INC $02
        JSR L8058
        BEQ L8DD9
        LDX $07
        LDA $1A80,X
        STA $02
        INC $03
        LDA $1B80,X
        EOR #$40
        STA $1B80,X
        LDA $1A80,X
        STA $02
        DEC $03
        LDA #$00
        STA $04
        LDA #$66
        STA $05
        JSR L805E
        LDX $07
        INC $1B00,X
        INC $03
        LDA $03
        CMP #$16
        BNE L8DD6
        LDA $28
        BNE L8DD0
        LDA $25
        BNE L8DD0
        LDA $41
        ORA #$02
        STA $41
L8DD0:
        JSR L8E33
        JMP L8DE5
L8DD6:
        JMP L8D61
L8DD9:
        LDA $02
        LDX $07
        STA $1A80,X
        LDA $03
        STA $1B00,X
L8DE5:
        LDA $1B80,X
        EOR #$01
        STA $1B80,X
        DEX
        BEQ L8DF3
        JMP L8D27
L8DF3:
        RTS
L8DF4:
        LDA #$07
        STA $05
        LDA $1A80,X
        STA $02
        LDA $1B00,X
        STA $03
        LDA $1B80,X
        AND #$40
        BNE L8E1E
        LDA #$60
        STA $04
        STX $07
        JSR L805E
        DEC $02
        DEC $04
        JSR L805E
        LDX $07
        JMP L8DE5
L8E1E:
        LDA #$63
        STA $04
        STX $07
        JSR L805E
        INC $02
        DEC $04
        JSR L805E
        LDX $07
        JMP L8DE5
L8E33:
        STX $07
L8E35:
        LDA $1A81,X
        STA $1A80,X
        LDA $1B01,X
        STA $1B00,X
        LDA $1B81,X
        STA $1B80,X
        CPX $31
        BEQ L8E4F
        INX
        JMP L8E35
L8E4F:
        LDX $07
        DEC $31
        LDA $23
        BEQ L8E61
        LDA $34
        BNE L8E61
        LDA $41
        ORA #$40
        STA $41
L8E61:
        RTS
        .byte $5E,$5F,$60,$61,$62,$63
L8E68:
        LDX #$06
L8E6A:
        CMP L8E61,X
        BEQ L8E75
        DEX
        BNE L8E6A
        JMP L913B
L8E75:
        CMP #$62
        BNE L8E7B
        DEC $02
L8E7B:
        CMP #$5F
        BNE L8E81
        INC $02
L8E81:
        CMP #$5E
        BNE L8E87
        INC $02
L8E87:
        CMP #$61
        BNE L8E8D
        DEC $02
L8E8D:
        LDX $31
        LDA $02
L8E91:
        CMP $1A80,X
        BEQ L8E9A
L8E96:
        DEX
        BNE L8E91
        RTS
L8E9A:
        LDA $03
        CMP $1B00,X
        BNE L8E96
        LDA #$00
        STA $10
        STX $07
        LDX #$05
        LDY #$01
        JSR L8894
        LDX #$07
        LDY #$06
        JSR L8894
        LDX $07
        LDA #$04
        STA $39
        LDA #$36
        STA $4004
        JSR L80D1
        LDA $1B80,X
        AND #$40
        BNE L8ED7
        LDA $1A80,X
        CMP #$01
        BEQ L8EE8
        DEC $1A80,X
        JMP L8EE8
L8ED7:
        LDA $02
        STA $1A80,X
        JMP L8EE8
        .byte $80,$1B,$29,$01,$F0,$03,$FE,$80,$1A
L8EE8:
        LDA #$2F
        STA $1B80,X
        PLA
        PLA
        RTS
L8EF0:
        LDA $1A80,X
        STA $02
        LDA $1B00,X
        STA $03
        LDA $1B80,X
        AND #$0F
        BEQ L8F27
        AND #$07
        STA $05
        LDA $1B80,X
        SEC
        SBC #$01
        STA $1B80,X
        LDA #$64
        STA $04
        STX $07
        JSR L805E
        INC $04
        INC $02
        JSR L805E
L8F1E:
        LDX $07
        DEX
        BEQ L8F26
        JMP L8D27
L8F26:
        RTS
L8F27:
        JSR L8E33
        LDA #$66
        STA $05
        LDA #$00
        STA $04
        JSR L805E
        INC $02
        JSR L805E
        JMP L8F1E
L8F3D:
        LDA $37
        BEQ L8F45
        DEC $37
        BEQ L8F46
L8F45:
        RTS
L8F46:
        LDA $38
        STA $37
        LDA $36
        EOR #$01
        STA $36
        AND #$80
        BEQ L8F57
        JMP L8FEA
L8F57:
        LDA #$02
        STA $03
        LDA #$01
        STA $05
        LDA $35
        STA $02
        LDA $36
        AND #$40
        BNE L8F8F
        LDA #$20
        STA $04
        DEC $02
        JSR L805E
        INC $02
        LDA #$66
        STA $04
        LDA $36
        AND #$01
        BEQ L8F82
        LDA #$68
        STA $04
L8F82:
        JSR L805E
        INC $02
        INC $04
        JSR L805E
        JMP L8FB4
L8F8F:
        LDA #$20
        STA $04
        INC $02
        JSR L805E
        DEC $02
        LDA #$6B
        STA $04
        LDA $36
        AND #$01
        BEQ L8FA8
        LDA #$6D
        STA $04
L8FA8:
        DEC $02
        JSR L805E
        INC $02
        DEC $04
        JSR L805E
L8FB4:
        LDA $36
        AND #$01
        BEQ L8FC7
        LDA $36
        AND #$40
        BNE L8FC4
        INC $35
        INC $35
L8FC4:
        DEC $35
        RTS
L8FC7:
        LDA $35
        CMP $0A
        BNE L8FD2
        LDA #$80
        STA $36
L8FD1:
        RTS
L8FD2:
        BMI L8FDF
        LDA $36
        AND #$40
        BNE L8FD1
        LDA #$41
        STA $36
L8FDE:
        RTS
L8FDF:
        LDA $36
        AND #$40
        BEQ L8FDE
        LDA #$01
        STA $36
        RTS
L8FEA:
        LDA $36
        AND #$01
        CLC
        ADC #$6E
        STA $04
        LDA #$01
        STA $05
        LDA #$02
        STA $03
        LDA $35
        STA $02
        JSR L805E
        LDA $35
        CMP $0A
        BNE L9009
        RTS
L9009:
        LDA #$00
        STA $36
        JMP L8FC7
L9010:
        LDA $10
        AND #$02
        BNE L902F
        LDA #$01
        STA $05
        LDA #$71
        STA $04
        LDA $11
        STA $02
        LDA $12
        STA $03
L9026:
        LDA $10
        EOR #$02
        STA $10
        JMP L805E
L902F:
        LDA #$00
        STA $04
        LDA #$66
        STA $05
        LDA $11
        STA $02
        LDA $12
        STA $03
        JSR L805E
        INC $02
        LDA $02
        CMP #$27
        BNE L904F
        LDA #$00
        STA $10
        RTS
L904F:
        INC $11
        LDA #$01
        STA $05
        LDA #$70
        STA $04
        JSR L8856
        JMP L9026
L905F:
        LDA $10
        AND #$02
        BNE L9078
        LDA #$01
        STA $05
        LDA #$70
        STA $04
        LDA $11
        STA $02
        LDA $12
        STA $03
        JMP L9026
L9078:
        LDA $11
        STA $02
        LDA $12
        STA $03
        LDA #$00
        STA $04
        LDA #$66
        STA $05
        JSR L805E
        DEC $02
        DEC $11
        BNE L9096
        LDA #$00
        STA $10
        RTS
L9096:
        LDA #$01
        STA $05
        LDA #$71
        STA $04
        JSR L8856
        JMP L9026
L90A4:
        LDA $11
        STA $02
        LDA $12
        STA $03
        LDA $10
        AND #$02
        BNE L90BD
        LDA #$01
        STA $05
        LDA #$08
        STA $04
        JMP L9026
L90BD:
        LDA #$00
        STA $04
        LDA #$66
        STA $05
        JSR L805E
        INC $03
        LDA $03
        CMP #$16
        BNE L90D5
        LDA #$00
        STA $10
        RTS
L90D5:
        INC $12
        LDA #$01
        STA $05
        LDA #$09
        STA $04
        JSR L8856
        JMP L9026
L90E5:
        DEC $3A
        BEQ L90EA
        RTS
L90EA:
        LDA #$80
        STA $3A
        INC $3C
        LDX $3B
        CPX #$00
        BNE L90F7
        RTS
L90F7:
        LDA #$00
        STA $07
        LDA $1D00,X
        AND #$30
        TAY
        LDA #$72
        CPY #$10
        BNE L9109
        LDA #$75
L9109:
        CPY #$20
        BNE L910F
        LDA #$78
L910F:
        CLC
        ADC $07
        STA $04
        LDA $3C
        AND #$07
        STA $05
        LDA $1C00,X
        STA $02
        LDA $1C80,X
        STA $03
        STX $07
        JSR L805E
        LDX $07
        DEX
        BNE L90F7
        RTS
        .byte $72,$73,$74,$75,$76,$77,$78,$79,$7A,$07,$0B,$0C
L913B:
        LDX #$03
L913D:
        CMP $912E,X
        BEQ L916B
        CMP $9131,X
        BEQ L9187
        CMP $9134,X
        BEQ L9158
        CMP $9137,X
        BNE L9154
        JMP L86CA
L9154:
        DEX
        BNE L913D
L9157:
        RTS
L9158:
        LDA $10
        AND #$10
        BNE L9157
        LDA $10
        EOR #$20
        STA $10
        CPX #$01
        BNE L9157
        JMP L9197
L916B:
        LDA $10
        AND #$30
        STA $07
        LDA #$50
        SEC
        SBC $07
        AND #$30
        STA $07
L917A:
        LDA $10
        AND #$8F
        ORA $07
        STA $10
        CPX #$01
        BEQ L9197
        RTS
L9187:
        LDA $10
        AND #$30
        STA $07
        LDA #$30
        SEC
        SBC $07
        STA $07
        JMP L917A
L9197:
        LDX $3B
L9199:
        LDA $02
        CMP $1C00,X
        BEQ L91A4
L91A0:
        DEX
        BNE L9199
        RTS
L91A4:
        LDA $03
        CMP $1C80,X
        BNE L91A0
        LDA $1D00,X
        JSR L91C5
        STA $1D00,X
        LDA #$0F
        STA $3D
        LDA #$90
        STA $D40F
        JSR L80D1
        LDA #$00
        STA $39
        RTS
L91C5:
        AND #$30
        CMP #$20
        BEQ L91DA
        CMP #$10
        BEQ L91D5
        LDA #$1F
        STA $1D00,X
        RTS
L91D5:
        LDA #$0F
        STA $1D00,X
L91DA:
        LDA $1D00,X
        RTS
L91DE:
        LDX $3E
        STX $3B
L91E2:
        LDA $91F7,X
        STA $1C00,X
        LDA $9213,X
        STA $1C80,X
        LDA $922F,X
        STA $1D00,X
        DEX
        BNE L91E2
        RTS
        .byte $13,$14,$13,$14,$01,$04,$07,$0A,$26,$23,$20,$1D,$13,$14,$07,$20
        .byte $05,$05,$22,$22,$02,$04,$06,$08,$26,$24,$22,$20,$0D,$0D,$0E,$0E
        .byte $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$06,$06,$06,$06,$0E,$15,$0E,$15
        .byte $08,$08,$08,$08,$08,$08,$08,$08,$1F,$0F,$0F,$1F,$1F,$0F,$1F,$0F
        .byte $0F,$1F,$0F,$1F,$2F,$2F,$2F,$2F,$0F,$1F,$1F,$0F,$2F,$2F,$2F,$2F
        .byte $2F,$2F,$2F,$2F,$01,$02,$03,$00,$02,$02,$02,$02,$00,$03,$03,$03
        .byte $02,$03,$03,$00,$03,$03,$03,$03,$06,$06,$06,$00,$07,$07,$07,$07
        .byte $00,$08,$08,$08,$09,$0A,$0B,$00,$0B,$0B,$0C,$0D,$00,$00,$00,$14
        .byte $00,$08,$09,$00,$19,$0A,$00,$0B,$0C,$00,$0F,$1E,$00,$14,$14,$14
        .byte $00,$00,$00,$06,$00,$06,$06,$00,$04,$06,$00,$04,$04,$00,$04,$03
        .byte $00,$04,$03,$03,$00,$00,$00,$04,$00,$07,$07,$00,$03,$06,$00,$05
        .byte $05,$00,$04,$03,$00,$03,$03,$03,$10,$0F,$0E,$0D,$0D,$0D,$0C,$0C
        .byte $0B,$0B,$0A,$09,$09,$08,$09,$08,$07,$07,$06,$06,$00,$00,$04,$04
        .byte $03,$03,$03,$03,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
        .byte $00,$00,$00,$00,$04,$00,$00,$0C,$00,$00,$10,$00,$00,$14,$00,$00
        .byte $00,$1C,$00,$1C,$00,$00,$00,$01,$01,$00,$82,$01,$01,$00,$01,$82
        .byte $00,$01,$82,$82,$00,$01,$82,$82
L9300:
        LDX $2A
        LDA $924B,X
        STA $25
        LDA $925F,X
        STA $23
        STA $24
        LDA $9273,X
        STA $34
        LDA $9287,X
        STA $33
        STA $32
        LDA $929B,X
        STA $30
        STA $2F
        LDA $92AF,X
        STA $18
        STA $19
        LDA $92C3,X
        STA $37
        STA $38
        LDA $92D7,X
        STA $3E
        LDA $92EB,X
        STA $3F
        JMP L91DE
L933C:
        LDA #$02
        STA $03
        JSR L9469
        LDA #$20
        STA $04
L9347:
        LDA #$00
        STA $02
L934B:
        JSR L805E
        INC $02
        LDA $02
        CMP #$28
        BNE L934B
        INC $03
        LDA $03
        CMP #$17
        BNE L9347
        LDA #$00
        STA $04
        LDA #$03
        STA $03
        LDA #$66
        STA $05
L936A:
        LDA #$01
        STA $02
L936E:
        JSR L805E
        INC $02
        LDA $02
        CMP #$27
        BNE L936E
        INC $03
        LDA $03
        CMP #$16
        BNE L936A
        RTS
L9382:
        JSR L933C
        LDA #$0B
        STA $03
        LDA #$20
        STA $04
L938D:
        LDA #$0D
        STA $02
L9391:
        JSR L805E
        INC $02
        LDA $02
        CMP #$1C
        BNE L9391
        INC $03
        LDA $03
        CMP #$0E
        BNE L938D
        LDA #$0E
        STA $02
        LDA #$0C
        STA $03
        JSR L8049
        LDX #$00
        LDA #$01
        STA $05
L93B5:
        LDA $9412,X
        STA $04
        STX $0A
        JSR L805E
        LDX $0A
        INC $02
        INX
        CPX #$0D
        BNE L93B5
        DEC $02
        DEC $02
        JSR L8049
        INY
        LDX $2A
L93D2:
        LDA ($48),Y
        CLC
        ADC #$01
        STA ($48),Y
        CMP #$3A
        BNE L93EA
        LDA #$30
        STA ($48),Y
        DEY
        LDA ($48),Y
        CLC
        ADC #$01
        STA ($48),Y
        INY
L93EA:
        DEX
        BNE L93D2
        JMP L941F
L93F0:
        JSR L8013
L93F3:
        LDA $2007
        STA $50
        LDX #$07
L93FA:
        LDA $1FFF,X
        STA $2000,X
        DEX
        BNE L93FA
        LDA $50
        STA $2000
        LDA $3F
        AND #$80
        BEQ L9411
        JMP L9496
L9411:
        RTS
        .byte $45,$4E,$54,$45,$52,$20,$5A,$4F,$4E,$45,$20,$30,$30
L941F:
        LDA #$0F
        STA $4000
        STA $D418
        JSR L80DD
        LDA #$E8
        STA $4001
        JSR L80CB
L9432:
        LDA $4001
        STA $D401
        STA $4002
L943B:
        JSR L93F0
        INC $4002
        LDA $4002
        SBC #$E0
        STA $D408
        LDA $4002
        BNE L943B
        INC $4001
        BNE L9432
        JSR L80DD
        JMP L933C
        .byte $30,$30,$30,$30,$FF,$30,$30,$30,$00,$00,$3C,$3C,$3C,$3C,$00,$00
L9469:
        LDA $3F
        BNE L9479
        LDX #$08
L946F:
        LDA $9458,X
        STA $1FFF,X
        DEX
        BNE L946F
        RTS
L9479:
        LDA $3F
        CMP #$01
        BNE L948A
        LDX #$08
        LDA #$00
L9483:
        STA $1FFF,X
        DEX
        BNE L9483
        RTS
L948A:
        LDX #$08
L948C:
        LDA $9460,X
        STA $1FFF,X
        DEX
        BNE L948C
        RTS
L9496:
        LDX #$08
L9498:
        CLC
        LDA $1FFF,X
        ROL
        ADC #$00
        STA $1FFF,X
        DEX
        BNE L9498
L94A5:
        RTS
L94A6:
        LDA $25
        BNE L94A5
        LDA $28
        BNE L94A5
        LDA $34
        BNE L94A5
        LDA $31
        BNE L94A5
L94B6:
        INC $2A
        LDA $2A
        CMP #$15
        BNE L94C0
        DEC $2A
L94C0:
        LDX #$F8
        TXS
        INC $0415 ;increments number of ships
        LDA $0415
        CMP #$3A  ;compares to colon ie over 9 
        BNE L94D0 ;not equal then jump
        DEC $0415 ;reduce to 9 ships
L94D0:
        JMP L9852
L94D3:
        LDA $0B
        STA $03
        LDA #$01
        STA $02
        LDA #$00
        STA $04
        LDA #$66
        STA $05
L94E3:
        JSR L805E
        INC $02
        LDA $02
        CMP #$27
        BNE L94E3
        JSR L80DD
        LDA #$08
        STA $4000
        STA $D418
        JSR L80D1
        LDA #$10
        STA $07
L9500:
        LDA #$60
        JSR L9BAA
L9505:
        LDY #$E0
L9507:
        DEY
        BNE L9507
        LDA $4004
        STA $D40F
        INC $4004
        LDA $4004
        CMP #$80
        BNE L9505
        JSR L8013
        LDA #$00
        LDX $D021
        CPX #$F0
        BNE L9528
        LDA #$06
L9528:
        STA $D021
        LDA $0A
        STA $02
        LDA $0B
        STA $03
        LDA $07
        AND #$03
        TAX
        LDA $9623,X
        STA $04
        LDA $07
        AND #$07
        STA $05
        JSR L805E
        DEC $07
        BNE L9500
        LDA #$0F
        STA $4000
        STA $D418
        JSR L80DD
        LDA #$04
        STA $4001
        STA $D401
        LDX #$08
        JSR L80D7
        LDA #$00
L9564:
        STA $1FFF,X
        DEX
        BNE L9564
L956A:
        LDA #$0F
        SEC
        SBC $4000
        STA $08
        LDA #$07
        STA $09
        LDX $08
        INX
L9579:
        JSR L8013
        DEX
        BNE L9579
L957F:
        JSR L95AA
        LDA $08
        BEQ L959F
        DEC $08
        BEQ L958E
        LDA $09
        BNE L957F
L958E:
        LDA #$00
        STA $04
        LDA #$66
        STA $05
        JSR L95B7
        LDA $4000
        STA $D418
L959F:
        DEC $4000
        BNE L956A
        JSR L80DD
        JMP L962F
L95AA:
        LDX $09
        DEC $09
        LDA $9627,X
        STA $05
        LDA #$40
        STA $04
L95B7:
        LDA $0A
        SEC
        SBC $08
        STA $02
        LDA $0B
        STA $03
        JSR L95FF
        LDA $03
        CLC
        ADC $08
        STA $03
        JSR L95FF
        LDA $0B
        SEC
        SBC $08
        STA $03
        JSR L95FF
        LDA $0A
        STA $02
        JSR L95FF
        LDA $02
        CLC
        ADC $08
        STA $02
        JSR L95FF
        LDA $0B
        STA $03
        JSR L95FF
        LDA $03
        CLC
        ADC $08
        STA $03
        JSR L95FF
        LDA $0A
        STA $02
L95FF:
        LDA $02
        AND #$80
        BEQ L9606
L9605:
        RTS
L9606:
        LDA $02
        BEQ L9605
        CMP #$27
        BPL L9605
        LDA $03
        AND #$80
        BNE L9605
        LDA $03
        CMP #$16
        BPL L9605
        LDA $03
        AND #$FC
        BEQ L9605
        JMP L805E
        .byte $73,$74,$76,$40,$00,$06,$02,$04,$05,$03,$07,$01
L962F:
        NOP ;DEC $0415 for infinite lives you can change to NOP NOP NOP (need 3 bytes)
	NOP
	NOP
        LDA $0415
        CMP #$30  ;compare to 0
        BEQ L963C
        JMP L966C ;game ends
L963C:
        JMP L9A56
L963F:
        LDA #$20
        LDX #$00
L9643:
        STA $0478,X
        STA $0500,X
        STA $0600,X
        STA $0700,X
        DEX
        BNE L9643
        LDA #$00
        LDX #$00
L9656:
        STA $2400,X
        DEX
        BNE L9656
        STA $4002
        STA $4003
        STA $4004
        STA $4001
        JSR L80DD
        RTS
L966C:
        JSR L963F
        LDA #$0A
        STA $03
        LDA #$10
        STA $02
        LDA #$03
        STA $05
        LDX #$00
L967D:
        LDA $96E9,X
        STX $07
        STA $04
        JSR L805E
        LDX $07
        INC $02
        INX
        CPX #$08
        BNE L967D
        JSR L80DD
        LDA #$0F
        STA $4000
        STA $D418
        JSR L80D1
        LDX #$0A
L96A0:
        LDA #$20
        STA $4004
L96A5:
        LDY #$00
L96A7:
        DEY
        BNE L96A7
        LDA $4004
        STA $D40F
        INC $4004
        LDA $4004
        CMP #$40
        BNE L96A5
        DEX
        BNE L96A0
        LDX #$07
L96BF:
        LDA #$80
        STA $4004
L96C4:
        LDY #$00
L96C6:
        DEY
        BNE L96C6
        LDA $4004
        STA $D40F
        JSR L80D1
        DEC $4004
        BNE L96C4
        LDA $4000
        SEC
        SBC #$02
        STA $4000
        STA $D418
        DEX
        BNE L96BF
        JMP L8298
        .byte $47,$4F,$54,$20,$59,$4F,$55,$7A
L96F1:
        JSR L963F
        LDA #$0F
        STA $4000
        JSR L80DD
        LDA #$00
        STA $07
L9700:
        LDA #$04
        STA $03
L9704:
        LDA #$0E
        STA $02
        LDA $07
        AND #$07
        TAX
        LDA $9627,X
        STA $05
        LDX #$00
L9714:
        LDA $9784,X
        STA $04
        STX $08
        JSR L805E
        INC $02
        LDX $08
        INX
        CPX #$0C
        BNE L9714
        INC $07
        INC $03
        LDA $03
        CMP #$0B
        BNE L9704
        LDA #$08
        STA $4003
        JSR L80CB
L9739:
        DEY
        BNE L9739
        LDA $4003
        STA $D408
        INC $4003
        LDA $4003
        CMP #$48
        BNE L9739
        LDA $07
        AND #$C0
        CMP #$C0
        BNE L9700
        LDX #$07
L9756:
        LDA #$60
        STA $4003
L975B:
        DEY
        BNE L975B
        LDA $4003
        STA $D408
        DEC $4003
        LDA $4003
        CMP #$30
        BNE L975B
        LDA $4000
        SEC
        SBC #$02
        STA $4000
        STA $D418
        DEX
        BNE L9756
        LDA $40
        BNE L9790
        JMP L8298
        .byte $5A,$4F,$4E,$45,$20,$43,$4C,$45,$41,$52,$45,$44
L9790:
        LDA #$0F
        STA $4000
        STA $D418
        JSR L80DD
        LDX #$08
        LDA #$FF
L979F:
        STA $1FFF,X
        DEX
        BNE L979F
        LDA #$04
        STA $05
        LDA #$0F
        STA $03
L97AD:
        LDA #$09
        STA $02
        LDA #$00
        STA $04
L97B5:
        JSR L805E
        INC $02
        LDA $02
        CMP #$1F
        BNE L97B5
        INC $03
        LDA $03
        CMP #$12
        BNE L97AD
        LDA #$10
        STA $03
        LDA #$0B
        STA $02
        LDX #$00
        LDA #$07
        STA $05
L97D6:
        LDA $9840,X
        STA $04
        STX $08
        JSR L805E
        LDX $08
        INC $02
        INX
        CPX #$12
        BNE L97D6
        DEC $02
        DEC $02
        DEC $02
        LDA #$30
        CLC
        ADC $40
        STA $04
        LDA #$03
        STA $05
        JSR L805E
        LDX #$04
        LDY $40
        JSR L8894
        LDA #$D0
        STA $07
        JSR L80CB
L980B:
        LDA $07
        STA $4003
L9810:
        DEY
        BNE L9810
        LDA $4003
        SBC #$80
        STA $D408
        INC $4003
        BNE L9810
        JSR L8013
        LDA $07
        AND #$07
        TAX
        LDA #$FF
        STA $2000,X
        INC $07
        LDA $07
        AND #$07
        TAX
        LDA #$00
        STA $2000,X
        LDA $07
        BNE L980B
        JMP L8298
        .byte $20,$4D,$59,$53,$54,$45,$52,$59,$20,$42,$4F,$4E,$55,$53,$20,$20
        .byte $20,$20
L9852:
        LDX #$04
L9854:
        LDA $1D00,X
        CMP $987B,X
        BNE L9869
        DEX
        BNE L9854
        LDA $3B
        BEQ L9869
        LDA $41
        ORA #$20
        STA $41
L9869:
        LDA #$08
        STA $40
L986D:
        LDA $41
        CLC
        ROL
        STA $41
        BCS L9879
        DEC $40
        BNE L986D
L9879:
        JMP L96F1
        .byte $0F,$1F,$1F,$0F
L9880:
        JSR L963F
        LDA #$03
        STA $05
        LDA #$09
        STA $02
        LDX #$00
L988D:
        LDA #$05
        STA $03
        LDA $9903,X
        STA $04
        STX $07
        JSR L805E
        INC $03
        INC $03
        LDA #$07
        STA $05
        LDX $07
        LDA $9919,X
        STA $04
        JSR L805E
        LDA #$01
        STA $05
        INC $03
        INC $03
        LDX $07
        LDA $992F,X
        STA $04
        JSR L805E
        INC $05
        LDX $07
        INC $03
        INC $03
        INC $05
        LDA $9945,X
        STA $04
        JSR L805E
        INC $05
        LDX $07
        INC $03
        INC $03
        LDA $995B,X
        STA $04
        JSR L805E
        LDX $07
        LDA #$01
        STA $05
        INC $03
        INC $03
        LDA $9971,X
        STA $04
        JSR L805E
        LDX $07
        LDA #$03
        STA $05
        INC $02
        INX
        CPX #$16
        BNE L988D
        JMP L9AF7
        .byte $44,$45,$53,$49,$47,$4E,$20,$41,$4E,$44,$20,$50,$52,$4F,$47,$52
        .byte $41,$4D,$4D,$49,$4E,$47,$20,$20,$20,$42,$59,$20,$20,$4A,$45,$46
        .byte $46,$20,$20,$4D,$49,$4E,$54,$45,$52,$20,$20,$20,$20,$3F,$20,$20
        .byte $31,$39,$38,$33,$20,$42,$59,$20,$4C,$4C,$41,$4D,$41,$53,$4F,$46
        .byte $54,$20,$20,$50,$52,$45,$53,$53,$20,$46,$49,$52,$45,$20,$46,$4F
        .byte $52,$20,$53,$54,$41,$52,$54,$20,$53,$45,$4C,$45,$43,$54,$20,$53
        .byte $54,$41,$52,$54,$20,$4C,$45,$56,$45,$4C,$20,$20,$20,$31,$96,$95
        .byte $94,$93,$92,$91,$90,$8F,$8E,$8D,$8C,$8B,$8A,$89,$88,$87,$86,$85
        .byte $84,$83,$82,$81
L9987:
        LDX #$00
L9989:
        JSR L8013
        LDA $9B5A,X
        AND #$3F
        CMP #$20
        BNE L9998
        JMP L99F7
L9998:
        CMP #$2E
        BNE L999F
        JMP L9A06
L999F:
        CMP #$00
        BNE L99A6
        JMP L9987
L99A6:
        CLC
        ASL
        ASL
        ASL
        TAY
        STX $09
        LDX #$00
L99AF:
        LDA $2200,Y
        STA $2400,X
        INY
        INX
        CPX #$08
        BNE L99AF
L99BB:
        LDX $09
        LDA #$08
        STA $08
L99C1:
        LDY #$00
L99C3:
        LDA #$18
        STA $07
        TYA
        TAX
        CLC
L99CA:
        ROL $2400,X
        PHP
        TXA
        CLC
        ADC #$08
        TAX
        DEC $07
        BEQ L99DB
        PLP
        JMP L99CA
L99DB:
        PLP
        INY
        CPY #$08
        BNE L99C3
        LDX #$0A
L99E3:
        DEY
        BNE L99E3
        DEX
        BNE L99E3
        JSR L8013
        DEC $08
        BNE L99C1
        LDX $09
        INX
        JMP L9A26
        .byte $00
L99F7:
        STX $09
        LDA #$00
        LDX #$08
L99FD:
        STA $23FF,X
        DEX
        BNE L99FD
        JMP L99BB
L9A06:
        STX $09
        LDX #$08
L9A0A:
        LDA $23B7,X
        STA $23FF,X
        DEX
        BNE L9A0A
        JMP L99BB
        .byte $86,$09,$A2,$08,$BD,$C7,$23,$9D,$FF,$23,$CA,$D0,$F7,$4C,$BB,$99
L9A26:
        STX $09
        JSR L83DC
        LDA $C5
        CMP #$04
        BNE L9A40
        INC $0626
        LDA $0626
        CMP #$37
        BNE L9A40
        LDA #$31
        STA $0626
L9A40:
        LDA $0D
        AND #$10
        BNE L9A4B
        LDX $09
        JMP L9989
L9A4B:
        LDA $0626
        SEC
        SBC #$30
        STA $2A
        JMP L963F
L9A56:
        JSR L963F
        LDA #$07
        STA $05
        LDX #$00
        LDA #$0A
        STA $03
        LDA #$10
        STA $02
L9A67:
        LDA $9AEE,X
        STA $04
        STX $07
        JSR L805E
        LDX $07
        INC $02
        INX
        CPX #$09
        BNE L9A67
        LDA #$0F
        STA $4000
        STA $D418
        LDX #$0F
L9A84:
        LDA #$80
        STA $4002
        STA $4003
        STA $4004
        JSR L80CB
        JSR L80D1
L9A95:
        LDY #$00
L9A97:
        DEY
        BNE L9A97
        LDA $4003
        SBC #$70
        STA $D408
        ADC #$80
        STA $D40F
        INC $4002
        INC $4003
        INC $4004
        BNE L9A95
        LDA $4000
        SEC
        SBC #$01
        STA $4000
        STA $D418
        DEX
        BNE L9A84
        LDX #$01
L9AC3:
        LDA $0409,X
        CMP $14F0,X
        BEQ L9ACF
        BMI L9AD4
        BPL L9AE0
L9ACF:
        INX
        CPX #$08
        BNE L9AC3
L9AD4:
        JSR L9880
        JSR L80E9
        LDX #$F8
        TXS
        JMP L81BC
L9AE0:
        LDX #$07
L9AE2:
        LDA $0409,X
        STA $14F0,X
        DEX
        BNE L9AE2
        JMP L9AD4
        .byte $47,$41,$4D,$45,$20,$4F,$56,$45,$52
L9AF7:
        LDA #$14
        STA $03
        LDX #$00
L9AFD:
        LDA $9B53,X
        STA $04
        LDA #$04
        STA $05
        TXA
        CLC
        ADC #$0C
        STA $02
        STX $07
        JSR L805E
        LDX $07
        LDA $02
        CLC
        ADC #$09
        STA $02
        LDA #$03
        STA $05
        LDA $14F1,X
        STA $04
        JSR L805E
        LDX $07
        INX
        CPX #$07
        BNE L9AFD
        JMP L9987
L9B30:
        LDA #$04
        STA $39
        LDX #$06
L9B36:
        DEC $0409,X
        LDA $0409,X
        CMP #$2F
        BNE L9B52
        LDA #$39
        STA $0409,X
        DEX
        BNE L9B36
        LDX #$07
        LDA #$30
L9B4C:
        STA $0409,X
        DEX
        BNE L9B4C
L9B52:
        RTS
        .byte $48,$49,$53,$43,$4F,$52,$45,$01,$0C,$0C,$20,$0D,$01,$14,$12,$09
        .byte $18,$20,$10,$09,$0C,$0F,$14,$13,$2E,$2E,$2E,$20,$12,$05,$10,$0F
        .byte $12,$14,$20,$14,$0F,$20,$0A,$0F,$19,$13,$14,$09,$03,$0B,$20,$10
        .byte $0F,$12,$14,$20,$0F,$0E,$05,$20,$06,$0F,$12,$20,$03,$0F,$0D,$02
        .byte $01,$14,$20,$04,$15,$14,$19,$2E,$2E,$2E,$2E,$2E,$20,$20,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$00
L9BAA:
        STA $4004
        LDA #$0F
        STA $D418
        RTS
        .byte $23,$45,$52,$57,$45,$C6,$C7,$D3,$C6,$C8,$C6,$C7,$57,$45,$52,$57
        .byte $46,$53,$44,$44,$53,$46,$53,$46,$44,$46,$58,$56,$58,$43,$53,$44
        .byte $41,$53,$46,$53,$44,$20,$57,$45,$41,$53,$46,$53,$44,$51,$41,$57
        .byte $34,$36,$35,$34,$36,$35,$34,$36,$44,$51,$57,$44,$51,$44,$20,$51
        .byte $57,$44,$23,$21,$22,$23,$21,$22,$45,$21,$22,$84,$06,$18,$18,$18
        .byte $E7,$E7,$18,$18,$18,$F0,$20,$10,$BF,$5F,$10,$20,$F0,$18,$18,$18
        .byte $18,$BD,$D3,$89,$91,$00,$20,$60,$A3,$2C,$30,$00,$00,$00,$02,$05
        .byte $C8,$30,$00,$00,$00,$08,$04,$3E,$20,$10,$10,$08,$08,$08,$08,$10
        .byte $10,$08,$04,$02,$04,$18,$3C,$7E,$3C,$7E,$FF,$FF,$E7,$18,$18,$18
        .byte $18,$3C,$3C,$3C,$18,$18,$3C,$3C,$3C,$18,$18,$18,$18,$24,$24,$24
        .byte $3C,$18,$3C,$3C,$18,$01,$03,$07,$03,$07,$0F,$0F,$0E,$80,$C0,$E0
        .byte $C0,$E0,$F0,$F0,$70,$00,$00,$00,$18,$18,$00,$00,$00,$00,$00,$18
        .byte $3C,$3C,$18,$00,$00,$00,$00,$3C,$24,$24,$3C,$00,$00,$81,$42,$3C
        .byte $24,$24,$3C,$42,$81,$FF,$C3,$BD,$A5,$A5,$BD,$C3,$FF,$E7,$C3,$A5
        .byte $18,$18,$A5,$C3,$E7,$30,$46,$48,$FF,$FF,$12,$62,$0C,$C0,$FC,$72
        .byte $F8,$1F,$4E,$3F,$03,$0B,$2F,$4E,$5E,$7A,$72,$F4,$D0,$03,$06,$0D
        .byte $1B,$36,$6D,$DB,$B6,$C0,$60,$B0,$D8,$6C,$B6,$DB,$6D,$30,$30,$48
        .byte $48,$84,$84,$02,$02,$00,$3F,$63,$60,$3E,$03,$63,$7E,$00,$3F,$63
        .byte $60,$60,$60,$63,$3F,$00,$45,$6D,$55,$45,$45,$00,$00,$00,$D2,$1A
        .byte $96,$12,$D2,$00,$00,$00,$55,$55,$75,$55,$55,$00,$00,$00,$D4,$14
        .byte $5C,$54,$D4,$00,$00,$00,$10,$08,$7C,$08,$10,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$9A,$00,$00,$00,$00,$00,$00,$FE,$9A,$18
        .byte $18,$18,$18,$38,$38,$86,$CE,$BA,$92,$82,$86,$86,$96,$1C,$14,$24
        .byte $3C,$46,$46,$86,$86,$F8,$84,$84,$F8,$90,$88,$C6,$C6,$FC,$30,$30
        .byte $30,$30,$30,$30,$FC,$82,$C6,$6C,$38,$38,$6C,$C6,$D6,$00,$00,$00
        .byte $1D,$1E,$1F,$B0,$B0,$B0,$B0,$B0,$B0,$B0,$B0,$B0,$B0,$00,$01,$02
        .byte $06,$04,$06,$07,$04,$05,$0B,$07,$08,$09,$07,$06,$06,$07,$08,$07
        .byte $08,$09,$00,$00,$07,$07,$05,$07,$06,$06,$09,$09,$03,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$0B,$0B,$0B,$00,$00,$00,$00,$00,$7C,$FE,$0E
        .byte $D6,$E6,$C6,$FE,$7C,$08,$08,$00,$08,$08,$18,$18,$18,$FC,$FE,$02
        .byte $06,$1C,$70,$FE,$FE,$FC,$FE,$02,$3C,$3C,$02,$FE,$FC,$18,$18,$D8
        .byte $D8,$FE,$18,$18,$18,$FE,$FE,$00,$80,$FC,$06,$FE,$FC,$7C,$FE,$00
        .byte $C0,$FC,$C6,$FE,$7C,$FE,$FE,$06,$0C,$18,$10,$30,$30,$7C,$FE,$06
        .byte $C6,$7C,$C6,$FE,$7C,$7C,$FE,$06,$C6,$7E,$06,$FE,$7C,$01,$01,$01
        .byte $01,$0B,$0C,$09,$08,$80,$80,$80,$80,$D0,$B0,$10,$90,$00,$00,$00
        .byte $00,$F0,$20,$10,$5F,$BF,$10,$20,$F0,$00,$00,$00,$00,$00,$87,$92
        .byte $89,$84,$20,$9A,$81,$3C,$42,$99,$A1,$A1,$99,$42,$3C,$88,$22,$18
        .byte $7D,$BC,$10,$42,$14,$06,$0E,$02,$1E,$3E,$66,$C6,$00,$FC,$FE,$02
        .byte $FC,$86,$FE,$FC,$00,$7C,$FE,$00,$C0,$C0,$FE,$7C,$00,$FC,$FE,$02
        .byte $C6,$C6,$FE,$FC,$00,$FE,$FE,$00,$F0,$C0,$FE,$FE,$00,$FE,$FE,$00
        .byte $F8,$C0,$C0,$C0,$00,$7C,$FE,$00,$DE,$C6,$FE,$7C,$00,$C6,$C6,$02
        .byte $FE,$C6,$C6,$C6,$00,$3C,$3C,$00,$18,$18,$3C,$3C,$00,$FE,$FE,$00
        .byte $18,$D8,$F8,$70,$00,$CC,$D8,$00,$F0,$D8,$CC,$C6,$00,$C0,$C0,$00
        .byte $C0,$C0,$FE,$FE,$00,$C6,$EE,$02,$D6,$C6,$C6,$C6,$00,$C6,$C6,$02
        .byte $D6,$CE,$C6,$C6,$00,$7C,$FE,$02,$C6,$C6,$FE,$7C,$00,$FC,$FE,$02
        .byte $FC,$C0,$C0,$C0,$00,$7C,$FE,$02,$C6,$C6,$CE,$7E,$01,$FC,$FE,$02
        .byte $FC,$D8,$CC,$C6,$00,$7C,$FE,$00,$FC,$06,$FE,$7C,$00,$7E,$7E,$00
        .byte $18,$18,$18,$18,$00,$C6,$C6,$02,$C6,$C6,$FE,$7C,$00,$C6,$C6,$02
        .byte $C6,$C6,$6C,$38,$00,$C6,$C6,$02,$C6,$D6,$EE,$C6,$00,$C6,$6C,$00
        .byte $30,$38,$6C,$C6,$00,$CC,$CC,$00,$78,$30,$30,$30,$00,$FE,$FE,$00
        .byte $38,$70,$FE,$FE,$00,$7E,$FF,$FF,$FF,$FF,$FF,$FF,$7E,$3C,$3C,$FF
        .byte $EF,$F7,$FF,$3C,$3C,$18,$18,$18,$E7,$E7,$18,$18,$18,$32,$7B,$FA
        .byte $BC,$88,$88,$88,$CC,$03,$07,$0F,$0B,$18,$10,$10,$18,$10,$98,$90
        .byte $E0,$80,$40,$40,$60,$4C,$DE,$5F,$3D,$11,$11,$11,$33,$C0,$E0,$F0
        .byte $D0,$18,$08,$08,$18,$08,$19,$09,$07,$01,$02,$02,$06,$00,$6F,$6D
        .byte $6D,$6D,$6D,$6F,$00,$00,$BE,$B0,$BE,$B6,$B6,$BE,$00,$18,$10,$18
        .byte $7E,$18,$78,$44,$06,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01
        .byte $03,$05,$01,$02,$02,$80,$00,$80,$C0,$A0,$80,$40,$40,$18,$08,$18
        .byte $7E,$18,$1E,$22,$60,$00,$00,$00,$00,$00,$00,$00,$00,$80,$80,$80
        .byte $C0,$A0,$80,$40,$40,$01,$00,$01,$03,$05,$01,$02,$02,$10,$28,$10
        .byte $F8,$94,$10,$28,$28,$10,$28,$12,$3C,$50,$90,$A8,$24,$00,$00,$70
        .byte $FF,$FF,$70,$00,$00,$00,$00,$0E,$FF,$FF,$0E,$00,$00,$03,$07,$0E
        .byte $1C,$38,$70,$E0,$C0,$00,$00,$14,$7C,$26,$7C,$08,$00,$00,$62,$56
        .byte $2A,$24,$54,$6E,$40,$C0,$E0,$70,$38,$1C,$0E,$07,$03,$44,$AA,$91
        .byte $7A,$BC,$A2,$D5,$8A,$00,$00,$00,$00,$00,$60,$60,$00,$00,$00,$7E
        .byte $FF,$FF,$7E,$00,$00,$00,$00,$00,$00,$00,$60,$20,$40,$03,$07,$0E
        .byte $1C,$18,$00,$C0,$C0,$CE,$CF,$EC,$CE,$C8,$CE,$EC,$40,$8D,$96,$9C
        .byte $CD,$8C,$8D,$EC,$58,$8E,$81,$E8,$D9,$DC,$D4,$CC,$46,$31,$32,$73
        .byte $29,$05,$37,$B3,$AA,$AA,$AA
L9FFA:
        LDA #$36
        STA $01
        LDX #$00
LA000:
        LDA $9C00,X
        STA $2000,X
        LDA $9D00,X
        STA $2100,X
        LDA $9E00,X
        STA $2200,X
        LDA $9F00,X
        STA $2300,X
        INX
        BNE LA000
        JMP L8085
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00