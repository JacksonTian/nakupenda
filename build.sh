export CC=/usr/local/bin/gcc-5
export LD=/usr/local/bin/gcc-5

export PREFIX="/usr/local/i386elfgcc"
export TARGET=i386-elf
export PATH="$PREFIX/bin:$PATH"

mkdir -p /tmp/src
cd /tmp/src
mkdir binutils-build
cd binutils-build
../binutils-2.26/configure --target=$TARGET --enable-interwork --enable-multilib --disable-nls --disable-werror --prefix=$PREFIX --with-system-zlib 2>&1 | tee configure.log
make all install 2>&1 | tee make.log

cd /tmp/src
tar xf gcc-6.1.0.tar.gz
mkdir gcc-build
cd gcc-build
../gcc-6.1.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --disable-libssp --enable-languages=c --without-headers
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc


./configure --disable-debug --disable-dependency-tracking --program-prefix=g --disable-werror --enable-interwork --enable-multilib --enable-ld --enable-64-bit-bfd --enable-targets=all
make
make install
