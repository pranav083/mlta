#!/bin/bash

# Configurations
KERNEL_SRC="$(pwd)/../kernel/linux-simple"
IRDUMPER="$(pwd)/IRDumper/build/lib/libDumper.so"
CLANG="$(pwd)/llvm-project/prefix/bin/clang"
CONFIG="defconfig"
#CONFIG="allyesconfig"

# Use -Wno-error to avoid turning warnings into errors
NEW_CMD="\n\n\
KBUILD_USERCFLAGS += -Wno-error -g -Xclang -no-opaque-pointers -Xclang -flegacy-pass-manager -Xclang -load -Xclang $IRDUMPER\n\
KBUILD_CFLAGS += -Wno-error -g -Xclang -no-opaque-pointers -Xclang -flegacy-pass-manager -Xclang -load -Xclang $IRDUMPER\n\
KBUILD_USERCFLAGS += -emit-llvm"

# Check if backup of Makefile exists
if [ ! -f "$KERNEL_SRC/Makefile.bak" ]; then
    echo "Backing up Linux Makefile..."
    cp $KERNEL_SRC/Makefile $KERNEL_SRC/Makefile.bak
fi

# Append new flags to Makefile
echo -e $NEW_CMD >$KERNEL_SRC/IRDumper.cmd
cat $KERNEL_SRC/Makefile.bak $KERNEL_SRC/IRDumper.cmd >$KERNEL_SRC/Makefile

# Function to build bitcode
build_bitcode() {
    echo "Building kernel with LLVM bitcode generation..."
    cd $KERNEL_SRC && make #$CONFIG
    make CC=$CLANG -j$(nproc) -k -i

    echo "Generating bc.list..."
    find $KERNEL_SRC -name "*.bc" > $KERNEL_SRC/bc.list
    echo "Generated bc.list at $KERNEL_SRC/bc.list"
}

# Function to generate LLVM IR
generate_llvm_ir() {
    if [ ! -f "$KERNEL_SRC/bc.list" ]; then
        echo "Error: bc.list not found. Run './irgen_multiple.sh bitcode' first."
        exit 1
    fi

    echo "Generating LLVM IR from bitcode..."
    while IFS= read -r bcfile; do
        llvm-dis "$bcfile"
    done < "$KERNEL_SRC/bc.list"
    echo "LLVM IR generation complete."
}

# Function to clean build
clean_build() {
    echo "Cleaning build directory and removing bc.list..."
    cd $KERNEL_SRC && make clean
    rm -f $KERNEL_SRC/bc.list
    echo "Clean-up complete."
}

# Handle script arguments
case "$1" in
    bitcode)
        build_bitcode
        ;;
    llvm-ir)
        generate_llvm_ir
        ;;
    clean)
        clean_build
        ;;
    *)
        echo "Usage: $0 {bitcode|llvm-ir|clean}"
        exit 1
        ;;
esac
