

KBUILD_USERCFLAGS += -Wno-error -g -Xclang -no-opaque-pointers -Xclang -flegacy-pass-manager -Xclang -load -Xclang /home/mighty/mlta/IRDumper/build/lib/libDumper.so
KBUILD_CFLAGS += -Wno-error -g -Xclang -no-opaque-pointers -Xclang -flegacy-pass-manager -Xclang -load -Xclang /home/mighty/mlta/IRDumper/build/lib/libDumper.so
KBUILD_USERCFLAGS += -emit-llvm
