;*********************************************
;	Stage2.asm
;		- Second Stage Bootloader
;
;	Operating Systems Development Series
;*********************************************

org 0x0500					; offset to 0, we will set segments later

bits 16					; we are still in real mode

; we are loaded at linear address 0x10000

jmp main				; jump to main

;*******************************************************
;	Preprocessor directives
;*******************************************************

%include "stdio.h"			; basic i/o routines

;*************************************************;
;	Second Stage Loader Entry Point
;************************************************;

main:

	;-------------------------------;
	;   Setup segments and stack	;
	;-------------------------------;

	cli				; clear interrupts
	xor	ax, ax			; null segments
	mov	ds, ax
	mov	es, ax
	mov	ax, 0x9000		; stack begins at 0x9000-0xffff
	mov	ss, ax
	mov	sp, 0xFFFF
	sti				; enable interrupts

	;-------------------------------;
	;   Print loading message	;
	;-------------------------------;

	mov	si, LoadingMsg
	call	Puts16

;*************************************************;
;	Data Section
;************************************************;

LoadingMsg	db	"Preparing to load operating system...",13,10,0

times 512 - ($ - $$) db 0

