window.addEventListener('load', async (_event) => {
  const module = await WebAssembly.compileStreaming(fetch('main.wasm'));
  const memory = new WebAssembly.Memory({ initial: 2 });
  const env = { memory };
  const instance = await WebAssembly.instantiate(module, { env });
  console.log(instance.exports.add(1, 2));
});
