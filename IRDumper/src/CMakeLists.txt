cmake_minimum_required(VERSION 3.5.1)
project(DUMPER)

# Find LLVM 19+ with required components
find_package(LLVM 19.1 REQUIRED CONFIG
  COMPONENTS
    Core
    Passes
    Analysis
    Support
    TransformUtils
)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include(CheckCXXCompilerFlag)

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

add_subdirectory(lib)

# For executables, use:
# add_executable(dumper_main main.cpp)
# target_link_libraries(dumper_main PRIVATE ${LLVM_LIBS} DumperObj)
