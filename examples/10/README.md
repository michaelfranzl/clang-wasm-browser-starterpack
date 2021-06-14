# Example 10: Plain C++: Adding two numbers

This C++ example is extremely straightforward. Compared to the compilation of C code, we simply set
the special `make` variable `CXX` to `clang++`; `make` will use it due to its implicit rules. Since
we are using plain C++ without any libraries, we don't have to link against libraries.

Additionally, since C++ mangles symbol names, we need to mark the exported function as `extern "C"`
so that the name remains unchanged in the WebAssembly export.

The size of the WebAssembly build is extremely small (41 bytes).
