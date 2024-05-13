include ../flags.mk

OBJFILES = main.o

LDFLAGS += \
	-L${WASI_LIBC_LIB} \
	-lc \
	--import-memory

include ../rules.mk

install:
	mkdir -p ${PREFIX}/04
	cp index.html index.js main.wasm README.md ${PREFIX}/04
