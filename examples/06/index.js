import { WASI } from "@wasmer/wasi";
import wasiBindings from "@wasmer/wasi/lib/bindings/browser";
import { WasmFs } from "@wasmer/wasmfs";

function stringToMemory(string, mem, ptr) {
  const arr = new Uint8Array(mem.buffer);
  const stats = new TextEncoder().encodeInto(string, ptr ? arr.subarray(ptr) : arr);
  if (ptr + stats.written < arr.length) arr[ptr + stats.written] = 0; // append null character if safe
  return stats;
}

window.addEventListener('load', async () => {
  const wasmfs = new WasmFs();
  const wasi = new WASI({
    bindings: {
      ...wasiBindings.default,
      fs: wasmfs.fs
    }
  });

  const module = await WebAssembly.compileStreaming(fetch('main.wasm'));
  const { wasi_snapshot_preview1 } = wasi.getImports(module);

  const memory = new WebAssembly.Memory({ initial: 2 });
  wasi.setMemory(memory);
  const env = { memory };

  const instance = await WebAssembly.instantiate(module, { env, wasi_snapshot_preview1 });
  const { malloc } = instance.exports;

  const string = "Hello World! 😀";
  const strPtr = malloc(string.length + 1); // plus one byte for the terminating null character
  stringToMemory(string, memory, strPtr);
  instance.exports.print(strPtr);

  const stdout = await wasmfs.getStdOut();
  document.getElementById('console').innerHTML = stdout;
  console.log(stdout);
});
