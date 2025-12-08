;---------------
; Assembly Code
;---------------
#define __SFR_OFFSET 0x00
#include "avr/io.h"
;------------------------
.global start
.global button          
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
    BREQ  return                ; if equal (High), branch to return
    
    RCALL led                   ; call led subroutine 
    RCALL ledOFF                ; call ledOFF subroutine
    RET                         ; return

return:
    RET                         ; return

led:
    SBI   PORTB, 4            ; set D12 to high
    SBI   PORTB, 5            ; set D13 to high
    RCALL myDelay
    RET                       ; return

ledOFF:
    CBI   PORTB, 4            ; set D12 to low
    CBI   PORTB, 5            ; set D13 to low
    RCALL myDelay
    RET                       ; return 

.equ  delayVal, 1000          ; delay value 

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

