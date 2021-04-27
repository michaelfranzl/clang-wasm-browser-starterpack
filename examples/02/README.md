# Example 2 - Plain C with imports

This basic example uses plain C (doesn't use the C standard library). Two JavaScript-implemented
functions (`square` and `square_root`) are supplied by the browser runtime to the WebAssembly
instance. The functions are called from the C-implemented function `hypotenuse`. The result
is printed to the browser console.

## Notes

Compared to example 1, we need the linker flag `--unresolved-symbols=import-functions`. This allows
the program to compile despite the undefined functions, because the linking is deferred to the
point in time when the WebAssembly program is instantiated in the browser with an import object,
which contains the missing functions.

To be able to distinguish if a function should indeed be imported, or if it simply was forgotten to
be defined, you could use `--allow-undefined-file=my-list-of-imports.txt` instead of
`--unresolved-symbols=import-functions`. You would then put a newline-separated list of function
names into this file, doubling as documentation.
