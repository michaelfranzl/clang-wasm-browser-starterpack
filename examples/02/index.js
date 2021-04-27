function square(x) {
  return x ** 2;
}

window.addEventListener('load', async _ => {
  const env = { square, square_root: Math.sqrt };
  const { instance } = await WebAssembly.instantiateStreaming(fetch('main.wasm'), { env });
  console.log(instance.exports.hypotenuse(1, 1));
})
