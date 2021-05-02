include ../../flags.mk

OBJFILES = main.o

LDFLAGS += \
	-L ../../wasi-sdk/build/install/opt/wasi-sdk/share/wasi-sysroot/lib/wasm32-wasi \
	-lc \
	--import-memory

include ../../rules.mk
