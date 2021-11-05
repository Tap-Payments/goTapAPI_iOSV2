//
//  Response.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/5/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Response model.
public class Response: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Response code.
	public private(set) var code: Int64 = 0

	/// Parameters list.
	public private(set) var parameters: [ErrorMessageDetail] = []

	/// Response ID.
	public private(set) var responseID: String!

	/// Session ID.
	public private(set) var sessionID: String? {

		didSet {

			if Client.sharedInstance.canStoreSessionIDAndAppLicenseCode == false && self.sessionID != nil {

				self.sessionID = nil
				return
			}

			goTapAPI.Client.sharedInstance.dataSource!.saveToUserSettings(sessionID, forKey: goTapAPI.Constants.Key.UserSettings.SessionID)
		}
	}

	internal override var serializedModel: AnyObject? {

		var result: [String: Any] = [:]

		result[goTapAPI.Constants.Key.Code] = self.code
		result[goTapAPI.Constants.Key.ParamList] = self.parameters

		return result as AnyObject
	}

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.Response else { return nil }
		guard model.setupWith(dictionary) else { return nil }

		return model.tap_asSelf()
	}

	internal static func dataModelWith(_ dictionaryModel: AnyObject?) -> goTapAPI.Response? {

		guard let dictionary = dictionaryModel as? [String: AnyObject] else { return nil }

		let model = goTapAPI.Response()
		guard model.setupWith(dictionary) else { return nil }
		return model.tap_asSelf()
	}

	//MARK: - Private -
	//MARK: Properties

	private var fullySerializedModel: AnyObject? {

		guard var result = self.serializedModel as? [String: Any] else { return nil }

		result[goTapAPI.Constants.Key.ResponseID] = self.responseID

		return result as AnyObject
	}

	//MARK: Methods

	public required init() { super.init() }

	public convenience init(code aCode: Int64) {

		self.init()
		self.code = aCode
	}

	private func setupWith(_ dictionary: [String: AnyObject]) -> Swift.Bool {

		guard let codeValue = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.Code) else {

			//writeLn("Could not parse response code.")
			return false
		}

		guard let responseIDString = dictionary.parseString(forKey: goTapAPI.Constants.Key.ResponseID) else {

			//writeLn("Could not parse response ID.")
			return false
		}


		let parameterParsingClosure: (AnyObject) -> goTapAPI.ErrorMessageDetail? = { object in

			return goTapAPI.ErrorMessageDetail().dataModelWith(serializedObject: object)
		}

		let emptyParams: [goTapAPI.ErrorMessageDetail] = []
		let parsedParams: [goTapAPI.ErrorMessageDetail] = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.ParamList), usingClosure: parameterParsingClosure) ?? emptyParams

		self.code = codeValue
		self.parameters = parsedParams
		self.responseID = responseIDString
		self.sessionID = dictionary.parseString(forKey: goTapAPI.Constants.Key.SessionID)

		return true
	}
}
