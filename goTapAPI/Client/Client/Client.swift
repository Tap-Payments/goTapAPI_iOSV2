/// API client.

public typealias RequestCompletionClosure<T: ResponseHolder> = (T?, APIError?) -> Void

public class Client: NSObject {

	//MARK: - Public -
	//MARK: Properties

	/// Singleton instance.
	public static let sharedInstance: Client = Client()

	/// API client data source.
	public var dataSource: ClientDataSource?

	
	/// API client delegate.
	public var delegate: ClientDelegate?
	

	/// Request operations manager.
	lazy private var requestOperationsManager: RequestOperationsManager? = RequestOperationsHandler.shared

	public var isLoggedIn: Swift.Bool {

		guard let datasource = self.dataSource else { return false }

		let sessionID: String = datasource.stringFromUserSettings(forKey: Constants.Key.UserSettings.SessionID) ?? String.tap_empty
		let appLicenseCode: String = datasource.stringFromUserSettings(forKey: Constants.Key.UserSettings.AppLicenseCode) ?? String.tap_empty
		return sessionID.Length > 0 && appLicenseCode.Length > 0
	}

	//MARK: Methods

	public func removeAllLoginData() {

		self.canStoreSessionIDAndAppLicenseCode = false

		self.dataSource?.saveToUserSettings(nil, forKey: Constants.Key.UserSettings.PhoneNumberCountryCode)
		self.dataSource?.saveToUserSettings(nil, forKey: Constants.Key.UserSettings.PhoneNumber)
		self.dataSource?.saveToUserSettings(nil, forKey: Constants.Key.UserSettings.AppLicenseCode)
		self.dataSource?.saveToUserSettings(nil, forKey: Constants.Key.UserSettings.SessionID)
	}

	public func usePhoneNumber(_ phoneNumber: String, country: Country) {

		ApplicationData.sharedInstance.storeCountry(country)
		ApplicationData.sharedInstance.storePhoneNumber(phoneNumber)
	}

	public func removePhoneNumberAndCountry() {

		self.dataSource?.saveToUserSettings(nil, forKey: Constants.Key.UserSettings.PhoneNumberCountryCode)
		self.dataSource?.saveToUserSettings(nil, forKey: Constants.Key.UserSettings.PhoneNumber)
	}

