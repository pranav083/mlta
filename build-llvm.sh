#!/bin/bash -e


# LLVM version: 15.0.0 older version at checkout only
# latest LLVM 19.1.7  build at tag 
ROOT=$(pwd)
git clone -b llvmorg-19.1.7 --single-branch https://github.com/llvm/llvm-project.git
cd $ROOT/llvm-project
#git checkout e758b77161a7
git checkout llvmorg-19.1.7
if [ ! -d "build" ]; then
  mkdir build
fi

cd build

cmake -DLLVM_TARGET_ARCH="X86" \
			-DLLVM_TARGETS_TO_BUILD="ARM;X86;AArch64" \
			-DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=WebAssembly \
			-DCMAKE_BUILD_TYPE=Release \
			-DLLVM_ENABLE_PROJECTS="clang;lldb" \
   			-DCMAKE_CXX_FLAGS="-latomic" \
			-G "Unix Makefiles" \
			../llvm

make -j$(nproc)

if [ ! -d "$ROOT/llvm-project/prefix" ]; then
  mkdir $ROOT/llvm-project/prefix
fi

cmake -DCMAKE_INSTALL_PREFIX=$ROOT/llvm-project/prefix -P cmake_install.cmake
