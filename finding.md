
# LLVM Kanalyzer Results and Analysis

This README details the findings and issues encountered while running the `kanalyzer` tool on LLVM bitcode files. It provides insights into the opaque pointer problem introduced in LLVM 15+ and the resolution of related issues.

----------

## **Test Results**

### **Test Case 1: Simple Case**

```bash
mighty@ubuntu22:~/mlta$ ./build/lib/kanalyzer @mlta_test_code/test-simple/bc.list 
Total 2 file(s)
./build/lib/kanalyzer: error loading file '/home/mighty/mlta/mlta_test_code/test-simple'
[CallGraph] Initializing 1 modules #0 Initializing: /home/mighty/mlta/mlta_test_code/test-simple/multilayer_fp.bc
.
[CallGraph / 1] [1 / 1] [/home/mighty/mlta/mlta_test_code/test-simple/multilayer_fp.bc]
	 Indirect-call targets: (1)
	 Indirect-call targets: (1)
	 Indirect-call targets: (1)
	 Indirect-call targets: (1)
	 Indirect-call targets: (1)
	 Indirect-call targets: (1)
	 Indirect-call targets: (1)
	 Indirect-call targets: (1)
[CallGraph] Updated in 0 modules.
[CallGraph] Postprocessing ...
[CallGraph] Done!

@@ Total number of final callees: 8.
############## Result Statistics ##############
# Number of indirect calls: 			8
# Number of indirect calls with targets: 	8
# Number of indirect-call targets: 		8
# Number of address-taken functions: 		8
# Number of multi-layer calls: 			8
# Number of multi-layer targets: 		8
# Number of one-layer calls: 			0
# Number of one-layer targets: 			0

```

**Findings:**

-   **Indirect Calls:** 8 indirect calls were successfully analyzed.
-   **Complexity:** This test involved nested function pointer structures, and all targets were resolved correctly.
-   **Tool Behavior:** No issues with opaque pointers were observed in this simpler case.

----------

### **Test Case 2: Medium Complexity**

```bash
mighty@ubuntu22:~/mlta$ ./build/lib/kanalyzer @mlta_test_code/test-medium/bc.list
Total 1 file(s)
[CallGraph] Initializing 1 modules #0 Initializing: /home/mighty/mlta/mlta_test_code/test-medium/multilayer_fp.bc
[CallGraph / 1] [1 / 1] [/home/mighty/mlta/mlta_test_code/test-medium/multilayer_fp.bc]
	 Indirect-call targets: (1)
	 Indirect-call targets: (1)
[CallGraph] Updated in 0 modules.
[CallGraph] Postprocessing ...
[CallGraph] Done!

@@ Total number of final callees: 2.
############## Result Statistics ##############
# Number of indirect calls: 			2
# Number of indirect calls with targets: 	2
# Number of indirect-call targets: 		2
# Number of address-taken functions: 		2
# Number of multi-layer calls: 			2
# Number of multi-layer targets: 		2
# Number of one-layer calls: 			0
# Number of one-layer targets: 			0

```

**Findings:**

-   **Indirect Calls:** 2 indirect calls were analyzed.
-   **Simplified Analysis:** Reduced complexity compared to the first test case.
-   **Result:** The analysis completed successfully without encountering issues.

----------

### **Test Case 3: High Complexity**

```bash
mighty@ubuntu22:~/mlta$ ./build/lib/kanalyzer @mlta_test_code/test-high/bc.list
Total 1 file(s)
[CallGraph] Initializing 1 modules #0 Initializing: /home/mighty/mlta/mlta_test_code/test-high/multilayer_fp.bc

kanalyzer: /home/mighty/mlta/llvm-project/prefix/include/llvm/IR/Type.h:381: 
llvm::Type *llvm::Type::getNonOpaquePointerElementType() const: 
Assertion `NumContainedTys && "Attempting to get element type of opaque pointer"' failed.

 #0  0x00005969bce592e5 PrintStackTraceSignalHandler(void*) Signals.cpp:0:0
 #1  0x00005969bce569de SignalHandler(int) Signals.cpp:0:0
 #2  0x00007199cb242520 (/lib/x86_64-linux-gnu/libc.so.6+0x42520)
 #3  0x00007199cb2969fc pthread_kill (/lib/x86_64-linux-gnu/libc.so.6+0x969fc)
 #4  0x00007199cb242476 gsignal (/lib/x86_64-linux-gnu/libc.so.6+0x42476)
 #5  0x00007199cb2287f3 abort (/lib/x86_64-linux-gnu/libc.so.6+0x287f3)
 #6  0x00007199cb22871b (/lib/x86_64-linux-gnu/libc.so.6+0x2871b)
 #7  0x00007199cb239e96 (/lib/x86_64-linux-gnu/libc.so.6+0x39e96)
 #8  0x00005969bcd9ceb7 llvm::Type::getNonOpaquePointerElementType() const 
      /home/mighty/mlta/llvm-project/prefix/include/llvm/IR/Type.h:0:5
 #9  0x00005969bcd990f5 llvm::Type::getPointerElementType() const 
      /home/mighty/mlta/llvm-project/prefix/include/llvm/IR/Type.h:372:5
