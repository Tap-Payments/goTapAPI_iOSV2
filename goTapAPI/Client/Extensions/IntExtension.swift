internal class IntExtension {

	/**
	 Compares receiver to another Comparable object.
	 
	 - parameter other: Other comparable object.
	 
	 - returns: ComparisonResult
	 */
	internal static func compare(first: Int64, toOther other: Int64) -> goTapAPI.ComparisonResult {
		
		if first < other {
			
			return goTapAPI.ComparisonResult.OrderedAscending
		}
		else if first > other {
			
			return goTapAPI.ComparisonResult.OrderedDescending
		}
		else {
			
			return goTapAPI.ComparisonResult.OrderedSame
		}
	}
}