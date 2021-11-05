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

	internal init(response: goTapAPI.Response) {

		self.code = response.code
		self.responseID = response.responseID
		self.userInfo[goTapAPI.Constants.Key.ParamList] = response.parameters
	}

	public func encoded() -> goTapAPI.EncodedError {

		return goTapAPI.EncodedError(fileName: self.suggestedFileName, errorData: goTapAPI.Client.sharedInstance.dataSource!.encryptError(self))
	}

	//MARK: - Private -
	//MARK: Properties

	private var date: Date = Date()
	private static var dateFormatter: goTapAPI.DateFormatter = goTapAPI.DateFormatter.dateFormatterWith(localeIdentifier: goTapAPI.Constants.Default.LocaleIdentifier, dateFormat: goTapAPI.Constants.DateFormat.Format3)

	private var suggestedFileName : String {

		let dateString = goTapAPI.APIError.dateFormatter.string(from: self.date)
		let deviceID = goTapAPI.ApplicationData.sharedInstance.deviceID ?? String.tap_empty

		return "\(dateString)-\(self.code)-\(deviceID)"
	}
}
