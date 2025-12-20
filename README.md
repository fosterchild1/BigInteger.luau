<p align="center"><img src="https://github.com/fosterchild1/AptInt/blob/main/resources/text.png" width="659" height="288"></p>

# Luau implementation of BigInteger.
It can go up to <b>b*2^53 digits</b> before it starts losing precision. Currently, b is equal to 10^7. (that's 90 sextillion digits!)

# Extensions
Extending the module is very easy. Just call `AptInt.Extend(func: typeof(BigInteger) -> ())`. For example,

```luau
AptInt.Extend(function(tbl: typeof(AptInt) | any)
	function tbl:IsEven(): boolean
		return (self :: AptInt).digits[1] % 2 == 0
	end
end)
```

# Benchmarks
Note that these were done on an i7-10750H @ 2.60GHz.<br/>
The results are updated every time the performance gets improved.

| Digit count | Addition | Subtraction | Multiplication | Division |
| ---  | --- | --- | --- | --- |
| 1 | 1μs | 1μs | 6μs | 0.6μs |
| 50 | 1μs | 3μs | 38μs | 1μs |
| 100 | 5μs | 7μs | 70μs | 1μs |
| 500 | 11μs | 9μs | 850μs | 1μs |
| 1,000 | 14μs | 59μs | 1ms | 1ms |
| 5,000 | 49μs | 65μs | 19ms | 5ms |
| 10,000 | 68μs | 80μs | 43ms | 71ms |
| 50,000 | 393μs | 375μs | 320ms | 2.6s |
| 100,000 | 551μs | 638μs | 693ms | 6s |
