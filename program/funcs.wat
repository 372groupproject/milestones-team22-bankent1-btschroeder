(module
  ;; imports
  (import "terminal" "mem" (memory 1))

  (func $pow (param $a f64) (param $b i32) (result f64) (local $res f64)
    f64.const 1.0
    local.set $res
    (block
      (loop
        ;; check if $b is zero
        local.get $b
        i32.eqz
        br_if 1 ;; break

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

  (func (export "poly") (param $coef_list i32) (param $size i32) (param $x f64) (result f64) (local $res f64)
    f64.const 0.0
    local.set $res
    (block
      (loop
        ;; check break on size is zero 
        local.get $size
        i32.eqz
        br_if 1 ;; break

        ;; call pow
        local.get $x
        local.get $size
        call $pow
        ;; coef_list[4*$size]
        (f64.load (i32.mul (i32.const 8) (local.get $size)))
        f64.mul   ;; coef_list[4*$size] * x^$size
        local.get $res
        f64.add   ;; add to sum

        ;; size--
        (i32.sub (local.get $size) (i32.const 1))
        local.set $size

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

  ;; 1 + x/1 + x^2/2! + ...
  (func $tay_exp (param $x f64) (result f64) (local $i i32) (local $res f64)
    i32.const 50
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

  (func (export "exp") (param $a f64) (param $x f64) (param $b f64) (result f64)
    ;; a*(e^x) + b
    (f64.add
      (local.get $b)
      (f64.mul
        (local.get $a)
        (call $tay_exp (local.get $x))
      )
    )
  )

)
