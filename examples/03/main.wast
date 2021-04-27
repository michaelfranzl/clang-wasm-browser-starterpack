(module
  (type (;0;) (func))
  (import "cat" "eatFood" (func (;0;) (type 0)))
  (import "dog" "eatFood" (func (;1;) (type 0)))
  (func (;2;) (type 0)
    call 0
    call 1)
  (memory (;0;) 2)
  (export "memory" (memory 0))
  (export "feedAnimals" (func 2)))
