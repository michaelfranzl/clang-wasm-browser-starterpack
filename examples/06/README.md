# Example 6: Passing a string to a function

In example 5 we have seen how to return a string from a function which was implemented in C. In this
example, we will do the opposite: pass a string from the WebAssembly runtime to a function
implemented in C.

Given access to the memory, it is quite easy to encode the string, write it into the memory, and
pass the numerical address to the function. However, without full knowledge of the program, this is
not safe; we may overwrite used (now or in the future) memory. So, we need to use the same memory
allocator/manager library as the program itself uses: for example `malloc` which ships
with the C Standard Library. It needs to be exported by adding `-export malloc` to the linker
arguments.

Then a pointer to enough free memory can be gotten:

```javascript
const { malloc, free } = instance.exports;
const ptr = malloc(string.length + 1); // plus one byte for the terminating null character
```

Thanks to modern Web Platform APIs, in particular the `TextEncoder` interface, encoding a string
directly into a specific location of a given WebAssembly memory is quite easy and concise:

```javascript
const stats = new TextEncoder().encodeInto(string, memory.subarray(ptr));
```

However, we need to manually append a null byte to complete the encoding into a proper C string:

```javascript
if (ptr + stats.written < memory.length)
  memory[ptr + stats.written] = 0; // Append null character
```

After the string is no longer needed, don't forget to `free` the memory again:

```javascript
free(ptr);
```

In the accompanying `index.js`, all this is implemented by the function `stringToMemory`.
