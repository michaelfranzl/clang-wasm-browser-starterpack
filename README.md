# clang-wasm-browser-starterpack

Minimal working examples of C and C++ software development targeting the web via WebAssembly.


## Background

LLVM/Clang can directly emit WebAssembly since version 8. For simple scenarios, this allows a
lean and direct software development workflow targeting the web,
omitting more complete SDKs like [emscripten](https://emscripten.org/).

The [wasi-sdk](https://github.com/WebAssembly/wasi-sdk) project is a cornerstone in this workflow.
It contains no compiler or library code itself; it merely pulls in via git submodules the upstream
`clang` tree, as well as the `wasi-libc` tree. It contributes a `Makefile` which compiles both
projects using suitable flags (most notably disabling pthreads which is [not yet supported in
wasi-libc](https://github.com/WebAssembly/wasi-libc/issues/209).

The other cornerstone in this workflow, [wasi-libc](https://github.com/WebAssembly/wasi-libc) is an
implementation of the C standard library which compiles down to [WASI](https://wasi.dev/) syscalls
(calls which would 'normally' be done into the an OS kernel). The implementation of the actually
used syscalls have to be provided (in other words, imported) to the WebAssembly instance. Since we
are targeting the web, the implementation is provided by the JavaScript library
[@wasmer/wasi](https://github.com/wasmerio/wasmer-js/tree/master/packages/wasi) via the browser.

After the building of `wasi-sdk`, the entire toolchain (version 12 of `clang`, `clang++`, `wasm-ld`,
etc.) will be installed in the sub-directory `./wasi-sdk/build/install/opt/wasi-sdk`.

The `wasi-sdk` project lacks examples that show how it can be used; the present project aims to fill
that gap.


## Motivation

Inspired by the awesome [emscripten](https://emscripten.org/) project, I wanted to understand the
low-level mechanics of getting compiled C and C++ code to run in the browser, and to find the leanest
possible workflow.

Instead of writing blog posts and code fragments, I decided to produce working examples, because I
believe that working code is king. :)


## Examples

You only need a modern browser to run the examples, which already contain pre-built
WebAssembly code.

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


## Live examples

To ease the deployment worfklow of the examples, they currently require a browser supporting [import
maps](https://caniuse.com/import-maps), e.g. based on Chromium 89 or newer.

A copy of this repository is hosted on my [GitHub Page](https://michaelfranzl.github.io/clang-wasm-browser-starterpack) where these examples are live.

To run the examples locally, simply serve the example directory using a static file server, e.g. you
could use the built-in web server of the Ruby or Python 3 runtime:

```sh
cd examples
ruby -run -ehttpd . -p8000
```

Or

```sh
cd examples
python3 -m http.server 8000
```

Then visit [http://localhost:8000](http://localhost:8000).


## Building

Install the dependencies listed below.

```sh
# Clone this repository
git clone https://github.com/michaelfranzl/clang-wasm-browser-starterpack.git
cd lang-wasm-browser-starterpack

# Build a specific commit of wasi-sdk
git clone --recurse-submodules https://github.com/WebAssembly/wasi-sdk.git # about 1.5 GB
cd wasi-sdk
git checkout a927856376271224d30c5d7732c00a0b359eaa45 # use llvm 12.0.0 release
make
make install # installs to /opt/wasi-sdk by default
cd ..

# Build the examples
make clean
make

# Serve the examples locally
cd examples
ruby -run -ehttpd . -p8000
```

If `wasi-sdk` is installed to a different directory than the default (`/opt/wasi-sdk`), you need to
set the path to the installation directory as environment variable `WASI_SDK` and compile the
examples like this:

```sh
WASI_SDK=/custom/path/to/wasi-sdk make
```

## Dependencies

* A compiler toolchain to compile `clang` and `wasi-libc` via `wasi-sdk`.
* `wasm-opt` for WebAssembly code optimization.
* `wasm-strip` to minimize the size of the WebAssembly binary, and `wasm2wat` to translate binary code to human-readable code.

To provide all these dependencies on Debian 11, simply run:

```sh
apt install build-essential binaryen wabt
```
