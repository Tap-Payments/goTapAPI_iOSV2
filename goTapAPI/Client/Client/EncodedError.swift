public class EncodedError {

	public private(set) var errorData: String = String.tap_empty
	public private(set) var fileName: String = String.tap_empty

	internal init(fileName: String, errorData: String) {

		self.fileName = fileName
		self.errorData = errorData
	}
}
