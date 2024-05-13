{ pkgs, wasm-sdk, ... }:
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
    WASM_LLVM = wasm-sdk;
    WASI_LIBC_INC = "${wasm-sdk}/include";
    WASI_LIBC_LIB = "${wasm-sdk}/lib";
    WASM_LIBCXX_INC = "${wasm-sdk}/include/c++/v1";
    WASM_LIBCXX_LIB = "${wasm-sdk}/lib";
    WASM_COMPILER_RT_LIB = "${wasm-sdk}/lib/wasi";
  };
}
