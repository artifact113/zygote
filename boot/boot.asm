;************************************
; 1st Stags BOOT LOADER             *
; writen by : vijaymohan avullapati *
;************************************

bits 16                         ;Intel processors starts in realmode
                                ;(which is 16 bit). "bits 16" directive
                                ;specifies the assembler to generate the code
                                ;for processor running in 16-bit mode.

org 0x7c00 			;Soon after the boot intel processors start 
				;executing the Instructions from memory 
				;location 0x7c00 

start: jmp loader

msg db "First Stage Boot Loader!", 0

Print:
	lodsb
	or al, al
	jz PrintDone
	mov ah, 0eh
	int 10h
	jmp Print

PrintDone:
	ret

;-------------------------
;Boot Loader Entry Point -
;-------------------------
loader:

	xor ax, ax		;Make data segment & extended segments zero
	mov ds, ax		;as the addresses are based on 0x7c00:0000
	mov es, ax		;all the segments overlap with code segment.

	mov si, msg		;move the start address of string to si.
	call Print	

	xor ax, ax
	int 0x16		;get the amount of KB from the BIOS

	cli			;clear the interrupts.
	hlt			;halt the system.

times 510 - ($-$$) db 0         ;Boot sector is of size 512 bytes. Fill the 
				;space after the last instruction i.e.,hlt 
				;until byte 510 with '0'.

dw 0xAA55			;Boot signature (If the 511 byte is 0xAA 
				;and the 512 byte is 0x55, INT 0x19 will 
				;load and execute the bootloader.).

xor ax, ax
