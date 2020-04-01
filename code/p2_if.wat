(module
    (import "console" "log" (func $log (param i32)))
    (import "console" "logstr" (func $logstr (param i32) (param i32)))

    ;; import 1 page of mem from the js env
    (import "js" "mem" (memory 1))
    (data (i32.const 0) "EVEN\00")
    (data (i32.const 6) "ODD\00")

    (func $even (param $n1 i32) (result i32)
        (i32.and
            (local.get $n1)
            (i32.const 1)
        )
    )

    (func $print_parity (param $n1 i32) (local $e i32)
        ;; if even, print even, else print odd
        local.get $n1
        call $even
        local.set $e
        (if
            (i32.eq (local.get $e) (i32.const 0))
            (then
                i32.const 0
                i32.const 4
                call $logstr
            )
            (else
                i32.const 6
                i32.const 3
                call $logstr
            )
        )
    )

    (export "print_parity" (func $print_parity))
)