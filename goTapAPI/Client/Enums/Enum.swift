public class Enum: NSObject, EnumType {

	public let rawValue: Int64

	public required init(rawValue rValue: Int64) {
	
		self.rawValue = rValue
	}
	
	@nonobjc public static func ==(left: Enum, right: Enum) -> Bool {
	
		return left.rawValue == right.rawValue
	}
	
	@nonobjc public static func !=(left: Enum, right: Enum) -> Bool {
	
		return left.rawValue != right.rawValue
	}
}
