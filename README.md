# Clang-WASM-Browser Starterpack

Minimal working examples of C and C++ software development targeting the web via WebAssembly.

## Background

Clang can directly emit WebAssembly since version 8. For simple scenarios, this allows a
lean and direct software development workflow targeting the web,
omitting more complete SDKs like [emscripten](https://emscripten.org/).

The [wasi-sdk](https://github.com/WebAssembly/wasi-sdk) project is a cornerstone in this workflow.
It contains no compiler or library code itself; it merely pulls in via *git submodules* the upstream
`llvm-project` tree, as well as the `wasi-libc` tree. It contributes a `Makefile` which compiles these
components using suitable flags.

[wasi-libc](https://github.com/WebAssembly/wasi-libc) is an
implementation of the C standard library which compiles down to [WASI](https://wasi.dev/) syscalls
(calls which would 'normally' be done into the OS kernel). The implementation of the actually
used syscalls has to be provided (in other words, *imported*) to the WebAssembly instance. Since we
are targeting the web, the implementation is provided by the JavaScript library
[@wasmer/wasi](https://github.com/wasmerio/wasmer-js/tree/master/packages/wasi) via the browser.

The `wasi-sdk` project lacks examples that show how it can be used; the present project aims to fill
that gap.


## Motivation

Inspired by the awesome [emscripten](https://emscripten.org/) project, I wanted to understand the
low-level mechanics of getting compiled C and C++ code to run in the browser, and to find the leanest
possible workflow.


## Running

### Using Nix

```sh
nix run
# Wait for it:
# Serving HTTP on 127.0.0.1 port 8000 (http://127.0.0.1:8000/) ...
```

Then open in your browser: http://127.0.0.1:8000 and click on one of the example directories.


### Manual

Download and extract or install [wasi-sdk Release 22](https://github.com/WebAssembly/wasi-sdk/releases/tag/wasi-sdk-22).

Set the path to the extracted or installed wasi-sdk as `WASI_SDK` (default: `/opt/wasi-sdk`) and run `make` in the `examples` subdirectory:

```sh
cd examples

WASI_SDK=/path/to/wasi-sdk make

# Start a generic web server:
python3 -m http.server 8000 --bind 127.0.0.1
```

Then open in your browser: http://127.0.0.1:8000 and click on one of the example directories.


## The Examples

The examples start as simple as possible, and then add more and more complexity:


### Plain C

* [Example 1: Exports](examples/01)
* [Example 2: Default imports](examples/02)
* [Example 3: Renamed imports](examples/03)

### C with Standard Library

* [Example 4: printf("Hello World!\n")](examples/04)

###  String handling

* [Example 5: Returning a string](examples/05)
* [Example 6: Passing a string to a function](examples/06)
* [Example 7: Calling int main(int argc, char* argv[])](examples/07)


### Plain C++

* [Example 10: Adding two numbers](examples/10)

### C++ with Standard Library

* [Example 11: Print a vector element](examples/11)
