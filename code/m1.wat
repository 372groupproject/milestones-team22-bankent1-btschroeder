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
    (func $hello 
        i32.const 0 
        call $len
        call $logstr
        i32.const 16 
        call $len
        call $logstr
    )

    ;; add32 function
    (func $add32 (param i32) (param i32) (result i32) 
      local.get 0
      local.get 1
      i32.add
    )

    (export "hello" (func $hello))
    (export "add32" (func $add32))
)

