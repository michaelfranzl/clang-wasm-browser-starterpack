import { WASI } from "@wasmer/wasi";
import wasiBindings from "@wasmer/wasi/lib/bindings/browser";
import { WasmFs } from "@wasmer/wasmfs";

function stringToMemory(string, mem, ptr) {
  const arr = new Uint8Array(mem.buffer);
  const stats = new TextEncoder().encodeInto(string, ptr ? arr.subarray(ptr) : arr);
  if (ptr + stats.written < arr.length) arr[ptr + stats.written] = 0; // append null character if safe
  return stats;
}

const sizeofCharPtr = 4; // 64 bits = 4 bytes for addressing memory

function callMain({
  exports: { malloc, free, __main_argc_argv: main }, memBuf, name, args,
}) {
  if (!malloc)
    throw new Error('Instance needs to export `malloc`.');
  if (!free)
    throw new Error('Instance needs to export `free`.');
  if (!main)
    throw new Error('Instance needs to export `__main__argc_argv`.');

  const memDataView = new DataView(memBuf);
  const memArray = new Uint8Array(memBuf);

  const pointersToFree = [];

  args.unshift(name || '');
  const argc = args.length;

  const argv = malloc(argc * sizeofCharPtr);
  pointersToFree.push(argv);

  for (let i = 0; i < args.length; i++) {
    const arg = args[i];
    const ptr = malloc(arg.length + 1); // length of string plus 1 byte for the terminating null character
    pointersToFree.push(ptr); // to be able to free the memory later
    memDataView.setUint32(argv + i * sizeofCharPtr, ptr, true); // write ptr into argv
    stringToMemory(arg, memArray, ptr); // write string into memory
  }

  // main call
  const retval = main(argc, argv);

  // clean up
  for (const ptr of pointersToFree)
    free(ptr);

  return retval;
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

  callMain({
    exports: instance.exports,
    memBuf: memory.buffer,
    name: 'someprogram',
    args: ['--say', 'hello', '--say', 'world']
  });

  const stdout = await wasmfs.getStdOut();
  document.getElementById('console').innerHTML = stdout.replace(/\n/g, "<br>");
  console.log(stdout);
});
