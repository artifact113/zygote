;*************************************************
;	Gdt.inc
;		-GDT Routines
;
;
;*************************************************

%ifndef __GDT_H__
%define __GDT_H__

bits	16

;*******************************************
; InstallGDT()
;	- Install our GDT
;*******************************************

InstallGDT:
	cli		; clear interrupts
	pusha		; save registers
	lgdt  [toc]	; load GDT into GDTR
	sti		; enable interrupts
	popa		; restore registers
	ret		; All done! 

;*******************************************
; Global Descriptor Table (GDT)
;*******************************************

gdt_data: 
	dd 0                ; null descriptor
	dd 0 

; gdt code:	            ; code descriptor
	dw 0FFFFh           ; limit low
	dw 0                ; base low
	db 0                ; base middle
	db 10011010b        ; access
	db 11001111b        ; granularity
	db 0                ; base high

; gdt data:	            ; data descriptor
	dw 0FFFFh           ; limit low (Same as code)10:56 AM 7/8/2007
	dw 0                ; base low
	db 0                ; base middle
	db 10010010b        ; access
	db 11001111b        ; granularity
	db 0                ; base high
	
end_of_gdt:
toc:
	dw end_of_gdt - gdt_data - 1	; limit (Size of GDT)
	dd gdt_data			; base of GDT

%define NULL_DESC 0
%define CODE_DESC 0x8
%define DATA_DESC 0x10

%endif ;__GDT_H__
