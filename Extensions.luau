--!optimize 2
--!native
--!strict

-- ===============================================================
--[[ 
-- AptInt.luau // fosterchild 2025 - Luau implementation of BigInteger, with added typechecking.
-- Licensed under The Unlicense.

-- Documentation and source can be found at: https://github.com/fosterchild1/AptInt.luau/tree/main
--]]
-- ===============================================================

-- INSPO: https://github.com/openjdk/jdk/blob/master/src/java.base/share/classes/java/math/AptInt.java

local AptInt = require(script.Parent)

local abs: (number) -> number = math.abs

type AptInt = AptInt.AptInt

export type Extensions = {
	read zero: AptInt,
	read one: AptInt,
	
	read Abs: (n: AptInt, inPlace: boolean) -> AptInt,
	read IsEven: (n: AptInt) -> boolean,
	read Min: (...AptInt) -> boolean,
	read Max: (...AptInt) -> boolean,
	read Clamp: (n: AptInt, min: AptInt, max: AptInt) -> AptInt,
}

AptInt.Extend(function(tbl: typeof(AptInt) | any)
	--> Returns a new AptInt equal to <code>|n|</code>.
	function tbl:Abs(inPlace: boolean): AptInt
		if inPlace then
			self.signum = abs(self.signum)
			return self
		end
		
		local result = AptInt.clone(self)
		result.signum = abs(result.signum)
		return result
	end
	
	--> Returns <code>true</code> if <code>n</code> is even.
	function tbl:IsEven(): boolean
		return (self :: AptInt).limbs[1] % 2 == 0
	end
	
	--> Returns the minimum value among the AptInts passed into the function.
	function tbl:Min(...: AptInt): AptInt
		local ints: {AptInt} = {...}
		local lowest: AptInt = ints[1]
		
		for i: number = 2, #ints do
			local num: AptInt = ints[i]
			
			if num:LowerThanRaw(lowest) then
				lowest = num
			end
		end
		
		return lowest:clone()
	end
	
	--> Returns the maximum value among the AptInts passed into the function.
	function tbl:Max(...: AptInt): AptInt
		local ints: {AptInt} = {...}
		local highest: AptInt = ints[1]

		for i: number = 2, #ints do
			local num: AptInt = ints[i]

			if highest:LowerThanRaw(num) then
				highest = num
			end
		end

		return highest:clone()
	end
	
	--> Returns an AptInt between <code>min</code> and <code>max</code>, inclusive.
	function tbl:Clamp(min: AptInt, max: AptInt): AptInt
		if self:LowerThanRaw(min) then
			return min:clone()
		elseif max:LowerThanRaw(self) then
			return max:clone()
		end
		
		return self:clone()
	end
	
	tbl.zero = AptInt.new()
	tbl.one = AptInt.new({1})
end)

return {}
