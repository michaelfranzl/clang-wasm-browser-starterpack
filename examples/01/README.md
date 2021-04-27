# Example 1 - Plain C, only exports, two C files compiled into one WASM binary

The terms "exports" and "imports" are commonly meant relative to the WebAssembly instance. In other
words, an "export" makes a compiled C/C++ function callable from JavaScript; an "import" makes a
JavaScript function callable from compiled C/C++ code.

This most basic example uses plain C (doesn't use the C standard library). It only exports functions
to the browser runtime (it doesn't import any functions from the runtime). It compiles two C
functions (`add` and `subtract`), defined in separate files, and links them into a single WASM
binary. Both functions are called from plain ES8/JavaScript (doesn't use any libraries), and the two
results (`42` and `42`) are printed to the browser console.

The C functions need to be given visibility by setting their compiler attribute `visibility` to
`default`, otherwise they will not be exported.
