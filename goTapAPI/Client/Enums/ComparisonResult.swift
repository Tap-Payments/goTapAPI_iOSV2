public class ComparisonResult: Enum {

	public static let OrderedAscending = ComparisonResult(rawValue: -1)
	public static let OrderedSame = ComparisonResult(rawValue: 0)
	public static let OrderedDescending = ComparisonResult(rawValue: 1)

	internal static func with(intValue value: Int64) -> ComparisonResult {

		if value > 0 {

			return ComparisonResult.OrderedDescending
		}
		else if value < 0 {

			return ComparisonResult.OrderedAscending
		}
		else {

			return ComparisonResult.OrderedSame
		}
	}
}
