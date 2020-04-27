(module
    (import "terminal" "sprint" (func $sprint (param i32) (param i32))) ;;can import JS functions to call

    (import "terminal" "mem" (memory 1))
    (data (i32.const 0) "This string lives in memory imported from JavaScript!\n\00") ;; 53

    (func (export "p5_feature") ;;export functions to be called by JS
        (call $sprint (i32.const 0) (i32.const 53))
    )
)