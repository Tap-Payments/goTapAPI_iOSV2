public class Option: Enum, OptionType {
	
	@nonobjc public static func |(left: Option, right: Option) -> Self {
	 
		return self.init(rawValue: left.rawValue | right.rawValue)
	}
	
	@nonobjc public static func &(left: Option, right: Option) -> Self {
	 
		return self.init(rawValue: left.rawValue & right.rawValue)
	}
	
	@nonobjc public static func ^(left: Option, right: Option) -> Self {
	 
		return self.init(rawValue: left.rawValue ^ right.rawValue)
	}
	
	@nonobjc public static prefix func ~(left: Option) -> Self {
	 
		return self.init(rawValue: ~left.rawValue)
	}
	
	public func contains(bit: Option) -> Bool {
	 
		return ( self & bit ) == bit
	}
	
	public convenience init(bits: [Option]) {
	 
		self.init(rawValue: Option.totalRawValue(from: bits))
	}
	
	public required init(rawValue: Int64) {
	 
		super.init(rawValue: rawValue)
	}
	
	private static func totalRawValue(from bits: [Option]) -> Int64 {
	 
		var rValue: Int64 = 0
		for theBit in bits {
		 
			rValue += theBit.rawValue
		}
		
		return rValue
	}
}
