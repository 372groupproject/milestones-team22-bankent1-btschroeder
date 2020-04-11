(module
    (import "terminal" "nprint" (func $nprint (param i32)))
    (import "terminal" "sprint" (func $sprint (param i32) (param i32)))

    ;; import 1 page of mem from the terminal
    (import "terminal" "mem" (memory 1))
    (data (i32.const 0) "i32s are signed 32-bit numbers:\00") ;;31
    (data (i32.const 33) "You can perform arithmitic:\00") ;; 28
    (data (i32.const 62) " + \00") ;; 3
    (data (i32.const 66) " - \00") ;; 3
    (data (i32.const 70) " = \00") ;; 3
    (data (i32.const 74) "\n") ;; 1
    (data (i32.const 75) " * \00") ;; 3
    (data (i32.const 79) " / \00") ;; 3


    (func $i32_feature
          i32.const 0
          i32.const 31 ;; len of string
          call $sprint
          ;; newline
          i32.const 74
          i32.const 1
          call $sprint

          i32.const 42
          call $nprint
          ;; newline
          i32.const 74
          i32.const 1
          call $sprint
          i32.const -42
          call $nprint
          ;; newline
          i32.const 74
          i32.const 1
          call $sprint

          ;; show adding
          i32.const 33
          i32.const 28
          call $sprint
          ;; newline
          i32.const 74
          i32.const 1
          call $sprint
          ;; 35 + 28 = (add)
          i32.const 35
          call $nprint
          i32.const 62
          i32.const 3
          call $sprint
          i32.const 28
          call $nprint
          i32.const 70
          i32.const 3
          call $sprint
          i32.const 35
          i32.const 28
          i32.add
          call $nprint
          ;; newline
          i32.const 74
          i32.const 1
          call $sprint
          ;; 35 - 28 = (sub)
          i32.const 35
          call $nprint
          i32.const 66
          i32.const 3
          call $sprint
          i32.const 28
          call $nprint
          i32.const 70
          i32.const 3
          call $sprint
          i32.const 35
          i32.const 28
          i32.sub
          call $nprint
          ;; newline
          i32.const 74
          i32.const 1
          call $sprint
          ;; 35 * 28 = (mult)
          i32.const 35
          call $nprint
          i32.const 75
          i32.const 3
          call $sprint
          i32.const 28
          call $nprint
          i32.const 70
          i32.const 3
          call $sprint
          i32.const 35
          i32.const 28
          i32.mul
          call $nprint
          ;; newline
          i32.const 74
          i32.const 1
          call $sprint
          ;; 35 / 28 = (div)
          i32.const 35
          call $nprint
          i32.const 79
          i32.const 3
          call $sprint
          i32.const 28
          call $nprint
          i32.const 70
          i32.const 3
          call $sprint
          i32.const 35
          i32.const 28
          i32.div_s
          call $nprint
          ;; newline
          i32.const 74
          i32.const 1
          call $sprint
          
    )

    (export "i32_feature" (func $i32_feature))
)

