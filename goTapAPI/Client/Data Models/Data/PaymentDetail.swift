//
//  TPAPIPaymentDetail.swift
//  goTap
//
//  Created by Dennis Pashkov on 8/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Payment details data model.
public class PaymentDetail: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Name.
	public private(set) var name: String = String.tap_empty

	/// Display value.
	public private(set) var display: String = String.tap_empty

	/// Value.
	public private(set) var value: Foundation.Decimal = Foundation.Decimal.zero

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.PaymentDetail else { return nil }

		guard let parsedName = dictionary.parseString(forKey: goTapAPI.Constants.Key.Name) else { return nil }
		guard let parsedDisplay = dictionary.parseString(forKey: goTapAPI.Constants.Key.Display) else { return nil }
		guard let parsedValue = dictionary.parseAmount(forKey: goTapAPI.Constants.Key.Value) else { return nil }

		model.name = parsedName
		model.display = parsedDisplay
		model.value = parsedValue

		return model.tap_asSelf()
	}
}
