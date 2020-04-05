(module

    (func (export "sum_digits") (param $num i32) (result i32) (local $dig i32) (local $sum i32)
    
        local.get $num
        local.set $dig ;; dig = num
        i32.const 0
        local.set $sum ;; sum = 0

        (block
            (loop
                local.get $dig
                i32.eqz
                br_if 1  ;;break out of loop

                local.get $dig
                i32.const 10
                i32.rem_u       ;;dig % 10

                local.get $sum
                i32.add         
                local.set $sum ;;sum += dig % 10

                local.get $dig
                i32.const 10
                i32.div_u
                local.set $dig ;;dig /= 10

                br 0 ;;go to start of loop
            )
        )
        local.get $sum
        return ;; return sum
    )
)