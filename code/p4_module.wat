(module
    (import "terminal" "sprint" (func $sprint (param i32) (param i32)))

    (import "terminal" "mem" (memory 1))
    (data (i32.const 0) "Wasm code is broken up into modules!\00")

    (func (export "p4_module")
        (call $sprint (i32.const 0) (i32.const 37))
    )
)