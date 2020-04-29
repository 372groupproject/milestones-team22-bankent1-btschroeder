(module
  ;; imports
  (import "grapher" "mem" (memory 1))
  (import "grapher" "nprint" (func $nprint (param f64)))

  (func $pow (param $a f64) (param $b i32) (result f64) (local $res f64)
    f64.const 1.0
    local.set $res
    (block
      (loop
        ;; check if $b is zero
        local.get $b
        i32.eqz
        br_if 1 ;; break

        ;; res = res * a
        (f64.mul (local.get $a) (local.get $res))
        local.set $res

        ;; b--
        (i32.sub (local.get $b) (i32.const 1))
        local.set $b

        br 0 ;; go to start of loop
      )
    )
    ;; return $res
    local.get $res
  )

  (func (export "poly") (param $size i32) (param $x f64) (result f64)
    (local $res f64)
    (local $i i32)

    i32.const 0
    local.set $i
    f64.const 0.0
    local.set $res
    ;; (call $nprint (local.get $res))
    (block
      (loop
        ;; check break on i >= size
        (i32.ge_s (local.get $i) (local.get $size))
        br_if 1 ;; break

        ;; res += c_i*x^i
        (f64.add
          (local.get $res)
          (f64.mul
            (call $pow (local.get $x) (local.get $i))
            (f64.load (i32.mul (i32.const 8) (local.get $i)))
          )
        )
        local.set $res

        ;; i++
        (i32.add (local.get $i) (i32.const 1))
        local.set $i

        br 0 ;; go to start of loop
      )
    )
    ;; return $res
    local.get $res
  )

  (func $factorial (param $n i32) (result i32) (local $res i32)
    i32.const 1
    local.set $res
    (block
      (loop
        (i32.le_s (local.get $n) (i32.const 0))
        br_if 1 ;; break if n == 0

        ;; res = res * n
        (i32.mul (local.get $n) (local.get $res))
        local.set $res

        ;; n--
        (i32.sub (local.get $n) (i32.const 1))
        local.set $n

        br 0 ;; loop
      )
    )
    ;; return res
    local.get $res
  )

  ;; the number of iterations for taylor series
  (func $taylor_iterations (result i32) i32.const 10)

  ;; 1 + x/1 + x^2/2! + ...
  (func $tay_exp (param $x f64) (result f64) (local $i i32) (local $res f64)
    call $taylor_iterations
    local.set $i
    f64.const 0
    local.set $res
    (block
      (loop
        ;; break if i == 0
        (i32.le_s (local.get $i) (i32.const 0))
        br_if 1

        ;; res += x^i / i!
        (f64.add
          (local.get $res)
          (f64.div
            (call $pow (local.get $x) (local.get $i))
            (f64.convert_i32_s (call $factorial (local.get $i)))
          )
        )
        local.set $res

        ;; i--
        (i32.sub (local.get $i) (i32.const 1))
        local.set $i

        br 0 ;; loop
      )
    )
    local.get $res
  )

  (func (export "exp") (param $size i32)  (param $x f64) (result f64)
    (local $a f64)
    (local $b f64)

    (f64.load (i32.const 0))
    local.set $a
    (f64.load (i32.const 8))
    local.set $b
    ;; a*(e^x) + b
    (f64.add
      (local.get $b)
      (f64.mul
        (local.get $a)
        (call $tay_exp (local.get $x))
      )
    )
  )

  ;; x - x^3/3! + x^5/5! - ...
  (func $tay_sin (param $x f64) (result f64) 
    (local $i i32)
    (local $res f64)
    (local $sign_boi f64)

    i32.const 0
    local.set $i
    f64.const 0
    local.set $res
    (block
      (loop
        ;; loop while i < taylor_iterations
        (i32.ge_s (local.get $i) (call $taylor_iterations))
        br_if 1

        ;; if i % 2 == 0, then loop (skip even i's)
        (i32.rem_s (local.get $i) (i32.const 2))
        i32.eqz
        br_if 0

        ;; make every other odd power a negative
        (if
          (i32.eq (i32.rem_s (local.get $i) (i32.const 4)) (i32.const 1))
          (then
            f64.const 1
            local.set $sign_boi
          )
          (else
            f64.const -1
            local.set $sign_boi
          )
        )

        ;; res += +- (x^i / i!)
        (f64.add
          (local.get $res)
          (f64.mul
            (local.get $sign_boi)
            (f64.div
              (call $pow (local.get $x) (local.get $i))
              (f64.convert_i32_s (call $factorial (local.get $i)))
            )
          )
        )
        local.set $res

        ;; i++
        (i32.add (local.get $i) (i32.const 1))
        local.set $i

        br 0 ;; loop
      )
    )
    local.get $res
  )

  (func (export "sin") (param $size i32) (param $x f64) (result f64)
    (local $a f64)
    (local $b f64) 

    (f64.load (i32.const 0))
    local.set $a
    (f64.load (i32.const 8))
    local.set $b
    ;; a*sin(x) + b
    (f64.add
      (local.get $b)
      (f64.mul
        (local.get $a)
        (call $tay_sin (local.get $x))
      )
    )
  )

)
