# Example 4: C with Standard Library: printf("Hello World!\n")

Compared to previous examples, we need to add `-lc` (`libc`) to the linker flags. The WebAssembly
build now depends on imports like `fd_close`, `fd_write`, etc., which are equivalent to operating
system calls. Such a System Interface API for WebAssembly programs will have to be supplied in the
WebAssembly runtime environment, e.g. [WASI](https://github.com/webassembly/wasi).

The JavaScript library
[@wasmer/wasi](https://github.com/wasmerio/wasmer-js/tree/master/packages/wasi) provides such a WASI
implementation. `stdout` is implemented as a file, just like on Unix, and
[@wasmer/wasmfs](https://github.com/wasmerio/wasmfs) is a suitable implementation in JavaScript.

The WebAssembly build grows to about 4 kB.
