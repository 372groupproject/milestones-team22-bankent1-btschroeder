(module
    (import "console" "log" (func $log (param i32)))
    (import "console" "logstr" (func $logstr (param i32) (param i32)))

    ;; import 1 page of mem from the js env
    (import "js" "mem" (memory 1))
    (data (i32.const 0) "Hello, World!\00")
    (data (i32.const 16) "Goodbye, world!\00")

    (func $len (result i32)
        i32.const 16
    )

    ;; hello function
    (func $hello (export "hello")
        i32.const 0 
        call $len
        call $logstr
        i32.const 16 
        call $len
        call $logstr
    )
)

