function stringFromMemory(mem, ptr) {
  const arr = new Uint8Array(mem.buffer);
  const len = arr.subarray(ptr).indexOf(0); // find end of string (null character)
  return new TextDecoder().decode(arr.subarray(ptr, ptr + len)); // decode until null character
}

window.addEventListener('load', async () => {
  const module = await WebAssembly.compileStreaming(fetch('main.wasm'));
  const memory = new WebAssembly.Memory({ initial: 2 });
  const env = { memory };
  const instance = await WebAssembly.instantiate(module, { env });
  const ptr = instance.exports.say();
  const string = stringFromMemory(memory, ptr);
  document.getElementById('console').innerHTML = string;
  console.log(string);
});
