
                ;@:PIC.S
                .ORG    $3000
                ;----------------
                ;SHOW KOALA PIC
                ;----------------
                JSR LOADFILE
                JSR CONFIGVIC
                JSR COPYCOLORS
                JSR WAITKEY
                JSR RESTOREVIC
                RTS 
                ;----------------
                ;WAITKEY
                ;----------------
K.CHRIN        =$FFE4
WAITKEY         JSR K.CHRIN
                BEQ WAITKEY
                RTS 
                ;----------------
                ;CONFIG VIC
                ;----------------
CONFIGVIC       LDA #$02
                STA $DD00
                LDA #$3B
                STA $D011
                LDA #$D8
                STA $D016
                LDA #$78
                STA $D018
                RTS 
                ;----------------
                ;RESTORE VIC
                ;----------------
RESTOREVIC      LDA #$03
                STA $DD00
                LDA #$1B
                STA $D011
                LDA #$C8
                STA $D016
                LDA #$15
                STA $D018
                LDA #$0B
                STA $D021
                RTS 
                ;----------------
                ;COPY COLORS
                ;----------------
VICBANK        =1
VICBASE        =$4000*VICBANK
BITMAP         =VICBASE+$2000
MATRIX         =VICBASE+$1C00
CLRMEM         =$D800
COPYCOLORS      LDX #0
LOOP            
                LDA BITMAP+8000,X
                STA MATRIX,X
                LDA BITMAP+8250,X
                STA MATRIX+250,X
                LDA BITMAP+8500,X
                STA MATRIX+500,X
                LDA BITMAP+8750,X
                STA MATRIX+750,X
                LDA BITMAP+9000,X
                STA CLRMEM,X
                LDA BITMAP+9250,X
                STA CLRMEM+250,X
                LDA BITMAP+9500,X
                STA CLRMEM+500,X
                LDA BITMAP+9750,X
                STA CLRMEM+750,X
                INX 
                CPX #250
                BNE LOOP
                LDA BITMAP+10000
                STA $D021
                RTS 
                ;----------------
                ;LOAD FILE
                ;----------------
FNAME           .BYTE   'FERRARI        '
FSIZE           .BYTE   7
DEVICE         =$BA
SETLFS         =$FFBA
SETNAM         =$FFBD
SETMSG         =$FF90
LOAD           =$FFD5
LOADFILE        LDA #$00
                JSR SETMSG
                LDA #1
                LDX DEVICE
                LDY #1
                JSR SETLFS
                LDA FSIZE
                LDX #FNAME&255
                LDY #FNAME/256
                JSR SETNAM
                LDA #0
                JSR LOAD
                LDA #%11000000
                JSR SETMSG
                RTS 
