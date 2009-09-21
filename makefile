all:
	nasm -f bin boot/boot1.asm -o boot1.o
	nasm -f  bin boot/boot2.asm -o boot2.o
	nasm -f  aout kernel/kernel_start.asm -o ks.o
	gcc -fno-builtin -c kernel/kernel.c kernel/print.c arch/x86/cpu.c \
	arch/x86/idt.c lib/string.c kernel/exception.c arch/x86/pic.c arch/x86/pit.c \
	arch/x86/hw_init.c
	ld -T kernel/kernel.ld -o kernel.out ks.o kernel.o cpu.o idt.o print.o string.o exception.o pic.o pit.o hw_init.o
	cat boot2.o >> boot1.o
	cat kernel.out >> boot1.o
	mv boot1.o boot.img
	rm -f  boot1.o boot2.o ks.o kernel.o cpu.o idt.o kernel.out print.o \
	string.o pic.o pit.o hw_init.o exception.o