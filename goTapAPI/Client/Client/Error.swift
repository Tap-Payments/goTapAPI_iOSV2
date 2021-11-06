/// API error class.
public class APIError: NSObject {

	//MARK: - Public -
	//MARK: Properties

	/// Error code.
	public private(set) var code: Int64

	/// Response ID.
	public var responseID: String?

	/// User info.
	public private(set) var userInfo: [String: Any] = [:]

	//MARK: Methods

	/// Initializes error with code, title and user info.
	public init(code aCode: Int64, userInfo aUserInfo: [String: Any]) {

		self.code = aCode
		self.userInfo = aUserInfo
	}

	internal init(response: Response) {

		self.code = response.code
		self.responseID = response.responseID
		self.userInfo[Constants.Key.ParamList] = response.parameters
	}

	public func encoded() -> EncodedError {

		return EncodedError(fileName: self.suggestedFileName, errorData: Client.sharedInstance.dataSource!.encryptError(self))
	}

	//MARK: - Private -
	//MARK: Properties

	private var date: Date = Date()
	private static var dateFormatter: DateFormatter = DateFormatter.dateFormatterWith(localeIdentifier: Constants.Default.LocaleIdentifier, dateFormat: Constants.DateFormat.Format3)

	private var suggestedFileName : String {

		let dateString = APIError.dateFormatter.string(from: self.date)
		let deviceID = ApplicationData.sharedInstance.deviceID ?? String.tap_empty

		return "\(dateString)-\(self.code)-\(deviceID)"
	}
}
