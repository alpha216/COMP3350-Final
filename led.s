;---------------
; Assembly Code
;---------------
#define __SFR_OFFSET 0x00
#include "avr/io.h"
;------------------------
.global start
.global led
.global button          ; Make sure button is global if called from C
.equ BUTTON, PD2        ; define BUTTON pin
;------------------------
start:
    SBI   DDRB, 4             ; set PB4 (D12) as o/p
    SBI   DDRB, 5             ; set PB5 (D13) as o/p

    LDI   R21, 0x00           
    OUT   DDRD, R21           ; set all bits in portd as input
    
    RET                       ; return to setup() function
;---------------------------------------------------------------------------

button:
    IN    R22, PIND             ; read port D into R22
    ANDI  R22, (1<<BUTTON)      ; Mask everything except the button bit
    CPI   R22, (1<<BUTTON)      ; compare with pushed button value
    BREQ  ledOFF                ; if equal (High), branch to ledOFF
    
    LDI   R24, 0x01             ; load 1 into R24
    RCALL led                   ; call led subroutine 
    RET                         ; return to loop() function

led:
    CPI   R24, 0x00           ; value in R24 passed by caller compared with 0
    BREQ  ledOFF              ; jump (branch) if equal to subroutine ledOFF
    SBI   PORTB, 4            ; set D12 to high
    SBI   PORTB, 5            ; set D13 to high
    RCALL myDelay
    RET                       ; return to loop() function

ledOFF:
    CBI   PORTB, 4            ; set D12 to low
    CBI   PORTB, 5            ; set D13 to low
    RCALL myDelay
    RET                       ; return to loop() function

.equ  delayVal, 1000         ; Note: This value results in ~25ms delay, not 1000ms

myDelay:
    LDI   R20, 100            ; initial count value for outer loop
outerLoop:
    LDI   R30, lo8(delayVal)  ; low byte of delayVal in R30
    LDI   R31, hi8(delayVal)  ; high byte of delayVal in R31
innerLoop:
    SBIW  R30, 1              ; subtract 1 from 16-bit value in R31, R30
    BRNE  innerLoop           ; jump if countVal not equal to 0
    ;--------------
    SUBI  R20, 1              ; subtract 1 from R20
    BRNE  outerLoop

