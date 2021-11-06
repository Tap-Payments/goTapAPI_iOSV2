//
//  LinkEmailResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/1/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Response model for link email request.
public class LinkEmailResponseModel: ResponseModel {

	//MARK: - Public -
	//MARK: Properties

	/// Data.
	public private(set) var data: String = String.tap_empty

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? LinkEmailResponseModel else { return nil }

		if let dataString = dictionary.parseString(forKey: Constants.Key.Data) {

			model.data = dataString
		}

		return model.tap_asSelf()
	}
}
