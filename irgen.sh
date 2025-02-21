#!/bin/bash

# Configurations
KERNEL_SRC="$(pwd)/../kernel/linux-6.1.1"
IRDUMPER="$(pwd)/IRDumper/build/lib/libDumper.so"
CLANG="$(pwd)/llvm-project/prefix/bin/clang"
CONFIG="defconfig"
# CONFIG="allyesconfig"


export CC="/home/mighty/script/ssrg/mlta/llvm-project/prefix/bin/clang"
export LLVM=1  # This signals the build system to use LLVM/Clang


# Use -Wno-error to avoid turning warnings into errors
NEW_CMD="
KBUILD_USERCFLAGS += -Wno-error -g -Xclang -load -Xclang $IRDUMPER -emit-llvm
KBUILD_CFLAGS += -Wno-error -g -Xclang -load -Xclang $IRDUMPER -emit-llvm
KBUILD_USERCFLAGS += -emit-llvm
"

# Backup Makefile if not already backed up
if [ ! -f "$KERNEL_SRC/Makefile.bak" ]; then
    echo "Backing up Linux Makefile..."
    cp "$KERNEL_SRC/Makefile" "$KERNEL_SRC/Makefile.bak"
fi

# Append new flags to Makefile only if not already appended
if ! grep -q "KBUILD_USERCFLAGS += -emit-llvm" "$KERNEL_SRC/Makefile"; then
    echo "Updating Linux Makefile with custom flags..."
    echo -e "$NEW_CMD" > "$KERNEL_SRC/IRDumper.cmd"
    cat "$KERNEL_SRC/Makefile.bak" "$KERNEL_SRC/IRDumper.cmd" > "$KERNEL_SRC/Makefile"
else
    echo "Linux Makefile already updated."
fi

# Build kernel configuration
cd "$KERNEL_SRC" || exit
make "$CONFIG"
echo "Compiler: $CLANG"
echo "Flags added: $NEW_CMD"

# Function to build bitcode
build_bitcode() {
    echo "Building with LLVM bitcode generation..."
    cd "$KERNEL_SRC" || exit
    # Use Clang consistently for all make calls
    make CC="$CLANG" -j"$(nproc)" -k -i

    echo "Generating bc.list..."
    find "$KERNEL_SRC" -name "*.bc" > "$KERNEL_SRC/bc.list"
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
    cd "$KERNEL_SRC" || exit
    make clean
    rm -f "$KERNEL_SRC/bc.list"
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
