//
//  Permissions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 11/21/15.
//  Copyright © 2015 Tap Payments. All rights reserved.
//

/// Permissions model
public class Permissions: DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Camera permission.
	public private(set) var cameraGranted: Swift.Bool = false

	/// Contacts permission.
	public private(set) var contactsGranted: Swift.Bool = false

	/// Location permission.
	public private(set) var locationGranted: Swift.Bool = false

	/// Photos permission.
	public private(set) var photosGranted: Swift.Bool = false

	/// Notifications permission.
	public private(set) var notifications: Notifications = Notifications()

	/// SMS permission.
	public private(set) var smsGranted: Swift.Bool = false

	internal override var serializedModel: AnyObject? {

		var result: [String: Any] = [

			Constants.Key.Camera : self.cameraGranted,
			Constants.Key.Contacts : self.contactsGranted,
			Constants.Key.Location : self.locationGranted,
			Constants.Key.Photos : self.photosGranted,
			Constants.Key.SMS: self.smsGranted
		]

		result[Constants.Key.Notifications] = self.notifications.serializedModel ?? NSNull()

		return result as AnyObject
	}

	//MARK: Methods

	public required init() { super.init() }

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }

		let model = Permissions()

		model.cameraGranted = dictionary.parseBoolean(forKey: Constants.Key.Camera) ?? false
		model.contactsGranted = dictionary.parseBoolean(forKey: Constants.Key.Contacts) ?? false
		model.locationGranted = dictionary.parseBoolean(forKey: Constants.Key.Location) ?? false
		model.photosGranted = dictionary.parseBoolean(forKey: Constants.Key.Photos) ?? false
		model.smsGranted = dictionary.parseBoolean(forKey: Constants.Key.SMS) ?? false

		if let notificationsDict = dictionary.parseDictionary(forKey: Constants.Key.Notifications) {

			if let notif = Notifications().dataModelWith(serializedObject: notificationsDict) {

				model.notifications = notif
			}
		}

		return model.tap_asSelf()
	}

	/**
	 Initializes data model with given set of permissions.

	 - parameter cameraGranted:        Camera permission.
	 - parameter contactsGranted:      Contacts permission.
	 - parameter locationGranted:      Location permission.
	 - parameter photosGranted:        Photos permission.
	 - parameter notifications:        Notifications object.

	 - returns: Permissions.
	 */
	public convenience init(cameraGranted: Swift.Bool, contactsGranted: Swift.Bool, locationGranted: Swift.Bool, photosGranted: Swift.Bool, notifications: Notifications) {

		self.init(cameraGranted: cameraGranted, contactsGranted: contactsGranted, locationGranted: locationGranted, photosGranted: photosGranted, smsGranted: false, notifications: notifications)
	}

	/**
	 Initializes data model with given set of permissions.

	 - parameter cameraGranted:        Camera permission.
	 - parameter contactsGranted:      Contacts permission.
	 - parameter locationGranted:      Location permission.
	 - parameter photosGranted:        Photos permission.
	 - parameter smsGranted:           SMS permission.
	 - parameter notifications:        Notifications object.

	 - returns: Permissions.
	 */
	public convenience init(cameraGranted: Swift.Bool, contactsGranted: Swift.Bool, locationGranted: Swift.Bool, photosGranted: Swift.Bool, smsGranted: Swift.Bool, notifications: Notifications) {

		self.init()

		self.cameraGranted = cameraGranted
		self.contactsGranted = contactsGranted
		self.locationGranted = locationGranted
		self.photosGranted = photosGranted
		self.smsGranted = smsGranted
		self.notifications = notifications
	}

	public override func isEqual(_ object: Any?) -> Bool {

		guard let permissionsObject = object as? Permissions else { return false }

		return ( permissionsObject.cameraGranted == self.cameraGranted &&
				 permissionsObject.contactsGranted == self.contactsGranted &&
				 permissionsObject.locationGranted == self.locationGranted &&
				 permissionsObject.notifications.isEqual(self.notifications) &&
				 permissionsObject.photosGranted == self.photosGranted &&
				 permissionsObject.smsGranted == self.smsGranted)
	}
}
