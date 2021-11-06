//
//  AddressFormatDetail.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 2/24/17.
//  Copyright © 2017 Tap Payments. All rights reserved.
//

/// Address format details model.
public class AddressFormatDetail: DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Field ID.
	public private(set) var fieldID: Int64 = 0

	/// Detail ID.
	public private(set) var detailID: Int64 = 0

	/// Display value.
	public private(set) var detailDisplayValue: String = String.tap_empty

	/// Display order.
	public private(set) var displayOrder: Int64 = 0

	//MARK: - Internal -
	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? AddressFormatDetail else { return nil }

		model.fieldID = dictionary.parseInteger(forKey: Constants.Key.FldID) ?? 0
		model.detailID = dictionary.parseInteger(forKey: Constants.Key.DtlID) ?? 0
		model.detailDisplayValue = dictionary.parseString(forKey: Constants.Key.DtlDispValue) ?? String.tap_empty
		model.displayOrder = dictionary.parseInteger(forKey: Constants.Key.DispOrder) ?? 0

		return model.tap_asSelf()
	}
}
