;************************************
; 1st Stags BOOT LOADER             *
; writen by : vijaymohan avullapati *
;************************************

org 0x7c00 			;Soon after the boot intel processors start 
				;executing the Instructions from memory 
				;location 0x7c00 

bits 16				;Intel processors starts in realmode 
				;(which is 16 bit). "bits 16" directive 
				;specifies the assembler to generate the code 
				;for processor running in 16-bit mode.

start:

	cli			;clear the interrupts.
	hlt			;halt the system.

times 510 - ($-$$) db 0         ;Boot sector is of size 512 bytes. Fill the 
				;space after the last instruction i.e.,hlt 
				;until byte 510 with '0'.

dw 0xAA55			;Boot signature (If the 511 byte is 0xAA 
				;and the 512 byte is 0x55, INT 0x19 will 
				;load and execute the bootloader.).

