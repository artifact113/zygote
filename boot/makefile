all:
	nasm -f bin boot1.asm -o boot.flp
	nasm -f  bin boot2.asm -o boot2.o
	nasm -f  aout kernel_start.asm -o ks.o
	gcc -c kernel.c -o kernel.o
	ld -T kernel.ld ks.o kernel.o
	cat boot2.o >> boot.flp
	cat a.out >> boot.flp
