;----------------------------------------------------------------------
; Titel : Beispiel "LED an" fuer ATmega8 / example "LED on" for ATmega;----------------------------------------------------------------------
; Funktion / function : LED wird angeschalten / LED is turned on
; Schaltung / connection : PORTB.0=LED1
;----------------------------------------------------------------------
.equ	F_CPU, 3686400
#define __SFR_OFFSET 0
#include <avr/io.h>
;----------------------------------------------------------------------
ldi r16, 0xFF
out DDRB, r16     ; Alle Pins am Port B durch Ausgabe von 0xFF ins
		  ; Richtungsregister DDRB als Ausgang konfigurieren

loop:
	ldi r16,0x01      
	out PORTB, r16    ; Inhalt von r16 an Port B ausgeben
rjmp loop         	  ; Sprung zu "loop:" -> Endlosschleife 
