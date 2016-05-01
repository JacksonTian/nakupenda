
boot.bin:
	nasm boot.asm -o boot.bin

run:
	qemu-system-x86_64 -cdrom boot.bin -hda hd.img -boot d

empty:
	nasm empty.asm -f bin -o empty.bin

boot:
	nasm y.asm -f bin -o y.bin
	# 将y.bin作为软盘A加载，从a启动
	qemu-system-x86_64 -fda y.bin -boot a

kernel:
	# 编译启动扇区
	nasm boot.asm -f bin -o boot.bin
	# 编译kernel.c
	gcc -ffreestanding -c kernel.c -o kernel.o
	# 链接kernel.o
	ld -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary
	# 打包为一个镜像文件
	cat boot.bin kernel.bin > os.img
	# 将镜像文件由软盘启动
	qemu-system-x86_64 -fda os.img -boot a