#10  0x00005969bcd95499 MLTA::getBaseType(llvm::Value*, 
      std::set<llvm::Value*, std::less<llvm::Value*>, 
      std::allocator<llvm::Value*> >&) 
      /home/mighty/mlta/src/lib/MLTA.cc:891:19
#11  0x00005969bcd95c5d MLTA::getBaseTypeChain(std::__cxx11::list<
      std::pair<llvm::Type*, int>, 
      std::allocator<std::pair<llvm::Type*, int> > >&, 
      llvm::Value*, bool&) 
      /home/mighty/mlta/src/lib/MLTA.cc:831:14
#12  0x00005969bcd94027 MLTA::confineTargetFunction(llvm::Value*, llvm::Function*) 
      /home/mighty/mlta/src/lib/MLTA.cc:680:2
#13  0x00005969bcd93bec MLTA::typeConfineInFunction(llvm::Function*) 
      /home/mighty/mlta/src/lib/MLTA.cc:470:3
#14  0x00005969bcd86830 CallGraphPass::doInitialization(llvm::Module*) 
      /home/mighty/mlta/src/lib/CallGraph.cc:205:3
#15  0x00005969bcd76cb2 IterativeModulePass::run(
      std::vector<std::pair<llvm::Module*, llvm::StringRef>, 
      std::allocator<std::pair<llvm::Module*, llvm::StringRef> > >&) 
      /home/mighty/mlta/src/lib/Analyzer.cc:61:13
#16  0x00005969bcd77973 main 
      /home/mighty/mlta/src/lib/Analyzer.cc:172:9
#17  0x00007199cb229d90 (/lib/x86_64-linux-gnu/libc.so.6+0x29d90)
#18  0x00007199cb229e40 __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29e40)
#19  0x00005969bcd3eda5 _start (./build/lib/kanalyzer+0x77da5)

PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ 
and include the crash backtrace.

Stack dump:
0.	Program arguments: ./build/lib/kanalyzer @mlta_test_code/test-high/bc.list
Aborted (core dumped)


```

**Findings:**

-   **Crash Due to Opaque Pointers:** The tool encountered an assertion failure when attempting to retrieve the type of an opaque pointer.
-   **Analysis Incomplete:** The analysis failed, resulting in a segmentation fault.

----------

## **Opaque Pointers in LLVM 15+**

### **What are Opaque Pointers?**

-   Starting with LLVM 15, pointers are no longer tied to a specific type. Instead, they are treated as "opaque," meaning type information must be inferred from the context of usage rather than being explicitly embedded in the pointer.

### **Impact on Tools:**

-   Tools like `kanalyzer` that rely on the older method `getPointerElementType()` will fail when used with opaque pointers. This is because the method asserts when it attempts to retrieve type information from an opaque pointer.

----------

### **Kernel Analysis: Linux 5.1**

#### **Command and Output**

```bash
mighty@ubuntu22:~/mlta$ ./build/lib/kanalyzer @bc.list
[CallGraph / 1] [2384 / 2384] [/home/mighty/kernel/linux-5.1/block/blk-timeout.bc]

[CallGraph] Updated in 0 modules.
[CallGraph] Postprocessing ...
[CallGraph] Done!

@@ Total number of final callees: 321025.
############## Result Statistics ##############
# Number of indirect calls: 			20720
# Number of indirect calls with targets: 	16444
# Number of indirect-call targets: 		321025
# Number of address-taken functions: 		32508
# Number of multi-layer calls: 			14025
# Number of multi-layer targets: 		51480
# Number of one-layer calls: 			5898
# Number of one-layer targets: 			269545

```

#### **Findings**

-   **Scale:** Analyzed the Linux kernel 5.1 with over 2,000 modules.
-   **Indirect Calls:** A large number of indirect calls (20,720) were analyzed.
-   **Indirect Targets:** The analysis identified 321,025 unique targets.
-   **Multi-layer Analysis:** A significant portion of the calls were multi-layered (14,025), with 51,480 targets.

----------

## **Recommendations**

1.  **Avoid Opaque Pointers:**
    
    -   Compile bitcode using the `-Xclang -no-opaque-pointers` flag to revert to older pointer behavior:
        
        ```bash
        clang -emit-llvm -Xclang -no-opaque-pointers -c source.c -o source.bc
        
        ```
        
2.  **Simplify Test Code:**
    
    -   Avoid deeply nested or overly complex structures when debugging tools that may not fully support opaque pointers.