	/// Retrieves video URLs.
	public func getVideoURLs(completion: /*@escaping*/ RequestCompletionClosure<VideoResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Get,
												  requestPath: Constants.RequestPath.GetVideo,
												  requestURLModel: nil,
												  requestBodyModel: nil,
												  responseObjectType: VideoResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Registers application.
	public func registerApplication(phoneNumber: String, country: Country, completion: /*@escaping*/ RequestCompletionClosure<ApplicationRegisterResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		self.usePhoneNumber(phoneNumber, country: country)

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.Register,
												  requestURLModel: nil,
												  requestBodyModel: ApplicationRegisterRequestModel(),
												  responseObjectType: ApplicationRegisterResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Verifies phone with number and confirmation code.
	public func verifyPhoneWithPhoneNumber(phoneNumber: String, confirmationCode: String, completion: /*@escaping*/ RequestCompletionClosure<PhoneVerificationResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let mobileVerify = MobileVerify(phoneNumber: phoneNumber,
												 confirmationCode: confirmationCode,
												 simCardCode: ApplicationData.sharedInstance.simCardCode,
												 deviceID: ApplicationData.sharedInstance.deviceID,
												 country: ApplicationData.sharedInstance.country)
		let model = PhoneVerificationRequestModel(mobileVerify:mobileVerify)

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.VerifyPhone,
												  requestURLModel: nil,
												  requestBodyModel: model,
												  responseObjectType: PhoneVerificationResponseModel(),
												  allowSameSimultaneousOperations: false)

		self.canStoreSessionIDAndAppLicenseCode = true

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Resends confirmation code.
	public func resendConfirmationCode(completion: /*@escaping*/ RequestCompletionClosure<ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.ResendCode,
												  requestURLModel: nil,
												  requestBodyModel: ResendCodeRequestModel(),
												  responseObjectType: ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Complains on registration.
	public func complaintOnRegistrationWith(referenceValue: String, completion: /*@escaping*/ RequestCompletionClosure<ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.RegistrationComplaint,
												  requestURLModel: nil,
												  requestBodyModel: RegistrationComplaintRequestModel(referenceValue: referenceValue),
												  responseObjectType: ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Requests application for unsupported country.
	public func requestApplication(completion: /*@escaping*/  RequestCompletionClosure<RequestApplicationResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.RequestApplication,
												  requestURLModel: nil,
												  requestBodyModel: RequestApplicationRequestModel(),
												  responseObjectType: RequestApplicationResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Gets application updates.
	public func getApplicationUpdates(completion: /*@escaping*/ RequestCompletionClosure<GetUpdatesResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.GetUpdates,
												  requestURLModel: nil,
												  requestBodyModel: GetUpdatesRequestModel(),
												  responseObjectType: GetUpdatesResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Gets items list.
	public func getList(completion: /*@escaping*/ RequestCompletionClosure<GetListResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.GetList,
												  requestURLModel: nil,
												  requestBodyModel: IDsRequestModel(),
												  responseObjectType: GetListResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Reloads specific item.
	public func reloadItem(item: ListIDRepresentable, completion: /*@escaping*/ RequestCompletionClosure<GetListResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.GetList,
												  requestURLModel: nil,
												  requestBodyModel: IDsRequestModel(IDs:[item.listID]),
												  responseObjectType: GetListResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Deletes list.
	public func deleteList(itemsList: [ListIDRepresentable], permanently: Swift.Bool, completion: /*@escaping*/ RequestCompletionClosure<BadgedResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		var listIDs: [ListID] = []
		for item in itemsList {

			listIDs.append(item.listID)
		}

		let bodyModel = IDsRequestModel(IDs:listIDs)

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.DeleteList,
												  requestURLModel: DeleteListRequestURLModel(deletePermanently:permanently),
												  requestBodyModel: bodyModel,
												  responseObjectType: BadgedResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Gets item details.
	public func getItemDetails(item: ListIDRepresentable, completion: /*@escaping*/ RequestCompletionClosure<GetListDetailsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.GetListDetails,
												  requestURLModel: nil,
												  requestBodyModel: IDsRequestModel(IDs:[item.listID]),
												  responseObjectType: GetListDetailsResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Adds mobile to the list.
	public func addMobileToList(countryCode: String, phoneNumber: String, completion: /*@escaping*/ RequestCompletionClosure<QuickAddListResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let model = QuickAddListRequestModel(inputData: QuickAddListInputData.Mobile,
													  businessFields: [BusinessField(name: Constants.Value.Phone, value: phoneNumber),
																	   BusinessField(name: Constants.Value.COUNTRY_CODE, value: countryCode)])

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.QuickAddList,
												  requestURLModel: nil,
												  requestBodyModel: model,
												  responseObjectType: QuickAddListResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	/// Adds ID to the list.
	public func addIdentificationToList(identification: Identification, scanned: Swift.Bool, completion: /*@escaping*/ RequestCompletionClosure<QuickAddListResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let model = QuickAddListRequestModel(inputData: scanned ? QuickAddListInputData.ScanID : QuickAddListInputData.ID, businessFields: identification.businessFields)

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.QuickAddList,
												  requestURLModel: nil,
												  requestBodyModel: model,
												  responseObjectType: QuickAddListResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func payForItems(items: [PaymentSerialization], fromLocation location: Location?, completion: /*@escaping*/ RequestCompletionClosure<PayItemsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		if location != nil {

			ApplicationData.sharedInstance.storeLocation(LocationData(location: location!))
		}

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.PayItems,
												  requestURLModel: nil,
												  requestBodyModel: PayItemsRequestModel(items: items),
												  responseObjectType: PayItemsResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func payTransactionWithID(transactionID: String, withCard card: PaymentCard, amount: Foundation.Decimal, fromLocation location: Location?, completion: /*@escaping*/ RequestCompletionClosure<PayTransactionResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		if location != nil {

			ApplicationData.sharedInstance.storeLocation(LocationData(location: location!))
		}

		let paymentDetails = PaymentDetails(transactionID: transactionID, amount: amount, gatewayID: card.gatewayID, currencyCode: card.currencyCode)
		let model = PayTransactionRequestModel(paymentDetails: paymentDetails, cardInfo: EncryptionHelper.encrypt(paymentCard: card, amount: amount))

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.PayTransaction,
												  requestURLModel: nil,
												  requestBodyModel: model,
												  responseObjectType: PayTransactionResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func getInvoiceDetails(items: [ListIDRepresentable], completion: /*@escaping*/ RequestCompletionClosure<GetInvoiceDetailsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		var listIDs: [ListID] = []
		for item in items {

			listIDs.append(item.listID)
		}

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.GetInvoiceDetails,
												  requestURLModel: nil,
												  requestBodyModel: IDsRequestModel(IDs: listIDs),
												  responseObjectType: GetInvoiceDetailsResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func getTransactionDetails(transactionID: String, completion: /*@escaping*/ RequestCompletionClosure<GetInvoiceDetailsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.GetTransactionDetails,
												  requestURLModel: nil,
												  requestBodyModel: GetTransactionDetailsRequestModel(transactionID: transactionID),
												  responseObjectType: GetInvoiceDetailsResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func getPushItems(sessionID: String, actionButtonWasPressed: Swift.Bool, completion: /*@escaping*/ RequestCompletionClosure<GetListResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Get,
												  requestPath: Constants.RequestPath.GetPushItems,
												  requestURLModel: GetPushItemsRequestModel(sessionID: sessionID, actionButtonWasPressed: actionButtonWasPressed),
												  requestBodyModel: nil,
												  responseObjectType: GetListResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func getPushItemDetails(sessionID: String, actionButtonWasPressed: Swift.Bool, completion: RequestCompletionClosure<GetListDetailsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.GetPushItemDetails,
												  requestURLModel: GetPushItemsRequestModel(sessionID: sessionID, actionButtonWasPressed: actionButtonWasPressed),
												  requestBodyModel: nil,
												  responseObjectType: GetListDetailsResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func getPushInvoiceDetails(sessionID: String, actionButtonWasPressed: Swift.Bool, completion: /*@escaping*/ RequestCompletionClosure<GetInvoiceDetailsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.GetPushInvoiceDetails,
												  requestURLModel: GetPushItemsRequestModel(sessionID: sessionID, actionButtonWasPressed: actionButtonWasPressed),
												  requestBodyModel: nil,
												  responseObjectType: GetInvoiceDetailsResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func getShortURLs(context: SharingContext, completion: /*@escaping*/ RequestCompletionClosure<GetShortURLsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let allPossibleSharingOptions: [SharingOption] = [

			SharingOption.Facebook,
			SharingOption.FacebookMessenger,
			SharingOption.GooglePlus,
			SharingOption.Instagram,
			SharingOption.Linkedin,
			SharingOption.Mail,
			SharingOption.SMS,
			SharingOption.Twitter,
			SharingOption.WhatsApp
		]

		var sharingOptions: [SharingOption] = []
		for option in allPossibleSharingOptions {

			if self.dataSource!.isSharingOptionAvailable(option) {

				sharingOptions.append(option)
			}
		}

		self.getShortURLs(for: sharingOptions, context: context, completion: completion)
	}

	public func getShortURLs(for sharingOptions: [SharingOption], context: SharingContext, completion: /*@escaping*/ RequestCompletionClosure<GetShortURLsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let purposes: [Purpose] = [

			Purpose.Share,
			Purpose.Video
		]

		let params: String = context == SharingContext.SuccessfulPayment ? Constants.Value.TXN : Constants.Value.MENU

		var requests: [ShortURLRequest] = []

		for medium in sharingOptions {

			for purpose in purposes {

				let request = ShortURLRequest(medium: medium, purpose: purpose, params: params)
				requests.append(request)
			}
		}

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.GetShortURLs,
												  requestURLModel: nil,
												  requestBodyModel: GetShortURLsRequestModel(requests: requests),
												  responseObjectType: GetShortURLsResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func shareApp(transactionID: String, medium: SharingOption, status: SharingStatus, completion: /*@escaping*/ RequestCompletionClosure<ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.ShareApp,
												  requestURLModel: nil,
												  requestBodyModel: ShareAppRequestModel(transactionID: transactionID, medium: medium, shareAction: status),
												  responseObjectType: ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func markItemsAsViewed(items: [ListIDRepresentable], completion: /*@escaping*/ RequestCompletionClosure<BadgedResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		var listIDs: [ListID] = []
		for item in items {

			listIDs.append(item.listID)
		}

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.ItemViewedUpdate,
												  requestURLModel: nil,
												  requestBodyModel: ItemViewedUpdateRequestModel(IDs: listIDs),
												  responseObjectType: BadgedResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func sendLinkedEmail(emailOrLinkID: String, requirement: LinkEmailRequirement, transactionID: String?, completion: /*@escaping*/ RequestCompletionClosure<LinkEmailResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.LinkEmail,
												  requestURLModel: nil,
												  requestBodyModel: LinkEmailRequestModel(identifier: emailOrLinkID, transactionID: transactionID, requirement: requirement),
												  responseObjectType: LinkEmailResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func updatePermissions(permissions: Permissions, completion: /*@escaping*/ RequestCompletionClosure<ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.SetPermissions,
												  requestURLModel: nil,
												  requestBodyModel: PermissionsRequestModel(permissions: permissions),
												  responseObjectType: ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func requestSectors(sectors: [Sector], completion: /*@escaping*/ RequestCompletionClosure<ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.RequestSectors,
												  requestURLModel: nil,
												  requestBodyModel: RequestSectorsRequestModel(sectors: sectors),
												  responseObjectType: ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func rateApp(completion: /*@escaping*/ RequestCompletionClosure<ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.RateApp,
												  requestURLModel: nil,
												  requestBodyModel: nil,
												  responseObjectType: ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func linkAccounts(accounts: [ListIDRepresentable], completion: /*@escaping*/ RequestCompletionClosure<QuickAddListResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		var listIDs: [ListID] = []
		for item in accounts {

			listIDs.append(item.listID)
		}

		let model = IDsRequestModel(IDs: listIDs)
		model.serializesToArray = true

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.LinkAccounts,
												  requestURLModel: nil,
												  requestBodyModel: model,
												  responseObjectType: QuickAddListResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func confirmOperator(mobileOperator: ItemIDRepresentable, completion: /*@escaping*/ RequestCompletionClosure<QuickAddListResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.ConfirmOperator,
												  requestURLModel: nil,
												  requestBodyModel: ConfirmOperatorRequestModel(mobileOperator: mobileOperator.itemID),
												  responseObjectType: QuickAddListResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func saveUserGender(gender: Gender, completion: /*@escaping*/ RequestCompletionClosure<ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let inputFields = [

			BusinessField(name: Constants.Value.GENDER, value: gender.stringRepresentation)
		]

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.SaveUserInfo,
												  requestURLModel: nil,
												  requestBodyModel: UserInfoRequestModel(userData: Constants.Value.GENDER, inputFields: inputFields),
												  responseObjectType: ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func saveUserName(name: String?, surname: String?, completion: /*@escaping*/ RequestCompletionClosure<ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let inputFields = [

			BusinessField(name: Constants.Value.FNAME, value: name),
			BusinessField(name: Constants.Value.LNAME, value: surname)
		]

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.SaveUserInfo,
												  requestURLModel: nil,
												  requestBodyModel: UserInfoRequestModel(userData: Constants.Value.NAME, inputFields: inputFields),
												  responseObjectType: ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func notifyThatIntroductionScreenWasShown(screen: AddToListScreen, completion: /*@escaping*/ RequestCompletionClosure<ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let inputFields = [

			BusinessField(name: Constants.Value.SCREEN, value: screen.stringRepresentation)
		]

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.SaveUserInfo,
												  requestURLModel: nil,
												  requestBodyModel: UserInfoRequestModel(userData: Constants.Value.INTRO, inputFields: inputFields),
												  responseObjectType: ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func uploadContacts(contacts: [AddressBookPerson], actions: [PendingRecord], completion: /*@escaping*/ RequestCompletionClosure<ResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.Contacts,
												  requestURLModel: nil,
												  requestBodyModel: UploadContactsRequestModel(contacts: contacts, actions: actions),
												  responseObjectType: ResponseModel(),
												  allowSameSimultaneousOperations: false)

		requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	public func scheduleDailyPaymentForItem(_ item: ListIDRepresentable, with amount: Foundation.Decimal, completion: RequestCompletionClosure<GetListDetailsResponseModel>?) {

		let inputFields: [BusinessField] = [

			BusinessField(name: Constants.Value.schedule_type, value: ScheduleType.daily.stringRepresentation),
			BusinessField(name: Constants.Value.schedule_value, value: String.tap_empty),
			BusinessField(name: Constants.Value.schedule_amount, value: amount.stringValue)
		]

		self.scheduleItem(with: item.listID, options: inputFields, completion: completion)
	}

	public func scheduleDailyPaymentForItemDetails(_ item: ChangedDetailsHomeItem, completion: RequestCompletionClosure<GetListDetailsResponseModel>?) {

		let inputFields: [BusinessField] = [

			BusinessField(name: Constants.Value.schedule_type, value: ScheduleType.daily.stringRepresentation),
			BusinessField(name: Constants.Value.schedule_value, value: String.tap_empty)
		]

		self.scheduleItemDetails(with: item, options: inputFields, completion: completion)
	}

	public func scheduleWeeklyPaymentForItem(_ item: ListIDRepresentable, on day: Day, with amount: Foundation.Decimal, completion: RequestCompletionClosure<GetListDetailsResponseModel>?) {

		let inputFields: [BusinessField] = [

			BusinessField(name: Constants.Value.schedule_type, value: ScheduleType.weekly.stringRepresentation),
			BusinessField(name: Constants.Value.schedule_value, value: day.stringRepresentation),
			BusinessField(name: Constants.Value.schedule_amount, value: amount.stringValue)
		]

		self.scheduleItem(with: item.listID, options: inputFields, completion: completion)
	}

	public func scheduleWeeklyPaymentForItemDetails(_ item: ChangedDetailsHomeItem, on day: Day, completion: RequestCompletionClosure<GetListDetailsResponseModel>?) {

		let inputFields: [BusinessField] = [

			BusinessField(name: Constants.Value.schedule_type, value: ScheduleType.weekly.stringRepresentation),
			BusinessField(name: Constants.Value.schedule_value, value: day.stringRepresentation)
		]

		self.scheduleItemDetails(with: item, options: inputFields, completion: completion)
	}

	public func scheduleMonthlyPaymentForItem(_ item: ListIDRepresentable, on day: Int64, with amount: Foundation.Decimal, completion: RequestCompletionClosure<GetListDetailsResponseModel>?) {

	   let inputFields: [BusinessField] = [

			BusinessField(name: Constants.Value.schedule_type, value: ScheduleType.monthly.stringRepresentation),
			BusinessField(name: Constants.Value.schedule_value, value: day.stringValue_EN_US),
			BusinessField(name: Constants.Value.schedule_amount, value: amount.stringValue)
	   ]

	   self.scheduleItem(with: item.listID, options: inputFields, completion: completion)
	}

	public func scheduleMonthlyPaymentForItemDetails(_ item: ChangedDetailsHomeItem, on day: Int64, completion: RequestCompletionClosure<GetListDetailsResponseModel>?) {

		let inputFields: [BusinessField] = [

			BusinessField(name: Constants.Value.schedule_type, value: ScheduleType.monthly.stringRepresentation),
			BusinessField(name: Constants.Value.schedule_value, value: String.withFormat("%d", [day]))
		]

		self.scheduleItemDetails(with: item, options: inputFields, completion: completion)
	}

	public func scheduleYearlyPaymentForItem(_ item: ListIDRepresentable, on month: Int64, day: Int64, with amount: Foundation.Decimal, completion: RequestCompletionClosure<GetListDetailsResponseModel>?) {

		let inputFields: [BusinessField] = [

			BusinessField(name: Constants.Value.schedule_type, value: ScheduleType.yearly.stringRepresentation),
			BusinessField(name: Constants.Value.schedule_value, value: String.withFormat("%02d%02d", [day, month])),
			BusinessField(name: Constants.Value.schedule_amount, value: amount.stringValue)
		]

		self.scheduleItem(with: item.listID, options: inputFields, completion: completion)
	}

	public func scheduleYearlyPaymentForItemDetails(_ item: ChangedDetailsHomeItem, on month: Int64, day: Int64, completion: RequestCompletionClosure<GetListDetailsResponseModel>?) {

		let inputFields: [BusinessField] = [

			BusinessField(name: Constants.Value.schedule_type, value: ScheduleType.yearly.stringRepresentation),
			BusinessField(name: Constants.Value.schedule_value, value: String.withFormat("%02d%02d", [day, month]))
		]

		self.scheduleItemDetails(with: item, options: inputFields, completion: completion)
	}

	public func removeScheduleForItem(_ item: ListIDRepresentable, completion: RequestCompletionClosure<GetListDetailsResponseModel>?) {

		let inputFields: [BusinessField] = [

			BusinessField(name: Constants.Value.schedule_type, value: String.tap_empty),
			BusinessField(name: Constants.Value.schedule_value, value: String.tap_empty),
			BusinessField(name: Constants.Value.schedule_amount, value: String.tap_empty)
		]

		self.scheduleItem(with: item.listID, options: inputFields, completion: completion)
	}

	//MARK: - Internal -goTapAPI
	//MARK: Properties

	internal private(set) var canStoreSessionIDAndAppLicenseCode = true

	//MARK: - Private -
	//MARK: Methods

	private override init() { super.init() }

	private func checkClientSetup<T: ResponseHolder>(_ completion: RequestCompletionClosure<T>?) -> Swift.Bool {

		let nilResponseModel: T? = nil

		guard dataSource != nil else {

			Dispatcher.dispatchOnMainThread {

				completion?(nilResponseModel, APIError(code: Constants.Error.Code.DataSourceNotSet,
																userInfo: [Constants.Key.ErrorUserInfo.LocalizedDescription: Constants.Error.Message.DataSourceNotSet,
																		   Constants.Key.ErrorUserInfo.Title: Constants.Error.Title.Default]))
			}

			return false
		}

		
		guard delegate != nil else {

			Dispatcher.dispatchOnMainThread {

				completion?(nilResponseModel, APIError(code: Constants.Error.Code.DelegateNotSet,
																userInfo: [Constants.Key.ErrorUserInfo.LocalizedDescription: Constants.Error.Message.DelegateNotSet,
																		   Constants.Key.ErrorUserInfo.Title: Constants.Error.Title.Default]))
			}

			return false
		}
		

		guard requestOperationsManager != nil else {

			Dispatcher.dispatchOnMainThread {

				completion?(nilResponseModel, APIError(code: Constants.Error.Code.RequestOperationsManagerNotSet,
																userInfo: [Constants.Key.ErrorUserInfo.LocalizedDescription: Constants.Error.Message.RequestOperationsManagerNotSet,
																		   Constants.Key.ErrorUserInfo.Title: Constants.Error.Title.Default]))
			}

			return false
		}

		return true
	}

	private func scheduleItem(with listID: ListID, options: [BusinessField], completion: RequestCompletionClosure<GetListDetailsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.ScheduleItem,
												  requestURLModel: nil,
												  requestBodyModel: ScheduleItemRequestModel(listID: listID, inputFields: options),
												  responseObjectType: GetListDetailsResponseModel(),
												  allowSameSimultaneousOperations: false)

		self.requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}

	private func scheduleItemDetails(with changedItem: ChangedDetailsHomeItem, options: [BusinessField], completion: RequestCompletionClosure<GetListDetailsResponseModel>?) {

		guard self.checkClientSetup(completion) else { return }

		let operation = RequestOperation(httpMethod: HttpMethod.Post,
												  requestPath: Constants.RequestPath.ScheduleItemDetail,
												  requestURLModel: nil,
												  requestBodyModel: ScheduleItemDetailsRequestModel(item: changedItem, inputFields: options),
												  responseObjectType: GetListDetailsResponseModel(),
												  allowSameSimultaneousOperations: false)

		self.requestOperationsManager!.performRequest(operation: operation, completion: completion)
	}
}
