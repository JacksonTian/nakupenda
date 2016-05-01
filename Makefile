
boot.bin:
	nasm boot.asm -o boot.bin

run:
	qemu-system-x86_64 -cdrom boot.bin -hda hd.img -boot d

empty:
	nasm empty.asm -f bin -o empty.bin

boot:
	nasm y.asm -f bin -o y.bin
	qemu-system-x86_64 -fda y.bin -boot a