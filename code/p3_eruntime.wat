(module
    (import "terminal" "nprint" (func $nprint (param i32)))
    (import "terminal" "sprint" (func $sprint (param i32) (param i32)))

    ;; import 1 page of mem from the terminal
    (import "terminal" "mem" (memory 1))
    (data (i32.const 0) "Attempting to divide by 0\n") ;;27

    (func $p3_eruntime
        i32.const 0
        i32.const 27
        call $sprint

        (i32.div_s (i32.const 40) (i32.const 0))
        call $nprint
    )

    (export "p3_eruntime" (func $p3_eruntime))
)
