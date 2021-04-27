window.addEventListener('load', async _ => {
  const { instance } = await WebAssembly.instantiateStreaming(fetch('main.wasm'));
  console.log(instance.exports.add(41, 1));
  console.log(instance.exports.subtract(43, 1));
})
