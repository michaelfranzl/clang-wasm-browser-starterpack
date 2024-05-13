include ../flags.mk

OBJFILES = main.o

LDFLAGS += \
	-L${WASI_LIBC_LIB} \
	-L${WASM_LIBCXX_LIB} \
	-L${WASM_COMPILER_RT_LIB} \
	-lc \
	-lc++ \
	-lc++abi \
	-lclang_rt.builtins-wasm32 \
	--import-memory

include ../rules.mk

install:
	mkdir -p ${PREFIX}/11
	cp index.html index.js main.wasm README.md ${PREFIX}/11
