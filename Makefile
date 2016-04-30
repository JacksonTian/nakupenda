
boot.bin:
	nasm boot.asm -o boot.bin

run:
	qemu-system-x86_64 boot.bin

empty:
	nasm empty.asm -f bin -o empty.bin
