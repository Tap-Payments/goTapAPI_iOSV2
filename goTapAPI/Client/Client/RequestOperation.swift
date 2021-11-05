//
//  RequestOperation.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/14/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// API request operation class.
public class RequestOperation: NSObject {

	//MARK: - Public -
	//MARK: Properties

	/// HTTP method.
	public private(set) var httpMethod: goTapAPI.HttpMethod

	/// Request path.
	public var requestPath: String {

		guard _processedRequestPath == nil else { return _processedRequestPath! }

		guard let serializedURLModel = urlModel?.serializedModel as? [String: AnyObject] else {

			_processedRequestPath = _requestPath
			return _processedRequestPath!
		}

		guard serializedURLModel.keys.count > 0 else {

			_processedRequestPath = _requestPath
			return _processedRequestPath!
		}

		var result: String = "\(_requestPath)?"
		for (key, value) in serializedURLModel {

			result += "\(key)=\(value)&"
		}

		_processedRequestPath = result.Substring(loc: 0, len: result.Length - 1)

		return _processedRequestPath!
	}

	/// Additional request headers.
	public var requestHeaders: [String: String] {

		let apiClient = goTapAPI.Client.sharedInstance
		let apiClientDataSource = apiClient.dataSource!

		var headers: [String: String] = [:]

		headers[goTapAPI.Constants.Key.APP_Mode] = apiClientDataSource.shouldUseProductionServer() ? goTapAPI.Constants.Value.PRD : goTapAPI.Constants.Value.DEV
		headers[goTapAPI.Constants.Key.APP_Version] = apiClientDataSource.applicationBuildString()
		headers[goTapAPI.Constants.Key.LangCode] = apiClientDataSource.languageCode()

		if let deviceID = apiClientDataSource.stringFromKeychain(forKey: goTapAPI.Constants.Key.UserSettings.DeviceID) {

			headers[goTapAPI.Constants.Key.DeviceID] = deviceID
		}

		let sessionID: String = apiClientDataSource.stringFromUserSettings(forKey: goTapAPI.Constants.Key.UserSettings.SessionID) ?? String.tap_empty
		headers[goTapAPI.Constants.Key.SessionID] = sessionID

		let hsCode = apiClientDataSource.encryptString(sessionID)
		if hsCode.Length > 0 {

			headers[goTapAPI.Constants.Key.HsCode] = hsCode
		}

		let appLicenseCode: String = apiClientDataSource.stringFromUserSettings(forKey: goTapAPI.Constants.Key.UserSettings.AppLicenseCode) ?? String.tap_empty
		if appLicenseCode.Length > 0 {

			headers[goTapAPI.Constants.Key.APPLicenseCD] = appLicenseCode
		}

		if let mobileCountryCode = apiClientDataSource.mobileCountryCode(), let mobileNetworkCode = apiClientDataSource.mobileNetworkCode() {

			headers[goTapAPI.Constants.Key.CarrierCode] = "\(mobileCountryCode)_\(mobileNetworkCode)"
		}
		else {

			headers[goTapAPI.Constants.Key.CarrierCode] = String.tap_empty
		}

		return headers
	}

	/// URL model.
	public private(set) var urlModel: goTapAPI.RequestModel?

	/// Body model.
	public private(set) var bodyModel: goTapAPI.RequestModel?

	/// Response model.
	public private(set) var responseModel: goTapAPI.ResponseModel?

	/// Response error.
	public private(set) var responseError: goTapAPI.APIError?

	/// Response object.
	public private(set) var responseObjectString: String?
	public private(set) var responseObject: Any?

	internal private(set) var responseObjectType: goTapAPI.ResponseModel

	/// Defines if operation can be performed simultaneously with such others request operations.
	public private(set) var forbidsSameSimultaneousOperations: Swift.Bool

	//MARK: Methods

	/**
	 Initializes request operation with all the parameters required to start the request.

	 - parameter httpMethod:                      HTTP method.
	 - parameter requestPath:                     Request path.
	 - parameter requestURLModel:                 Request URL model.
	 - parameter requestBodyModel:                Request body model.
	 - parameter responseObjectType:              Response object type.
	 - parameter allowSameSimultaneousOperations: Defines if operation can be performed simultaneously with such others request operations.

	 - returns: TPAPIRequestOperation
	 */
	internal init(httpMethod: goTapAPI.HttpMethod,
				  requestPath: String,
				  requestURLModel: goTapAPI.RequestModel? = nil,
				  requestBodyModel: goTapAPI.RequestModel? = nil,
				  responseObjectType: goTapAPI.ResponseModel,
				  allowSameSimultaneousOperations: Swift.Bool = true) {

		self.httpMethod = httpMethod
		self._requestPath = requestPath
		self.urlModel = requestURLModel
		self.bodyModel = requestBodyModel
		self.responseObjectType = responseObjectType
		self.forbidsSameSimultaneousOperations = !allowSameSimultaneousOperations
	}

	/**
	 Parses response.

	 - parameter response: Response object json string.
	 */
	public func parse(response: String?) {

		self.responseObjectString = response

		if let dict = Swift.Dictionary<String, AnyObject>.from(response) {

			parse(responseObject: dict)
		}
		else if let array = Swift.Array<AnyObject>.from(jsonString: response) {

			parse(responseObject: array)
		}
	}

	/**
	 Parses response.

	 - parameter object: Response object dictionary or array.
	 */
	public func parse(responseObject object: Any?) {

		self.responseObject = object

		let parsedResponse: goTapAPI.ResponseModel? = self.responseObjectType.dataModelWith(serializedObject: object)

		var response: Response?
		if parsedResponse != nil {

			response = parsedResponse?.response
		}
		else {

			response = (goTapAPI.ResponseModel().dataModelWith(serializedObject: object))?.response
		}

		let responseCode =  response?.code ?? 0
		var isError: Swift.Bool = responseCode != 0
		if isError && (parsedResponse is goTapAPI.PayTransactionResponseModel) && responseCode == 1 {

			isError = false
		}

		if isError {

			self.responseError = goTapAPI.APIError(response: response!)
		}
		else {

			self.responseModel = parsedResponse
		}
	}

	//MARK: - Private -
	//MARK: Properties

	private var _requestPath: String
	private var _processedRequestPath: String?
}
