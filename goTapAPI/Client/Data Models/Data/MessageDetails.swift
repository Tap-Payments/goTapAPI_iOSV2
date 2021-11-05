//
//  MessageDetails.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Message details data model.
public class MessageDetails: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Name.
	public private(set) var name: String = String.tap_empty

	/// Display value.
	public private(set) var display: String = String.tap_empty

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.MessageDetails else { return nil }

		guard let parsedName = dictionary.parseString(forKey: goTapAPI.Constants.Key.Name) else { return nil }
		guard let parsedDisplay = dictionary.parseString(forKey: goTapAPI.Constants.Key.Display) else { return nil }

		model.name = parsedName
		model.display = parsedDisplay

		return model.tap_asSelf()
	}
}
