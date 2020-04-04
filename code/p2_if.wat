(module
    (import "terminal" "nprint" (func $nprint (param i32)))
    (import "terminal" "sprint" (func $sprint (param i32) (param i32)))

    ;; import 1 page of mem from the terminal
    (import "terminal" "mem" (memory 1))
    (data (i32.const 0) " is EVEN\00")
    (data (i32.const 10) " is ODD\00")

    (func $odd (param $n1 i32) (result i32)
        ;; check 0th bit
        (i32.and
            (local.get $n1)
            (i32.const 1)
        )
    )

    (func $print_parity (param $n1 i32) (local $x i32)
        local.get $n1
        call $nprint
        ;; if even, print even, else print odd
        local.get $n1
        call $odd
        local.set $x
        (if
            (i32.eq (local.get $x) (i32.const 0))
            (then
                i32.const 0
                i32.const 8
                call $sprint
            )
            (else
                i32.const 10
                i32.const 7
                call $sprint
            )
        )
    )

    (export "print_parity" (func $print_parity))
)