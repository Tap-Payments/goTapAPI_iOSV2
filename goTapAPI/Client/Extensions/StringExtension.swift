internal class StringExtension {

	//MARK: - Public -
	//MARK: Properties

	internal static let dotSymbol: String = "."

	//MARK: Methods

	internal static func equal(string1: String?, string2: String?) -> Swift.Bool {

		if string1 == nil && string2 == nil {

			return true
		}

		guard let nonnullString1 = string1, let nonnullString2 = string2 else {

			return false
		}

		return (nonnullString1 == nonnullString2)
	}

	internal static func replace(_ str: String, startIndex: Int64, length: Int64, string: String) -> String? {

		guard startIndex > -1 else { return nil }
		guard length > -1 else { return nil }
		guard startIndex + length < str.Length + 1 else { return nil }

		let before: String = startIndex > 0 ? str.Substring(loc: 0, len: startIndex) : String.tap_empty
		let after: String = startIndex + length < str.Length ? str.Substring(startIndex + length) : String.tap_empty
		return before + string + after
	}
}

