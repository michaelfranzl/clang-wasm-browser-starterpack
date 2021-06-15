include ../../flags.mk

OBJFILES = main.o

LDFLAGS += \
	-L $(WASI_SDK)/share/wasi-sysroot/lib/wasm32-wasi \
	-L $(WASI_SDK)/lib/clang/12.0.0/lib/wasi \
	-lc \
	-lc++ \
	-lc++abi \
	-lclang_rt.builtins-wasm32 \
	--import-memory

include ../../rules.mk
