import { WASI } from "@wasmer/wasi";
import wasiBindings from "@wasmer/wasi/lib/bindings/browser";
import { WasmFs } from "@wasmer/wasmfs";

window.addEventListener('load', async (_event) => {
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
  instance.exports.say_hello();

  const stdout = await wasmfs.getStdOut();
  document.getElementById('console').innerHTML = stdout;
  console.log(stdout);
});
