(module
    (import "terminal" "nprint" (func $nprint (param i32)))
    (import "terminal" "sprint" (func $sprint (param i32) (param i32)))

    ;; import 1 page of mem from the terminal
    (import "terminal" "mem" (memory 1))
    (data (i32.const 0) "Broke from innermost block.\00")
    (data (i32.const 28) "Broke from second innermost block.\00")
    (data (i32.const 63) "Broke from third innermost block.\00")

    
    (func $br_table_ex (param i32)
        (block
            (block
                (block
                    local.get 0
                    (br_table 2 1 0 3)

                )
                i32.const 0
                i32.const 28
                call $sprint
                return
            )
            i32.const 28
            i32.const 35
            call $sprint
            return 
        )
        i32.const 63
        i32.const 34
        call $sprint
        return
    )

    (export "br_table_ex" (func $br_table_ex))

)