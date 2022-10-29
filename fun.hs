fun 0 1 = True
fun 0 _ = False
fun i x = if x `mod` 2 == 0 then fun (i - 1) (x `div` 2) else fun (i - 1) (x * 3 + 1)
