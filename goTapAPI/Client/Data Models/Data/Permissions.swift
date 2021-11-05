//
//  Permissions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 11/21/15.
//  Copyright © 2015 Tap Payments. All rights reserved.
//

/// Permissions model
public class Permissions: goTapAPI.DataModel {

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
	public private(set) var notifications: goTapAPI.Notifications = goTapAPI.Notifications()

	/// SMS permission.
	public private(set) var smsGranted: Swift.Bool = false

	internal override var serializedModel: AnyObject? {

		var result: [String: Any] = [

			goTapAPI.Constants.Key.Camera : self.cameraGranted,
			goTapAPI.Constants.Key.Contacts : self.contactsGranted,
			goTapAPI.Constants.Key.Location : self.locationGranted,
			goTapAPI.Constants.Key.Photos : self.photosGranted,
			goTapAPI.Constants.Key.SMS: self.smsGranted
		]

		result[goTapAPI.Constants.Key.Notifications] = self.notifications.serializedModel ?? NSNull()

		return result as AnyObject
	}

	//MARK: Methods

	public required init() { super.init() }

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }

		let model = goTapAPI.Permissions()

		model.cameraGranted = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.Camera) ?? false
		model.contactsGranted = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.Contacts) ?? false
		model.locationGranted = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.Location) ?? false
		model.photosGranted = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.Photos) ?? false
		model.smsGranted = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.SMS) ?? false

		if let notificationsDict = dictionary.parseDictionary(forKey: goTapAPI.Constants.Key.Notifications) {

			if let notif = goTapAPI.Notifications().dataModelWith(serializedObject: notificationsDict) {

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
	public convenience init(cameraGranted: Swift.Bool, contactsGranted: Swift.Bool, locationGranted: Swift.Bool, photosGranted: Swift.Bool, notifications: goTapAPI.Notifications) {

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
	public convenience init(cameraGranted: Swift.Bool, contactsGranted: Swift.Bool, locationGranted: Swift.Bool, photosGranted: Swift.Bool, smsGranted: Swift.Bool, notifications: goTapAPI.Notifications) {

		self.init()

		self.cameraGranted = cameraGranted
		self.contactsGranted = contactsGranted
		self.locationGranted = locationGranted
		self.photosGranted = photosGranted
		self.smsGranted = smsGranted
		self.notifications = notifications
	}

	public override func isEqual(_ object: Any?) -> Bool {

		guard let permissionsObject = object as? goTapAPI.Permissions else { return false }

		return ( permissionsObject.cameraGranted == self.cameraGranted &&
				 permissionsObject.contactsGranted == self.contactsGranted &&
				 permissionsObject.locationGranted == self.locationGranted &&
				 permissionsObject.notifications.isEqual(self.notifications) &&
				 permissionsObject.photosGranted == self.photosGranted &&
				 permissionsObject.smsGranted == self.smsGranted)
	}
}
