# Example 11: C++ with Standard Library: Print a vector element

This idiomatic C++ example which uses just `std::vector` and `std::cout` requires us to link against `libc`, `libc++`, `libc++abi` and `clang_rt.builtins-wasm32`. Omitting any of these dependencies will simply add more imports to the WebAssembly build.

The WebAssembly build grows to about 500 kB.
