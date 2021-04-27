CC=../../wasi-sdk/build/install/opt/wasi-sdk/bin/clang
LD=../../wasi-sdk/build/install/opt/wasi-sdk/bin/wasm-ld

# Optional flags which can optimize the WebAssembly binaries in space (size) and time (speed).
CFLAGS_OPTIMIZATION = \
	-O3 \
	-flto \
	-fwhole-program-vtables \
	-fvirtual-function-elimination

CFLAGS= \
	--sysroot ../../wasi-sdk/build/install/opt/wasi-sdk/share/wasi-sysroot \
	$(CFLAGS_OPTIMIZATION)

LDFLAGS_OPTIMIZATION = \
	--lto-O3

LDFLAGS= \
  --no-entry \
  --export-dynamic \
	--unresolved-symbols=import-functions \
	$(LDFLAGS_OPTIMIZATION)
