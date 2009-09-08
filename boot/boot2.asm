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

;*************************************************;
;       Data Section
;************************************************;

LoadingMsg      db      "Preparing to load operating system...",13,10,0


;*******************************************************
;	Preprocessor directives
;*******************************************************

%include "stdio.h"			; basic i/o routines
%include "gdt.h"			; Gdt routines
%include "A20.h"

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

	;-------------------------------;
	;   Install our GDT		;
	;-------------------------------;

	call	InstallGDT		; install our GDT

	;-------------------------------;
	;   Enable A20			;
	;-------------------------------;

	call	EnableA20_SysControlA

	;-------------------------------;
	;   Go into pmode		;
	;-------------------------------;
	
	cli		; clear interrupts
	mov eax, cr0	; set bit 0 in cr0 -- enters pmode
	or eax, 1
	mov cr0, eax

	jmp CODE_DESC:Stage3	; far jump to fix CS

;******************************************************
;	ENTRY POINT FOR STAGE 3
;******************************************************

bits 32

Stage3:

	;-------------------------------;
	;   Set registers		;
	;-------------------------------;

	mov ax,  DATA_DESC	; set data segments to data selector (0x10)
	mov ds,  ax
	mov ss,  ax
	mov es,  ax
	mov esp, 90000h		; stack begins from 90000h

	;---------------------------------------;
	;   Clear screen and print success	;
	;---------------------------------------;

	call		ClrScr32
	mov		ebx, msg
	call		Puts32

loop:
	;xor ax,ax
	;int 16h
jmp loop

msg db  0x0A, 0x0A, 0x0A, "               <[ Zygote OS 0.01 ]>"
    db  0x0A, 0x0A,             "           Basic 32 bit Operating System", 0


times 512 - ($ - $$) db 0

