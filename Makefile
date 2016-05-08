# $@ = target file
# $< = first dependency
# $^ = all dependencies

GCC = /usr/local/i386elfgcc/bin/i386-elf-gcc
LD = /usr/local/i386elfgcc/bin/i386-elf-ld

C_SOURCES = $(wildcard kernel/*.c drivers/*.c cpu/*.c libc/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h cpu/*.h libc/*.h)
# Nice syntax for file extension replacement
OBJ = ${C_SOURCES:.c=.o cpu/interrupt.o}

CFLAGS = -g

debug:
	echo ${C_SOURCES}
	echo ${HEADERS}
	echo ${OBJ}

%.o: %.c ${HEADERS}
	${GCC} -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

kernel.bin: boot/entry.o ${OBJ}
	# 链接kernel.o
	${LD} -o $@ -Ttext 0x1000 $^ --oformat binary

os-image.bin: boot/boot.bin kernel.bin
	cat $^ > $@

run: os-image.bin
	# 将镜像文件由软盘启动
	qemu-system-i386 -fda os-image.bin -boot a

boot:
	# 编译启动扇区
	nasm boot/boot.asm -f bin -o boot/boot.bin
	# 编译entry
	nasm boot/entry.asm -f elf -o boot/entry.o

clean:
	rm -rf *.bin *.dis *.o os-image.bin *.elf
	rm -rf kernel/*.o boot/*.bin drivers/*.o boot/*.o cpu/*.o libc/*.o
