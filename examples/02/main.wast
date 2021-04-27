(module
  (type (;0;) (func (param f32) (result f32)))
  (type (;1;) (func (param f32 f32) (result f32)))
  (import "env" "square_root" (func (;0;) (type 0)))
  (import "env" "square" (func (;1;) (type 0)))
  (func (;2;) (type 1) (param f32 f32) (result f32)
    local.get 0
    call 1
    local.get 1
    call 1
    f32.add
    call 0)
  (memory (;0;) 2)
  (export "memory" (memory 0))
  (export "hypotenuse" (func 2)))
