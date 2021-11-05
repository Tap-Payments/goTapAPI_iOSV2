//
//  Notifications.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 28/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Notifications model.
public class Notifications: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Defines if push notifications are enabled.
	public private(set) var enabled: Bool = false

	/// Defines push notifications style.
	public private(set) var style: Int64 = 0

	/// APN device token.
	public private(set) var deviceToken: String?

	internal override var serializedModel: AnyObject? {

		var result: [String: Any] = [

			goTapAPI.Constants.Key.Enabled : enabled,
			goTapAPI.Constants.Key.Style : style
		]

		result[goTapAPI.Constants.Key.DeviceToken] = self.deviceToken ?? NSNull()

		return result as AnyObject
	}

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }

		let model = goTapAPI.Notifications()

		model.enabled = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.Enabled) ?? false
		model.style = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.Style) ?? 0
		model.deviceToken = dictionary.parseString(forKey: goTapAPI.Constants.Key.DeviceToken)

		return model.tap_asSelf()
	}

	public required init() { super.init() }

	/// Initializes notifications object.
	public convenience init(notificationsEnabled: Bool, notificationsStyle: Int64, notificationsDeviceToken: String?) {

		self.init()

		self.enabled = notificationsEnabled
		self.style = notificationsStyle
		self.deviceToken = notificationsDeviceToken
	}

	public override func isEqual(_ object: Any?) -> Bool {

		guard let notificationsObject = object as? goTapAPI.Notifications else { return false }

		return ( self.enabled == notificationsObject.enabled &&
				 self.style == notificationsObject.style &&
				 StringExtension.equal(string1: self.deviceToken, string2: notificationsObject.deviceToken) )
	}
}
