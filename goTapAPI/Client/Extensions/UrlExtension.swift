internal class UrlExtension {

	internal static func with(string: String?) -> URL? {
		
		guard string != nil else { return nil }
		
		let encodedString = string!.Replace(string1: " ", string2: "%20")
		
		guard let url = URL(string: encodedString) else { return nil }
		return url
	}
}