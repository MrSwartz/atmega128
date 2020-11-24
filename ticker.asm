.include "m128def.inc"

.equ Sgm_A=0b01111111
.equ Sgm_B=0b10111111
.equ Sgm_D=0b11011111
.equ Sgm_E=0b11101111
.equ Sgm_F=0b11110111
.equ Sgm_C=0b11111011
.equ Sgm_H=0b11111101
.equ Sgm_G=0b11111110

.cseg
   .org 0
   jmp INIT 

.equ    Symbol0 =   (Sgm_A&Sgm_C&Sgm_D&Sgm_E&Sgm_F&Sgm_B)
.equ    Symbol1 =   (Sgm_B&Sgm_C)
.equ    Symbol2 =   (Sgm_A&Sgm_B&Sgm_D&Sgm_E&Sgm_G)
.equ    Symbol3 =   (Sgm_A&Sgm_B&Sgm_C&Sgm_G& Sgm_D) 
.equ    Symbol4 =   (Sgm_F&Sgm_G&Sgm_B&Sgm_C)
.equ    Symbol5 =   (Sgm_A&Sgm_F&Sgm_G&Sgm_C&Sgm_D)
.equ    Symbol6 =   (Sgm_A&Sgm_F&Sgm_D&Sgm_E&Sgm_G&Sgm_C)
.equ    Symbol7 =   (Sgm_A&Sgm_B&Sgm_C) 
.equ    Symbol8 =   (Sgm_A&Sgm_B&Sgm_F&Sgm_G&Sgm_E&Sgm_C&Sgm_D)
.equ    Symbol9 =   (Sgm_A&Sgm_C&Sgm_D&Sgm_G&Sgm_F&Sgm_B)
.equ    SymbolA =   (Sgm_A&Sgm_B&Sgm_F&Sgm_G&Sgm_E&Sgm_C)
.equ    SymbolB =   (Sgm_A&Sgm_B&Sgm_F&Sgm_G&Sgm_E&Sgm_C&Sgm_D) 
.equ    SymbolC =   (Sgm_A&Sgm_F&Sgm_D&Sgm_E)
.equ    SymbolD =   (Sgm_A&Sgm_C&Sgm_D&Sgm_E&Sgm_F&Sgm_B)
.equ    SymbolE =   (Sgm_A&Sgm_F&Sgm_G&Sgm_E&Sgm_D)
.equ    SymbolF =   (Sgm_A&Sgm_F&Sgm_G&Sgm_E) 
 

String:  .DB    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, SymbolF, SymbolE, Sym-bolD, SymbolC, SymbolB, SymbolA, Symbol9, Symbol8, Symbol7, Symbol6, Symbol5, Symbol4, Symbol3, Symbol2, Symbol1, Symbol0, 0xFF, 0xFF, 0xff, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xff, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xff, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF

INIT:
    ldi R16,0xFF
    out ddrA,R16
    ldi R16,0b00001111
    out ddrC,R16
    clr R17
    ;clr R18
    clr r19
    clr r20
 
    clr r25
    clr r24
    clr r23
    clr r22
    clr r21
 
    ldi R28,low(String)
    ldi R29,high(String)
    lsl R28
    rol R29
    ldi r20, 0x1f
	add r28, r20
 
Start:
    out     portC,R17
    mov     R30,R28
    mov     R31,R29
    add     R30,R17
 
    lpm     R2,Z
    out     portA,R2
    cbi     portC,3
    sbi     portC,3
     
    dec  R19
    brne         PC-1
 
    ldi     R16,0xFF
    out     portA,R16
    cbi     portC,3
    sbi     portC,3
    inc     R17
    andi    R17,7
 
    dec r24
    brne pc-1
    dec r23
    brne pc-1
    dec r22
    brne pc-1
    dec r21
    brne start
    
    dec r28
    dec r20
    brne start
    ldi r20, 0x1f
    add r28, r20
    jmp start 
