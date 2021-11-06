internal class IntExtension {

	/**
	 Compares receiver to another Comparable object.
	 
	 - parameter other: Other comparable object.
	 
	 - returns: ComparisonResult
	 */
	internal static func compare(first: Int64, toOther other: Int64) -> ComparisonResult {
		
		if first < other {
			
			return ComparisonResult.OrderedAscending
		}
		else if first > other {
			
			return ComparisonResult.OrderedDescending
		}
		else {
			
			return ComparisonResult.OrderedSame
		}
	}
}
