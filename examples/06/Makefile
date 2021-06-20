include ../../flags.mk

OBJFILES = main.o

LDFLAGS += \
	-L $(WASI_SDK)/share/wasi-sysroot/lib/wasm32-wasi \
	-lc \
	-export malloc \
	--import-memory

include ../../rules.mk
