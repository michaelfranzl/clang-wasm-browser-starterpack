{ pkgs, wasi-sdk, ... }:
with pkgs;
stdenv.mkDerivation {
  name = "clang-wasm-browser-starterpack";
  version = "1.0.0";

  src = ./examples;

  nativeBuildInputs = [
    binaryen
    wabt
  ];

  dontConfigure = true;
  dontFixup = true;

  makeFlags = lib.attrsets.mapAttrsToList (name: value: name + "=" + value) {
    PREFIX = placeholder "out";
    WASM_LLVM = wasi-sdk;
    WASI_LIBC_INC = "${wasi-sdk}/share/wasi-sysroot/include/wasm32-wasi";
    WASI_LIBC_LIB = "${wasi-sdk}/share/wasi-sysroot/lib/wasm32-wasi";
    WASM_LIBCXX_INC = "${wasi-sdk}/include/c++/v1";
    WASM_LIBCXX_LIB = "${wasi-sdk}/lib";
    WASM_COMPILER_RT_LIB = "${wasi-sdk}/lib/wasi";
  };
}
