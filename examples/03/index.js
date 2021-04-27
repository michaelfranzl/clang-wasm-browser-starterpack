class Cat {
  eatFood() { console.log("Cat eats food") }
}

class Dog {
  eatFood() { console.log("Dog eats food") }
}

window.addEventListener('load', async _ => {
  const imports = {
    cat: new Cat(),
    dog: new Dog()
  };
  const { instance } = await WebAssembly.instantiateStreaming(fetch('main.wasm'), imports);
  console.log(instance.exports.feedAnimals());
})
