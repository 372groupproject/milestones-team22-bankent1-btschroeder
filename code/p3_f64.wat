(module
    (import "terminal" "nprint" (func $nprint (param f64)))
    (import "terminal" "sprint" (func $sprint (param i32) (param i32)))
    (import "terminal" "ln" (func $ln))

    ;; import 1 page of mem from the terminal
    (import "terminal" "mem" (memory 1))
    (data (i32.const 0) "f64s are 32-bit floating point numbers:\00") ;;40
    (data (i32.const 40) "You can perform arithmetic:\00") ;; 28
    (data (i32.const 68) " + \00") ;; 4
    (data (i32.const 72) " - \00") ;; 4
    (data (i32.const 76) " = \00") ;; 4
    (data (i32.const 80) " * \00") ;; 4
    (data (i32.const 84) " / \00") ;; 4
    (data (i32.const 88) "'420.69' = \00") ;; 12
    (data (i32.const 100) "'0.42069' = \00") ;; 13
    (data (i32.const 113) "'-99999999999999' = \00") ;; 21
    (data (i32.const 134) "Compare these precisions with the f32s!\00") ;;40
    (data (i32.const 174) "sqrt \00") ;; 6
 
    (func (export "f64_feature")

        (call $sprint (i32.const 0) (i32.const 40))
        call $ln

        ;;demonstrate precision
        (call $sprint (i32.const 88) (i32.const 12))
        (call $nprint (f64.const 420.69))
        call $ln

        (call $sprint (i32.const 100) (i32.const 13))
        (call $nprint (f64.const 0.42069))
        call $ln

        (call $sprint (i32.const 113) (i32.const 21))
        (call $nprint (f64.const -99999999999999))
        call $ln

        (call $sprint (i32.const 134) (i32.const 40))
        call $ln

        ;;you can do arithmetic
        (call $sprint (i32.const 40) (i32.const 28))
        call $ln

        ;; +
        (call $nprint (f64.const 4.2))
        (call $sprint (i32.const 68) (i32.const 4)) ;; +
        (call $nprint (f64.const 6.9))
        (call $sprint (i32.const 76) (i32.const 4)) ;; =
        (f64.add (f64.const 4.2) (f64.const 6.9))
        call $nprint
        call $ln

        ;; -
        (call $nprint (f64.const 1.2345))
        (call $sprint (i32.const 72) (i32.const 4)) ;; -
        (call $nprint (f64.const 0.2345))
        (call $sprint (i32.const 76) (i32.const 4)) ;; =
        (f64.sub (f64.const 1.2345) (f64.const 0.2345))
        call $nprint
        call $ln

        ;; *
        (call $nprint (f64.const 2.3))
        (call $sprint (i32.const 80) (i32.const 4)) ;; *
        (call $nprint (f64.const -4.5))
        (call $sprint (i32.const 76) (i32.const 4)) ;; =
        (f64.mul (f64.const 2.3) (f64.const -4.5))
        call $nprint
        call $ln

        ;; /
        (call $nprint (f64.const 99.9))
        (call $sprint (i32.const 84) (i32.const 4)) ;; /
        (call $nprint (f64.const 3.0))
        (call $sprint (i32.const 76) (i32.const 4)) ;; =
        (f64.div (f64.const 99.9) (f64.const 3.0))
        call $nprint
        call $ln

        ;; sqrt
        (call $sprint (i32.const 174) (i32.const 6)) ;; sqrt
        (call $nprint (f64.const 225))
        (call $sprint (i32.const 76) (i32.const 4)) ;; =
        (f64.sqrt (f64.const 225))
        call $nprint
        call $ln

        ;; sqrt
        (call $sprint (i32.const 174) (i32.const 6)) ;; sqrt
        (call $nprint (f64.const 1000))
        (call $sprint (i32.const 76) (i32.const 4)) ;; =
        (f64.sqrt (f64.const 1000))
        call $nprint
        call $ln
    )
)