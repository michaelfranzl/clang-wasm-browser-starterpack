WASI_SDK ?= /opt/wasi-sdk

WASM_LLVM ?= $(WASI_SDK)

CC = ${WASM_LLVM}/bin/clang
CXX = ${WASM_LLVM}/bin/clang++
LD = ${WASM_LLVM}/bin/wasm-ld

WASI_LIBC_INC ?= ${WASM_LLVM}/share/wasi-sysroot/include/wasm32-wasi
WASI_LIBC_LIB ?= ${WASM_LLVM}/share/wasi-sysroot/lib/wasm32-wasi

WASM_LIBCXX_LIB ?= ${WASM_LLVM}/share/wasi-sysroot/lib
WASM_LIBCXX_INC ?= ${WASM_LLVM}/share/wasi-sysroot/include

# WASM_COMPILER_RT_LIB ?= ${WASM_LLVM}/lib/clang/17/lib/wasi

CFLAGS_OPTIMIZATION = \
	-O3 \
	-flto

CFLAGS = \
	--target=wasm32-wasi \
	-I$(WASI_LIBC_INC) \
	$(CFLAGS_OPTIMIZATION)

# LIBCXX includes must come before LIBC includes.
CXXFLAGS = \
	--target=wasm32-wasi \
	-I$(WASM_LIBCXX_INC) \
	-I$(WASI_LIBC_INC) \
	$(CFLAGS_OPTIMIZATION)

LDFLAGS_OPTIMIZATION = \
	--lto-O3

LDFLAGS= \
	--no-entry \
	--export-dynamic \
	--import-undefined \
	$(LDFLAGS_OPTIMIZATION)
