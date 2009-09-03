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

msg db "First Stage Boot Loader!!!",13,10,0

Print:
	lodsb
	or al, al
	jz PrintDone
	mov ah, 0xe
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

.Reset:
	mov		ah, 0					; reset floppy disk function
	mov		dl, 0					; drive 0 is floppy drive
	int		0x13					; call BIOS
	jc		.Reset					; If Carry Flag (CF) is set, there was an error. Try resetting again

	mov		ax, 0x1000				; we are going to read sector to into address 0x1000:0
	mov		es, ax
	xor		bx, bx

.Read:
	mov		ah, 0x02				; function 2
	mov		al, 1					; read 1 sector
	mov		ch, 1					; we are reading the second sector past us, so its still on track 1
	mov		cl, 2					; sector to read (The second sector)
	mov		dh, 0					; head number
	mov		dl, 0					; drive number. Remember Drive 0 is floppy drive.
	int		0x13					; call BIOS - Read the sector
	jc		.Read					; Error, so try again

	jmp		0x1000:0x0				; jump to execute the sector!
	

times 510 - ($ - $$) db 0         ;Boot sector is of size 512 bytes. Fill the 
				;space after the last instruction i.e.,hlt 
				;until byte 510 with '0'.

dw 0xAA55			;Boot signature (If the 511 byte is 0xAA 
				;and the 512 byte is 0x55, INT 0x19 will 
				;load and execute the bootloader.).

cli
hlt
times 1024 - ($ - $$) db 0
