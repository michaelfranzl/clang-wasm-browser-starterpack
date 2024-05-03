include ../../flags.mk

OBJFILES = main.o

LDFLAGS += \
	-L${WASI_LIBC_LIB} \
	-lc \
	-export malloc \
	-export free \
	--import-memory

include ../../rules.mk
