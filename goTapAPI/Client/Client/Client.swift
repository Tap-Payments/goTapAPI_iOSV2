/// API client.

public typealias RequestCompletionClosure<T: goTapAPI.ResponseHolder> = (T?, goTapAPI.APIError?) -> Void

public class Client: NSObject {

	//MARK: - Public -
	//MARK: Properties

	/// Singleton instance.
	public static let sharedInstance: goTapAPI.Client = goTapAPI.Client()

	/// API client data source.
	public var dataSource: goTapAPI.ClientDataSource?

	
	/// API client delegate.
	public var delegate: goTapAPI.ClientDelegate?
	

	/// Request operations manager.
	lazy private var requestOperationsManager: goTapAPI.RequestOperationsManager? = RequestOperationsHandler.shared

	public var isLoggedIn: Swift.Bool {

		guard let datasource = self.dataSource else { return false }

		let sessionID: String = datasource.stringFromUserSettings(forKey: goTapAPI.Constants.Key.UserSettings.SessionID) ?? String.tap_empty
		let appLicenseCode: String = datasource.stringFromUserSettings(forKey: goTapAPI.Constants.Key.UserSettings.AppLicenseCode) ?? String.tap_empty
		return sessionID.Length > 0 && appLicenseCode.Length > 0
	}

	//MARK: Methods

	public func removeAllLoginData() {

		self.canStoreSessionIDAndAppLicenseCode = false

		self.dataSource?.saveToUserSettings(nil, forKey: goTapAPI.Constants.Key.UserSettings.PhoneNumberCountryCode)
		self.dataSource?.saveToUserSettings(nil, forKey: goTapAPI.Constants.Key.UserSettings.PhoneNumber)
		self.dataSource?.saveToUserSettings(nil, forKey: goTapAPI.Constants.Key.UserSettings.AppLicenseCode)
		self.dataSource?.saveToUserSettings(nil, forKey: goTapAPI.Constants.Key.UserSettings.SessionID)
	}

	public func usePhoneNumber(_ phoneNumber: String, country: goTapAPI.Country) {

		goTapAPI.ApplicationData.sharedInstance.storeCountry(country)
		goTapAPI.ApplicationData.sharedInstance.storePhoneNumber(phoneNumber)
	}

	public func removePhoneNumberAndCountry() {

		self.dataSource?.saveToUserSettings(nil, forKey: goTapAPI.Constants.Key.UserSettings.PhoneNumberCountryCode)
		self.dataSource?.saveToUserSettings(nil, forKey: goTapAPI.Constants.Key.UserSettings.PhoneNumber)
	}

