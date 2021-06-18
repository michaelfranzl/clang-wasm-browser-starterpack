# Example 5: Returning a string

This example returns the string `Hello World! 😀` from a function called `say()` to the WebAssembly
runtime, the web browser.

WebAssembly function return values can only be numerical types -- no strings. However, a string is
just a numerical pointer to a location in memory -- a memory address -- and a C string is terminated
by a zero value. When the WebAssembly runtime can read the memory, it can also read and decode the
string.

Thanks to modern Web Platform APIs, in particular the `TextDecoder` interface, decoding strings from
raw bytes is quite easy and concise:

```javascript
new TextDecoder().decode(memory.subarray(strPtr, strPtr + strLen)); // returns "Hello World! 😀"
```

Here, `strPtr` is the numerical address of the beginning of the string as returned by the `say()`
function. The tricky part is to find `strLen`, which is the offset to the terminating null character
in the string.  Again, Web Platform APIs save the day.  The string length can simply and concisely
be found:

```javascript
const strLen = memory.subarray(strPtr).indexOf(0); // find end of string (null character)
```

In the accompanying `index.js`, all this is implemented by the function `stringFromMemory`.

This example can be implemented in just ~10 lines of JavaScript, and a WebAssembly component of just
81 bytes:

```wast
(module
  (type (;0;) (func (result i32)))
  (import "env" "memory" (memory (;0;) 2))
  (func (;0;) (type 0) (result i32)
    i32.const 1024)
  (export "say" (func 0))
  (data (;0;) (i32.const 1024) "Hello World! \f0\9f\98\80\00"))
```
