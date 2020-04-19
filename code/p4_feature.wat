(module
    (import "terminal" "sprint" (func $sprint (param i32) (param i32))) ;;can import JS functions to call

    (import "terminal" "mem" (memory 1))
    (data (i32.const 0) "Calling helper!\n\00") ;; 16
    (data (i32.const 18) "I am helper!\n\00") ;; 13

    (func $helper ;;local functions can be called by other functions in the module
        (call $sprint (i32.const 18) (i32.const 13))
    )

    (func (export "p4_feature") ;;export functions to be called by JS
        (call $sprint (i32.const 0) (i32.const 16))
        call $helper
    )
)