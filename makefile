all:
	nasm -f bin boot/boot1.asm -o boot/boot1.o
	nasm -f  bin boot/boot2.asm -o boot/boot2.o
	nasm -f  aout kernel/kernel_start.asm -o kernel/ks.o
	gcc -c kernel/kernel.c -o kernel/kernel.o
	ld -T kernel/kernel.ld -o kernel/kernel.out kernel/ks.o kernel/kernel.o
	cat boot/boot2.o >> boot/boot1.o
	cat kernel/kernel.out >> boot/boot1.o
	mv boot/boot1.o boot.img
	rm -f boot/boot2.o kernel/ks.o kernel/kernel.o kernel/kernel.out boot/boot1.o
