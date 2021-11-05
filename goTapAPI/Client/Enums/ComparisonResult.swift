public class ComparisonResult: goTapAPI.Enum {

	public static let OrderedAscending = goTapAPI.ComparisonResult(rawValue: -1)
	public static let OrderedSame = goTapAPI.ComparisonResult(rawValue: 0)
	public static let OrderedDescending = goTapAPI.ComparisonResult(rawValue: 1)

	internal static func with(intValue value: Int64) -> goTapAPI.ComparisonResult {

		if value > 0 {

			return goTapAPI.ComparisonResult.OrderedDescending
		}
		else if value < 0 {

			return goTapAPI.ComparisonResult.OrderedAscending
		}
		else {

			return goTapAPI.ComparisonResult.OrderedSame
		}
	}
}