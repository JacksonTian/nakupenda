# $@ = target file
# $< = first dependency
# $^ = all dependencies

GCC = /usr/local/i386elfgcc/bin/i386-elf-gcc
LD = /usr/local/i386elfgcc/bin/i386-elf-ld

CFLAGS = -g

all:
	# 编译启动扇区
	nasm boot/boot.asm -f bin -o boot/boot.bin
	# 编译entry
	nasm boot/entry.asm -f elf -o boot/entry.o
	# ports
	${GCC} -ffreestanding -c drivers/ports.c -o drivers/ports.o
	# screen
	${GCC} -ffreestanding -c drivers/screen.c -o drivers/screen.o
	# util
	${GCC} -ffreestanding -c kernel/util.c -o kernel/util.o
	# 编译kernel.c
	${GCC} -ffreestanding -c kernel/kernel.c -o kernel/kernel.o
	# 链接kernel.o
	${LD} -o kernel.bin -Ttext 0x1000 boot/entry.o kernel/kernel.o \
		drivers/ports.o drivers/screen.o kernel/util.o --oformat binary
	# 反汇编
	ndisasm -b 32 kernel.bin > kernel.dis
	# 打包为一个镜像文件
	cat boot/boot.bin kernel.bin > os.img
	# 将镜像文件由软盘启动
	qemu-system-i386 -fda os.img -boot a

clean:
	rm *.o *.img *.bin *.dis
