(module
  ;; imports
  (import "terminal" "mem" (memory 1))

  (func $pow (local $res i32) (param $a i32) (param $b i32) (result i32)
    i32.const 1
    local.set $res
    (block
      (loop
        ;; check if $b is zero
        local.get $b
        i32.eqz
        br_if 1 ;; break

        i32.mul (local.get $a) (local.get $res)
        local.set $res

        ;; b--
        i32.sub (local.get $b) (i32.const 1)
        local.set $b

        br 0 ;; go to start of loop
      )
    )
    ;; return $res
    local.get $res
  )

  (func (export "poly") (local $res i32) (param $coef_list i32) (param $size i32) (param $x i32) (result i32)
    ;; TODO use coeficiant list with size of list to return res
    i32.const 0
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
        i32.load (i32.add (local.get $coef_list) (i32.mul (i32.const 4) (local.get $size)))
        i32.mul   ;; coef_list[4*$size] * x^$size
        local.get $res
        i32.add   ;; add to sum

        ;; size--
        i32.sub (local.get $size) (i32.const 1)
        local.set $size

        br 0 ;; go to start of loop
      )
    )
    ;; return $res
    local.get $res
  )
)
