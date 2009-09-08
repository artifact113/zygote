nasm -f bin boot1.asm -o boot.flp
nasm -f aout boot2.asm -o boot2.o
gcc -c kernel.c -o kernel.o
ld -T kernel.ld boot2.o kernel.o
cat a.out >> boot.flp
#rm -f boot
