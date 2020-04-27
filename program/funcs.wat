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

  (func (export "poly") (param $size i32) (param $x f64) (result f64) (local $res f64)
    ;; TODO use coeficiant list with size of list to return res
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

  (func (export "exp") (param $a f64) (param $x f64) (param $b i32) (param $c f64) (result f64)
    ;; a*(x^b) + c
    local.get $x
    local.get $b
    call $pow
    local.get $a
    f64.mul
    local.get $c
    f64.add
  )

)