	/// Retrieves video URLs.
	public func getVideoURLs(completion: /*@escaping*/ RequestCompletionClosure<goTapAPI.VideoResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Get,
												  requestPath: goTapAPI.Constants.RequestPath.GetVideo,
												  requestURLModel: nil,
												  requestBodyModel: nil,
												  responseObjectType: goTapAPI.VideoResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Registers application.
	public func registerApplication(phoneNumber: String, country: goTapAPI.Country, completion: /*@escaping*/ RequestCompletionClosure<goTapAPI.ApplicationRegisterResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		self.usePhoneNumber(phoneNumber, country: country)

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.Register,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.ApplicationRegisterRequestModel(),
												  responseObjectType: goTapAPI.ApplicationRegisterResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Verifies phone with number and confirmation code.
	public func verifyPhoneWithPhoneNumber(phoneNumber: String, confirmationCode: String, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.PhoneVerificationResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let mobileVerify = goTapAPI.MobileVerify(phoneNumber: phoneNumber,
												 confirmationCode: confirmationCode,
												 simCardCode: goTapAPI.ApplicationData.sharedInstance.simCardCode,
												 deviceID: goTapAPI.ApplicationData.sharedInstance.deviceID,
												 country: goTapAPI.ApplicationData.sharedInstance.country)
		let model = goTapAPI.PhoneVerificationRequestModel(mobileVerify:mobileVerify)

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.VerifyPhone,
												  requestURLModel: nil,
												  requestBodyModel: model,
												  responseObjectType: goTapAPI.PhoneVerificationResponseModel(),
												  allowSameSimultaneousOperations: false)

		self.canStoreSessionIDAndAppLicenseCode = true

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Resends confirmation code.
	public func resendConfirmationCode(completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.ResendCode,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.ResendCodeRequestModel(),
												  responseObjectType: goTapAPI.ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Complains on registration.
	public func complaintOnRegistrationWith(referenceValue: String, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.RegistrationComplaint,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.RegistrationComplaintRequestModel(referenceValue: referenceValue),
												  responseObjectType: goTapAPI.ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Requests application for unsupported country.
	public func requestApplication(completion: /*@escaping*/  RequestCompletionClosure<goTapAPI.RequestApplicationResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.RequestApplication,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.RequestApplicationRequestModel(),
												  responseObjectType: goTapAPI.RequestApplicationResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Gets application updates.
	public func getApplicationUpdates(completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.GetUpdatesResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.GetUpdates,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.GetUpdatesRequestModel(),
												  responseObjectType: goTapAPI.GetUpdatesResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Gets items list.
	public func getList(completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.GetListResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.GetList,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.IDsRequestModel(),
												  responseObjectType: goTapAPI.GetListResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Reloads specific item.
	public func reloadItem(item: goTapAPI.ListIDRepresentable, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.GetListResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.GetList,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.IDsRequestModel(IDs:[item.listID]),
												  responseObjectType: goTapAPI.GetListResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Deletes list.
	public func deleteList(itemsList: [goTapAPI.ListIDRepresentable], permanently: Swift.Bool, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.BadgedResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		var listIDs: [goTapAPI.ListID] = []
		for item in itemsList {

			listIDs.append(item.listID)
		}

		let bodyModel = goTapAPI.IDsRequestModel(IDs:listIDs)

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.DeleteList,
												  requestURLModel: goTapAPI.DeleteListRequestURLModel(deletePermanently:permanently),
												  requestBodyModel: bodyModel,
												  responseObjectType: goTapAPI.BadgedResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Gets item details.
	public func getItemDetails(item: goTapAPI.ListIDRepresentable, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.GetListDetailsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.GetListDetails,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.IDsRequestModel(IDs:[item.listID]),
												  responseObjectType: goTapAPI.GetListDetailsResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Adds mobile to the list.
	public func addMobileToList(countryCode: String, phoneNumber: String, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.QuickAddListResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let model = goTapAPI.QuickAddListRequestModel(inputData: goTapAPI.QuickAddListInputData.Mobile,
													  businessFields: [goTapAPI.BusinessField(name: goTapAPI.Constants.Value.Phone, value: phoneNumber),
																	   goTapAPI.BusinessField(name: goTapAPI.Constants.Value.COUNTRY_CODE, value: countryCode)])

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.QuickAddList,
												  requestURLModel: nil,
												  requestBodyModel: model,
												  responseObjectType: goTapAPI.QuickAddListResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Adds ID to the list.
	public func addIdentificationToList(identification: goTapAPI.Identification, scanned: Swift.Bool, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.QuickAddListResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let model = goTapAPI.QuickAddListRequestModel(inputData: scanned ? goTapAPI.QuickAddListInputData.ScanID : goTapAPI.QuickAddListInputData.ID, businessFields: identification.businessFields)

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.QuickAddList,
												  requestURLModel: nil,
												  requestBodyModel: model,
												  responseObjectType: goTapAPI.QuickAddListResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func payForItems(items: [goTapAPI.PaymentSerialization], fromLocation location: goTapAPI.Location?, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.PayItemsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		if location != nil {

			goTapAPI.ApplicationData.sharedInstance.storeLocation(goTapAPI.LocationData(location: location!))
		}

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.PayItems,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.PayItemsRequestModel(items: items),
												  responseObjectType: goTapAPI.PayItemsResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func payTransactionWithID(transactionID: String, withCard card: goTapAPI.PaymentCard, amount: Foundation.Decimal, fromLocation location: goTapAPI.Location?, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.PayTransactionResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		if location != nil {

			goTapAPI.ApplicationData.sharedInstance.storeLocation(goTapAPI.LocationData(location: location!))
		}

		let paymentDetails = goTapAPI.PaymentDetails(transactionID: transactionID, amount: amount, gatewayID: card.gatewayID, currencyCode: card.currencyCode)
		let model = goTapAPI.PayTransactionRequestModel(paymentDetails: paymentDetails, cardInfo: goTapAPI.EncryptionHelper.encrypt(paymentCard: card, amount: amount))

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.PayTransaction,
												  requestURLModel: nil,
												  requestBodyModel: model,
												  responseObjectType: goTapAPI.PayTransactionResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func getInvoiceDetails(items: [goTapAPI.ListIDRepresentable], completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.GetInvoiceDetailsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		var listIDs: [goTapAPI.ListID] = []
		for item in items {

			listIDs.append(item.listID)
		}

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.GetInvoiceDetails,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.IDsRequestModel(IDs: listIDs),
												  responseObjectType: goTapAPI.GetInvoiceDetailsResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func getTransactionDetails(transactionID: String, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.GetInvoiceDetailsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.GetTransactionDetails,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.GetTransactionDetailsRequestModel(transactionID: transactionID),
												  responseObjectType: goTapAPI.GetInvoiceDetailsResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func getPushItems(sessionID: String, actionButtonWasPressed: Swift.Bool, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.GetListResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Get,
												  requestPath: goTapAPI.Constants.RequestPath.GetPushItems,
												  requestURLModel: goTapAPI.GetPushItemsRequestModel(sessionID: sessionID, actionButtonWasPressed: actionButtonWasPressed),
												  requestBodyModel: nil,
												  responseObjectType: goTapAPI.GetListResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func getPushItemDetails(sessionID: String, actionButtonWasPressed: Swift.Bool, completion: goTapAPI.RequestCompletionClosure<goTapAPI.GetListDetailsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.GetPushItemDetails,
												  requestURLModel: goTapAPI.GetPushItemsRequestModel(sessionID: sessionID, actionButtonWasPressed: actionButtonWasPressed),
												  requestBodyModel: nil,
												  responseObjectType: goTapAPI.GetListDetailsResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func getPushInvoiceDetails(sessionID: String, actionButtonWasPressed: Swift.Bool, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.GetInvoiceDetailsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.GetPushInvoiceDetails,
												  requestURLModel: goTapAPI.GetPushItemsRequestModel(sessionID: sessionID, actionButtonWasPressed: actionButtonWasPressed),
												  requestBodyModel: nil,
												  responseObjectType: goTapAPI.GetInvoiceDetailsResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func getShortURLs(context: goTapAPI.SharingContext, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.GetShortURLsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let allPossibleSharingOptions: [goTapAPI.SharingOption] = [

			goTapAPI.SharingOption.Facebook,
			goTapAPI.SharingOption.FacebookMessenger,
			goTapAPI.SharingOption.GooglePlus,
			goTapAPI.SharingOption.Instagram,
			goTapAPI.SharingOption.Linkedin,
			goTapAPI.SharingOption.Mail,
			goTapAPI.SharingOption.SMS,
			goTapAPI.SharingOption.Twitter,
			goTapAPI.SharingOption.WhatsApp
		]

		var sharingOptions: [goTapAPI.SharingOption] = []
		for option in allPossibleSharingOptions {

			if self.dataSource!.isSharingOptionAvailable(option) {

				sharingOptions.append(option)
			}
		}

		self.getShortURLs(for: sharingOptions, context: context, completion: completion)
	}

	public func getShortURLs(for sharingOptions: [goTapAPI.SharingOption], context: goTapAPI.SharingContext, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.GetShortURLsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let purposes: [goTapAPI.Purpose] = [

			goTapAPI.Purpose.Share,
			goTapAPI.Purpose.Video
		]

		let params: String = context == goTapAPI.SharingContext.SuccessfulPayment ? goTapAPI.Constants.Value.TXN : goTapAPI.Constants.Value.MENU

		var requests: [goTapAPI.ShortURLRequest] = []

		for medium in sharingOptions {

			for purpose in purposes {

				let request = goTapAPI.ShortURLRequest(medium: medium, purpose: purpose, params: params)
				requests.append(request)
			}
		}

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.GetShortURLs,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.GetShortURLsRequestModel(requests: requests),
												  responseObjectType: goTapAPI.GetShortURLsResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func shareApp(transactionID: String, medium: goTapAPI.SharingOption, status: goTapAPI.SharingStatus, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.ShareApp,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.ShareAppRequestModel(transactionID: transactionID, medium: medium, shareAction: status),
												  responseObjectType: goTapAPI.ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func markItemsAsViewed(items: [goTapAPI.ListIDRepresentable], completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.BadgedResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		var listIDs: [goTapAPI.ListID] = []
		for item in items {

			listIDs.append(item.listID)
		}

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.ItemViewedUpdate,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.ItemViewedUpdateRequestModel(IDs: listIDs),
												  responseObjectType: goTapAPI.BadgedResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func sendLinkedEmail(emailOrLinkID: String, requirement: goTapAPI.LinkEmailRequirement, transactionID: String?, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.LinkEmailResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.LinkEmail,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.LinkEmailRequestModel(identifier: emailOrLinkID, transactionID: transactionID, requirement: requirement),
												  responseObjectType: goTapAPI.LinkEmailResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func updatePermissions(permissions: goTapAPI.Permissions, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.SetPermissions,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.PermissionsRequestModel(permissions: permissions),
												  responseObjectType: goTapAPI.ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func requestSectors(sectors: [goTapAPI.Sector], completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.RequestSectors,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.RequestSectorsRequestModel(sectors: sectors),
												  responseObjectType: goTapAPI.ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func rateApp(completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.RateApp,
												  requestURLModel: nil,
												  requestBodyModel: nil,
												  responseObjectType: goTapAPI.ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func linkAccounts(accounts: [goTapAPI.ListIDRepresentable], completion: /*@escaping*/ RequestCompletionClosure<goTapAPI.QuickAddListResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		var listIDs: [goTapAPI.ListID] = []
		for item in accounts {

			listIDs.append(item.listID)
		}

		let model = goTapAPI.IDsRequestModel(IDs: listIDs)
		model.serializesToArray = true

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.LinkAccounts,
												  requestURLModel: nil,
												  requestBodyModel: model,
												  responseObjectType: goTapAPI.QuickAddListResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func confirmOperator(mobileOperator: goTapAPI.ItemIDRepresentable, completion: /*@escaping*/ RequestCompletionClosure<goTapAPI.QuickAddListResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.ConfirmOperator,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.ConfirmOperatorRequestModel(mobileOperator: mobileOperator.itemID),
												  responseObjectType: goTapAPI.QuickAddListResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func saveUserGender(gender: goTapAPI.Gender, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let inputFields = [

			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.GENDER, value: gender.stringRepresentation)
		]

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.SaveUserInfo,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.UserInfoRequestModel(userData: goTapAPI.Constants.Value.GENDER, inputFields: inputFields),
												  responseObjectType: goTapAPI.ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func saveUserName(name: String?, surname: String?, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let inputFields = [

			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.FNAME, value: name),
			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.LNAME, value: surname)
		]

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.SaveUserInfo,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.UserInfoRequestModel(userData: goTapAPI.Constants.Value.NAME, inputFields: inputFields),
												  responseObjectType: goTapAPI.ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func notifyThatIntroductionScreenWasShown(screen: goTapAPI.AddToListScreen, completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let inputFields = [

			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.SCREEN, value: screen.stringRepresentation)
		]

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.SaveUserInfo,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.UserInfoRequestModel(userData: goTapAPI.Constants.Value.INTRO, inputFields: inputFields),
												  responseObjectType: goTapAPI.ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func uploadContacts(contacts: [goTapAPI.AddressBookPerson], actions: [goTapAPI.PendingRecord], completion: /*@escaping*/ goTapAPI.RequestCompletionClosure<goTapAPI.ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.Contacts,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.UploadContactsRequestModel(contacts: contacts, actions: actions),
												  responseObjectType: goTapAPI.ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func scheduleDailyPaymentForItem(_ item: goTapAPI.ListIDRepresentable, with amount: Foundation.Decimal, completion: goTapAPI.RequestCompletionClosure<goTapAPI.GetListDetailsResponseModel>?) {

		let inputFields: [goTapAPI.BusinessField] = [

			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_type, value: goTapAPI.ScheduleType.daily.stringRepresentation),
			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_value, value: String.tap_empty),
			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_amount, value: amount.stringValue)
		]

		self.scheduleItem(with: item.listID, options: inputFields, completion: completion)
	}

	public func scheduleDailyPaymentForItemDetails(_ item: goTapAPI.ChangedDetailsHomeItem, completion: goTapAPI.RequestCompletionClosure<goTapAPI.GetListDetailsResponseModel>?) {

		let inputFields: [goTapAPI.BusinessField] = [

			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_type, value: goTapAPI.ScheduleType.daily.stringRepresentation),
			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_value, value: String.tap_empty)
		]

		self.scheduleItemDetails(with: item, options: inputFields, completion: completion)
	}

	public func scheduleWeeklyPaymentForItem(_ item: goTapAPI.ListIDRepresentable, on day: goTapAPI.Day, with amount: Foundation.Decimal, completion: goTapAPI.RequestCompletionClosure<goTapAPI.GetListDetailsResponseModel>?) {

		let inputFields: [goTapAPI.BusinessField] = [

			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_type, value: goTapAPI.ScheduleType.weekly.stringRepresentation),
			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_value, value: day.stringRepresentation),
			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_amount, value: amount.stringValue)
		]

		self.scheduleItem(with: item.listID, options: inputFields, completion: completion)
	}

	public func scheduleWeeklyPaymentForItemDetails(_ item: goTapAPI.ChangedDetailsHomeItem, on day: goTapAPI.Day, completion: goTapAPI.RequestCompletionClosure<goTapAPI.GetListDetailsResponseModel>?) {

		let inputFields: [goTapAPI.BusinessField] = [

			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_type, value: goTapAPI.ScheduleType.weekly.stringRepresentation),
			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_value, value: day.stringRepresentation)
		]

		self.scheduleItemDetails(with: item, options: inputFields, completion: completion)
	}

	public func scheduleMonthlyPaymentForItem(_ item: goTapAPI.ListIDRepresentable, on day: Int64, with amount: Foundation.Decimal, completion: goTapAPI.RequestCompletionClosure<goTapAPI.GetListDetailsResponseModel>?) {

	   let inputFields: [goTapAPI.BusinessField] = [

			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_type, value: goTapAPI.ScheduleType.monthly.stringRepresentation),
			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_value, value: day.stringValue_EN_US),
			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_amount, value: amount.stringValue)
	   ]

	   self.scheduleItem(with: item.listID, options: inputFields, completion: completion)
	}

	public func scheduleMonthlyPaymentForItemDetails(_ item: goTapAPI.ChangedDetailsHomeItem, on day: Int64, completion: goTapAPI.RequestCompletionClosure<goTapAPI.GetListDetailsResponseModel>?) {

		let inputFields: [goTapAPI.BusinessField] = [

			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_type, value: goTapAPI.ScheduleType.monthly.stringRepresentation),
			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_value, value: String.withFormat("%d", [day]))
		]

		self.scheduleItemDetails(with: item, options: inputFields, completion: completion)
	}

	public func scheduleYearlyPaymentForItem(_ item: goTapAPI.ListIDRepresentable, on month: Int64, day: Int64, with amount: Foundation.Decimal, completion: goTapAPI.RequestCompletionClosure<goTapAPI.GetListDetailsResponseModel>?) {

		let inputFields: [goTapAPI.BusinessField] = [

			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_type, value: goTapAPI.ScheduleType.yearly.stringRepresentation),
			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_value, value: String.withFormat("%02d%02d", [day, month])),
			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_amount, value: amount.stringValue)
		]

		self.scheduleItem(with: item.listID, options: inputFields, completion: completion)
	}

	public func scheduleYearlyPaymentForItemDetails(_ item: goTapAPI.ChangedDetailsHomeItem, on month: Int64, day: Int64, completion: goTapAPI.RequestCompletionClosure<goTapAPI.GetListDetailsResponseModel>?) {

		let inputFields: [goTapAPI.BusinessField] = [

			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_type, value: goTapAPI.ScheduleType.yearly.stringRepresentation),
			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_value, value: String.withFormat("%02d%02d", [day, month]))
		]

		self.scheduleItemDetails(with: item, options: inputFields, completion: completion)
	}

	public func removeScheduleForItem(_ item: goTapAPI.ListIDRepresentable, completion: goTapAPI.RequestCompletionClosure<goTapAPI.GetListDetailsResponseModel>?) {

		let inputFields: [goTapAPI.BusinessField] = [

			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_type, value: String.tap_empty),
			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_value, value: String.tap_empty),
			goTapAPI.BusinessField(name: goTapAPI.Constants.Value.schedule_amount, value: String.tap_empty)
		]

		self.scheduleItem(with: item.listID, options: inputFields, completion: completion)
	}

	//MARK: - Internal -goTapAPIgoTapAPI.
	//MARK: Properties

	internal private(set) var canStoreSessionIDAndAppLicenseCode = true

	//MARK: - Private -
	//MARK: Methods

	private override init() { super.init() }

	private func checkClientSetup<T: ResponseHolder>(_ completion: goTapAPI.RequestCompletionClosure<T>?) -> Swift.Bool {

		let nilResponseModel: T? = nil

		guard dataSource != nil else {

			goTapAPI.Dispatcher.dispatchOnMainThread {

				completion?(nilResponseModel, goTapAPI.APIError(code: goTapAPI.Constants.Error.Code.DataSourceNotSet,
																userInfo: [goTapAPI.Constants.Key.ErrorUserInfo.LocalizedDescription: goTapAPI.Constants.Error.Message.DataSourceNotSet,
																		   goTapAPI.Constants.Key.ErrorUserInfo.Title: goTapAPI.Constants.Error.Title.Default]))
			}

			return false
		}

		
		guard delegate != nil else {

			goTapAPI.Dispatcher.dispatchOnMainThread {

				completion?(nilResponseModel, goTapAPI.APIError(code: goTapAPI.Constants.Error.Code.DelegateNotSet,
																userInfo: [goTapAPI.Constants.Key.ErrorUserInfo.LocalizedDescription: goTapAPI.Constants.Error.Message.DelegateNotSet,
																		   goTapAPI.Constants.Key.ErrorUserInfo.Title: goTapAPI.Constants.Error.Title.Default]))
			}

			return false
		}
		

		guard requestOperationsManager != nil else {

			goTapAPI.Dispatcher.dispatchOnMainThread {

				completion?(nilResponseModel, goTapAPI.APIError(code: goTapAPI.Constants.Error.Code.RequestOperationsManagerNotSet,
																userInfo: [goTapAPI.Constants.Key.ErrorUserInfo.LocalizedDescription: goTapAPI.Constants.Error.Message.RequestOperationsManagerNotSet,
																		   goTapAPI.Constants.Key.ErrorUserInfo.Title: goTapAPI.Constants.Error.Title.Default]))
			}

			return false
		}

		return true
	}

	private func scheduleItem(with listID: goTapAPI.ListID, options: [goTapAPI.BusinessField], completion: goTapAPI.RequestCompletionClosure<goTapAPI.GetListDetailsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.ScheduleItem,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.ScheduleItemRequestModel(listID: listID, inputFields: options),
												  responseObjectType: goTapAPI.GetListDetailsResponseModel(),
												  allowSameSimultaneousOperations: false)

		self.requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	private func scheduleItemDetails(with changedItem: goTapAPI.ChangedDetailsHomeItem, options: [goTapAPI.BusinessField], completion: goTapAPI.RequestCompletionClosure<goTapAPI.GetListDetailsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = goTapAPI.RequestOperation(httpMethod: goTapAPI.HttpMethod.Post,
												  requestPath: goTapAPI.Constants.RequestPath.ScheduleItemDetail,
												  requestURLModel: nil,
												  requestBodyModel: goTapAPI.ScheduleItemDetailsRequestModel(item: changedItem, inputFields: options),
												  responseObjectType: goTapAPI.GetListDetailsResponseModel(),
												  allowSameSimultaneousOperations: false)

		self.requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}
}
