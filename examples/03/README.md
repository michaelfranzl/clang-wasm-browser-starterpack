# Example 3 - Renaming imports/exports

There are a number of compiler function attributes that can rename imports and exports for
WebAssembly. Those are:

* [import_module](https://clang.llvm.org/docs/AttributeReference.html#import-module)
* [import_name](https://clang.llvm.org/docs/AttributeReference.html#import-name)
* [export_name](https://clang.llvm.org/docs/AttributeReference.html#export-name)

Here, an "import module" is an entry in the `importObject` of WebAssembly's `instantiate`
function ([see API](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly)).

We have seen in example 2 that the default import module name is `env`, even though this is not
mentioned by the documentation.

These attributes can be wrapped in compiler macros to look a bit more tidy:

```c
#define import_module(name) __attribute__((import_module(#name)))
#define import_name(name) __attribute__((import_name(#name)))
#define export_name(name) __attribute__((export_name(#name)))
```

Then we can conveniently set the names of the imports:

```c
import_module(cat) import_name(eatFood) void cat_give_food();
import_module(dog) import_name(eatFood) void dog_give_food();
```

In the same way, we can set the exported names:

```c
export export_name(feedAnimals) void run() {
  cat_give_food();
  dog_give_food();
}
```
