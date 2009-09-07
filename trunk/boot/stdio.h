;----------------------------------
;stdio.h
;	-Input/Output functions
;writen by : vijaymohan avullapati
;----------------------------------

%ifndef __STDIO_H__
%define __STDIO_H__

;************************************************;
;	Puts16 ()
;		-Prints a null terminated string
;	DS=>SI: 0 terminated string
;************************************************;

bits 16

Puts16:
	pusha
 .Loop1:
	lodsb
	or al, al
	jz Puts16Done
	mov ah, 0eh
	int 10h
	jmp .Loop1
Puts16Done:
	popa
	ret

%endif ;__STDIO_H__
