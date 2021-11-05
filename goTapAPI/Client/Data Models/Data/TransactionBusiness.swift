//
//  TransactionBusiness.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Transaction business data model.
public class TransactionBusiness: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Vendor ID.
	public private(set) var vendorID: Int64 = 0

	/// Vendor name.
	public private(set) var vendorName: String = String.tap_empty

	/// Vendor image URL.
	public private(set) var vendorImageURL: URL?

	/// Currency code.
	public private(set) var currencyCode: String = String.tap_empty

	/// Defines if tip is available.
	public private(set) var isTipAvailable: Swift.Bool = false

	/// Discount percent.
	public private(set) var discountPercent: Foundation.Decimal = Foundation.Decimal.zero

	/// Discount amount.
	public private(set) var discountAmount: Foundation.Decimal = Foundation.Decimal.zero

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.TransactionBusiness else { return nil }

		guard let parsedVendorID = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.VndID) else { return nil }
		guard let parsedVendorName = dictionary.parseString(forKey: goTapAPI.Constants.Key.VndName) else { return nil }
		guard let parsedCurrencyCode = dictionary.parseString(forKey: goTapAPI.Constants.Key.CurrencyCD) else { return nil }

		model.vendorID = parsedVendorID
		model.vendorName = parsedVendorName
		model.vendorImageURL = dictionary.parseURL(forKey: goTapAPI.Constants.Key.VndImage)
		model.currencyCode = parsedCurrencyCode
		model.isTipAvailable = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.TipAvail) ?? false
		model.discountPercent = dictionary.parseAmount(forKey: goTapAPI.Constants.Key.DiscPer) ?? Foundation.Decimal.zero
		model.discountAmount = dictionary.parseAmount(forKey: goTapAPI.Constants.Key.DiscAmount) ?? Foundation.Decimal.zero

		return model.tap_asSelf()
	}
}
