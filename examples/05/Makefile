include ../flags.mk

OBJFILES = main.o

LDFLAGS += \
	--import-memory

include ../rules.mk

install:
	mkdir -p ${PREFIX}/05
	cp index.html index.js main.wasm README.md ${PREFIX}/05
