;-----------------------
;2nd Stage Boot Loader -
;-----------------------

bits 16

org 0x00

msg2 db "Secong Stage Bootloader", 0

jmp start

Print2:
        lodsb
        or al, al
        jz PrintDone2
        mov ah, 0xe
        int 10h
        jmp Print2

PrintDone2:
        ret

start:
        mov si, msg2             ;move the start address of string to si.
        call Print2

        cli                     ;clear the interrupts.
        hlt                     ;halt the system.

times 512 - ($ - $$) db 0

