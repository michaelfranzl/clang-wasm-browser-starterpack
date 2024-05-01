TARGET = main

$(TARGET): $(OBJFILES)
	$(LD) $(LDFLAGS) $(OBJFILES) -o $@.wasm
