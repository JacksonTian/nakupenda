GCC = /usr/local/i386elfgcc/bin/i386-elf-gcc
LD = /usr/local/i386elfgcc/bin/i386-elf-ld

all:
	# 编译启动扇区
	nasm boot/boot.asm -f bin -o boot.bin
	# 编译entry
	nasm boot/entry.asm -f elf -o entry.o
	# 编译kernel.c
	${GCC} -ffreestanding -c kernel/kernel.c -o kernel.o
	# 链接kernel.o
	${LD} -o kernel.bin -Ttext 0x1000 entry.o kernel.o --oformat binary
	# 反汇编
	ndisasm -b 32 kernel.bin > kernel.dis
	# 打包为一个镜像文件
	cat boot.bin kernel.bin > os.img
	# 将镜像文件由软盘启动
	qemu-system-i386 -fda os.img -boot a

clean:
	rm *.o
	rm *.img
	rm *.bin
