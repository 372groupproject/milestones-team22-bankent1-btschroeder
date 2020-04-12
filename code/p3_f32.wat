(module
    (import "terminal" "nprint" (func $nprint (param f32)))
    (import "terminal" "sprint" (func $sprint (param i32) (param i32)))
    (import "terminal" "ln" (func $ln))

    ;; import 1 page of mem from the terminal
    (import "terminal" "mem" (memory 1))
    (data (i32.const 0) "f32s are 32-bit floating point numbers:\00") ;;40
    (data (i32.const 40) "You can perform arithmetic:\00") ;; 28
    (data (i32.const 68) " + \00") ;; 4
    (data (i32.const 72) " - \00") ;; 4
    (data (i32.const 76) " = \00") ;; 4
    (data (i32.const 80) " * \00") ;; 4
    (data (i32.const 84) " / \00") ;; 4
    (data (i32.const 88) "'420.69' = \00") ;; 12
    (data (i32.const 100) "'0.42069' = \00") ;; 13
    (data (i32.const 113) "'-99999999999999' = \00") ;; 21
    (data (i32.const 134) "Notice the imprecision after some digits, we get more with f64s!\00") ;;65
    (data (i32.const 199) "sqrt \00") ;; 6
 
    (func (export "f32_feature")

        (call $sprint (i32.const 0) (i32.const 40))
        call $ln

        ;;demonstrate precision
        (call $sprint (i32.const 88) (i32.const 12))
        (call $nprint (f32.const 420.69))
        call $ln

        (call $sprint (i32.const 100) (i32.const 13))
        (call $nprint (f32.const 0.42069))
        call $ln

        (call $sprint (i32.const 113) (i32.const 21))
        (call $nprint (f32.const -99999999999999))
        call $ln

        (call $sprint (i32.const 134) (i32.const 65))
        call $ln

        ;;you can do arithmetic
        (call $sprint (i32.const 40) (i32.const 28))
        call $ln

        ;; +
        (call $nprint (f32.const 4.2))
        (call $sprint (i32.const 68) (i32.const 4)) ;; +
        (call $nprint (f32.const 6.9))
        (call $sprint (i32.const 76) (i32.const 4)) ;; =
        (f32.add (f32.const 4.2) (f32.const 6.9))
        call $nprint
        call $ln

        ;; -
        (call $nprint (f32.const 1.2345))
        (call $sprint (i32.const 72) (i32.const 4)) ;; -
        (call $nprint (f32.const 0.2345))
        (call $sprint (i32.const 76) (i32.const 4)) ;; =
        (f32.sub (f32.const 1.2345) (f32.const 0.2345))
        call $nprint
        call $ln

        ;; *
        (call $nprint (f32.const 2.3))
        (call $sprint (i32.const 80) (i32.const 4)) ;; *
        (call $nprint (f32.const -4.5))
        (call $sprint (i32.const 76) (i32.const 4)) ;; =
        (f32.mul (f32.const 2.3) (f32.const -4.5))
        call $nprint
        call $ln

        ;; /
        (call $nprint (f32.const 99.9))
        (call $sprint (i32.const 84) (i32.const 4)) ;; /
        (call $nprint (f32.const 3.0))
        (call $sprint (i32.const 76) (i32.const 4)) ;; =
        (f32.div (f32.const 99.9) (f32.const 3.0))
        call $nprint
        call $ln

        ;; sqrt
        (call $sprint (i32.const 199) (i32.const 6)) ;; sqrt
        (call $nprint (f32.const 225))
        (call $sprint (i32.const 76) (i32.const 4)) ;; =
        (f32.sqrt (f32.const 225))
        call $nprint
        call $ln

        ;; sqrt
        (call $sprint (i32.const 199) (i32.const 6)) ;; sqrt
        (call $nprint (f32.const 1000))
        (call $sprint (i32.const 76) (i32.const 4)) ;; =
        (f32.sqrt (f32.const 1000))
        call $nprint
        call $ln
    )
)