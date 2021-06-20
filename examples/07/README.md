# Example 7: Calling int main(int argc, char* argv[])

In example 6 we have seen how to pass a string from the WebAssembly runtime to a function
implemented in C. It is now trivial to go one step further to process an array of strings, which is
what is needed for the default entry point of a C program, `int main(int argc, char* argv[])`.

The main complication here is that we have to pass a new data type which we haven't encountered so
far: `char* []` -- an array of pointers. As with every non-primitive data type, we need to allocate
memory for this array, but how many bytes? The pointer size on wasm64 is, well, 64 bits, or 4 bytes.

```javascript
const sizeofCharPtr = 4; // 64 bits for addressing memory
```

`argc` is the number of arguments:

```javascript
const argc = args.length;
```

Space for the `argv` array needs to be allocated; `argv` naturally points to the first element in
the array:

```javascript
const argv = malloc(argc * sizeofCharPtr);
```

Now, for each argument, we need to allocate space and write the pointer into its `argv` element.

```javascript
for (let i = 0; i < args.length; i++) {
  const arg = args[i];
  const ptr = malloc(arg.length + 1); // length of the string plus null character
  memory.setUint32(argv + i * sizeofCharPtr, ptr, true); // write ptr into argv
  stringToMemory(arg, memory, ptr); // copy string into memory
}
```

The `stringToMemory` function was implemented in Example 06.

We can finally call `main`:

```javascript
main(argc, argv);
```

In the accompanying `index.js`, all this is done by the function `callMain`.
