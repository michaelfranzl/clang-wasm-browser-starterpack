include ../flags.mk

OBJFILES = main.o

LDFLAGS += \
	-L${WASI_LIBC_LIB} \
	-lc \
	-export malloc \
	-export free \
	--import-memory

include ../rules.mk

install:
	mkdir -p ${PREFIX}/07
	cp index.html index.js main.wasm README.md ${PREFIX}/07
