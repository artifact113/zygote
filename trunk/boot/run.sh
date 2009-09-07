nasm -f bin boot1.asm -o boot.flp
nasm -f bin boot2.asm -o boot
cat boot >> boot.flp
#rm -f boot
