;*********************************************
;	Stage2.asm
;		- Second Stage Bootloader
;
;	Operating Systems Development Series
;*********************************************

org 0x0500					; offset to 0, we will set 
						; segments later

bits 16					; we are still in real mode

; we are loaded at linear address 0x0500

jmp smain				; jump to main

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

Reset1:
        xor ax, ax                                  ; reset floppy disk function
        mov             dl, 0h                                   ; drive 0 is floppy drive
        int             0x13                                    ; call BIOS
        jc              Reset1                                   ; If Carry Flag (CF) is set, there was an error. Try rese
        ret

Read1:
        mov             ah, 0x02                                ; function 2
        mov             al, 10                                   ; read 1 sector
        mov             ch, 0                                   ; we are reading the second sector past us, so its still on track 1
        mov             cl, 4                                   ; sector to read (The second sector)
        mov             dh, 0                                   ; head number
        mov             dl, 0                                   ; drive number. Remember Drive 0 is floppy drive.
        int             0x13                                    ; call BIOS - Read the sector
        jc              Read1
        ret


smain:

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


        call Reset1

        mov ax, 0x0800
        mov es, ax
        mov bx, 0x0000

        call Read1

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

	;call		ClrScr32
	;mov		ebx, msg
	;call		Puts32

	jmp CODE_DESC:0x8000

msg db  0x0A, 0x0A, 0x0A, "               <[ Zygote OS 0.01 ]>"
    db  0x0A, 0x0A,             "           Basic 32 bit Operating System", 0


times 1024 - ($ - $$) db 0

