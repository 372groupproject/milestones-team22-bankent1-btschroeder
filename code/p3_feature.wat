(module
    (import "terminal" "nprint" (func $nprint (param i32)))
    (import "terminal" "ln" (func $ln))
    (memory (export "inputs") 1)

    (func (export "average") (param $nums i32) (result f64) (local $sum i32) (local $idx i32) (local $num i32) (local $total i32)
        (local.set $sum (i32.const 0))
        (local.set $idx (i32.const 0))
        (local.set $total (i32.mul (local.get $nums) (i32.const 4))) ;;number of bytes

        (block
            (loop
                (i32.eq (local.get $idx) (local.get $total))
                (br_if 1) ;;branch out of loop

                (i32.load (local.get $idx))
                local.tee $num ;; num = number at idx
                local.get $sum
                i32.add
                local.set $sum ;;sum += num

                (i32.add (local.get $idx) (i32.const 4)) ;;align with ints
                local.set $idx ;;idx ++

                br 0 ;;back to start of loop
            )
        )

        ;;divide by nums to get average
        (f64.convert_i32_s (local.get $sum)) ;;convert sum to float
        (f64.convert_i32_u (local.get $nums)) ;;convert num to float
        f64.div ;;avg
        return ;;return avg
    )
)