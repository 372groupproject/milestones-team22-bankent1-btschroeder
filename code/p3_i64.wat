(module
    (import "terminal" "nprint" (func $nprint (param i64)))
    (import "terminal" "sprint" (func $sprint (param i32) (param i32)))

    ;; import 1 page of mem from the terminal
    (import "terminal" "mem" (memory 1))
    (data (i32.const 0) "i64s are signed 64-bit numbers:\00") ;;31
    (data (i32.const 33) "You can perform arithmitic:\00") ;; 28
    (data (i32.const 62) " + \00") ;; 3
    (data (i32.const 66) " - \00") ;; 3
    (data (i32.const 70) " = \00") ;; 3
    (data (i32.const 74) "\n") ;; 1
    (data (i32.const 75) " * \00") ;; 3
    (data (i32.const 79) " / \00") ;; 3


    (func $i64_feature
          i32.const 0
          i32.const 31 ;; len of string
          call $sprint
          ;; newline
          i32.const 74
          i32.const 1
          call $sprint

          i64.const 12345678900
          call $nprint
          ;; newline
          i32.const 74
          i32.const 1
          call $sprint
          i64.const -12345678900
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
          i64.const 12328648990
          call $nprint
          i32.const 62
          i32.const 3
          call $sprint
          i64.const 42322641793
          call $nprint
          i32.const 70
          i32.const 3
          call $sprint
          i64.const 12328648990
          i64.const 42322641793
          i64.add
          call $nprint
          ;; newline
          i32.const 74
          i32.const 1
          call $sprint
          ;; 35 - 28 = (sub)
          i64.const 42322641793
          call $nprint
          i32.const 66
          i32.const 3
          call $sprint
          i64.const 52329248303
          call $nprint
          i32.const 70
          i32.const 3
          call $sprint
          i64.const 42322641793
          i64.const 52329248303
          i64.sub
          call $nprint
          ;; newline
          i32.const 74
          i32.const 1
          call $sprint
          ;; 35 * 28 = (mult)
          i64.const 8218313
          call $nprint
          i32.const 75
          i32.const 3
          call $sprint
          i64.const 2882
          call $nprint
          i32.const 70
          i32.const 3
          call $sprint
          i64.const 8218313
          i64.const 2882
          i64.mul
          call $nprint
          ;; newline
          i32.const 74
          i32.const 1
          call $sprint
          ;; 35 / 28 = (div)
          i64.const 378218313
          call $nprint
          i32.const 79
          i32.const 3
          call $sprint
          i64.const 31623
          call $nprint
          i32.const 70
          i32.const 3
          call $sprint
          i64.const 378218313
          i64.const 31623
          i64.div_s
          call $nprint
          ;; newline
          i32.const 74
          i32.const 1
          call $sprint
          
    )

    (export "i64_feature" (func $i64_feature))
)

