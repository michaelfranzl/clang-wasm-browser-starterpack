TARGET = main

$(TARGET): $(OBJFILES)
	$(LD) $(LDFLAGS) $(OBJFILES) -o $@.wasm
	wasm-opt $(TARGET).wasm -Oz -o $(TARGET).wasm
	wasm-strip $(TARGET).wasm
	wasm2wat $(TARGET).wasm > $(TARGET).wast
