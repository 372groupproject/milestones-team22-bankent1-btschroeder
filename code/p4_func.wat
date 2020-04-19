(module
    (import "terminal" "sprint" (func $sprint (param i32) (param i32))) ;;can import JS functions to call

    (import "terminal" "mem" (memory 1))
    (data (i32.const 0) "Each module contains functions which are exported to be called by JS code!\00") ;;75
    (data (i32.const 76) "\n\00")

    (func $line ;;local functions can be called by other functions in the module
        (call $sprint (i32.const 76) (i32.const 2))
    )

    (func (export "p4_func") ;;export functions to be called by JS
        (call $sprint (i32.const 0) (i32.const 75))
        call $line
    )
)