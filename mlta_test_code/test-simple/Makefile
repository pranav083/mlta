# Define the compiler
CLANG := $(shell pwd)/../../llvm-project/prefix/bin/clang

# Flags for generating LLVM bitcode
BC_FLAGS := -emit-llvm -c

# Source files
SOURCES := multilayer_fp.c

# Derived names
BC_FILES := $(SOURCES:.c=.bc)
LLVM_IR_FILES := $(SOURCES:.c=.ll)

# Target files
TARGET := multilayer_fp
BC_LIST := bc.list

# Default target
all: $(TARGET) $(BC_FILES) $(LLVM_IR_FILES) $(BC_LIST)

# Build the executable
$(TARGET): $(SOURCES)
	$(CLANG) $(SOURCES) -o $(TARGET)

# Generate LLVM Bitcode
%.bc: %.c
	$(CLANG) $(BC_FLAGS) $< -o $@

# Generate LLVM IR
%.ll: %.bc
	llvm-dis $< -o $@

# Generate `bc.list`
$(BC_LIST): $(BC_FILES)
	@rm -f $(BC_LIST)
	@for bc in $(BC_FILES); do \
		echo "$$PWD/$$bc" >> $(BC_LIST); \
	done

clean:
	rm -f $(TARGET) $(BC_FILES) $(LLVM_IR_FILES) $(BC_LIST)
