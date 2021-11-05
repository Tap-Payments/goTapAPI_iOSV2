//
//  TransactionCharge.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/10/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Transaction charge data model.
public class TransactionCharge: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Gateway ID.
	public private(set) var gatewayID: Int64 = 0

	/// Vendor ID.
	public private(set) var vendorID: Int64 = 0

	/// Vendor name.
	public private(set) var vendorName: String = String.tap_empty

	/// Vendor image URL.
	public private(set) var vendorImageURL: URL?

	/// Currency code.
	public private(set) var currencyCode: String = String.tap_empty

	/// Extra charge.
	public private(set) var extraCharge: Foundation.Decimal = Foundation.Decimal.zero

	/// Payment currency code.
	public private(set) var paymentCurrencyCode: String = String.tap_empty

	/// Payment extra charge.
	public private(set) var paymentExtraCharge: Foundation.Decimal = Foundation.Decimal.zero

	/// Payment currency symbol.
	public private(set) var paymentCurrencySymbol: String = String.tap_empty

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.TransactionCharge else { return nil }

		guard let parsedGatewayID = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.GateWayID) else { return nil }
		guard let parsedVendorID = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.VndID) else { return nil }
		guard let parsedVendorName = dictionary.parseString(forKey: goTapAPI.Constants.Key.VndName) else { return nil }
		guard let parsedCurrencyCode = dictionary.parseString(forKey: goTapAPI.Constants.Key.CurrencyCD) else { return nil }
		guard let parsedExtraCharge = dictionary.parseAmount(forKey: goTapAPI.Constants.Key.ExtraCharge) else { return nil }
		guard let parsedPaymentCurrencyCode = dictionary.parseString(forKey: goTapAPI.Constants.Key.PayCurrencyCD) else { return nil }
		guard let parsedPaymentExtraCharge = dictionary.parseAmount(forKey: goTapAPI.Constants.Key.PayExtraCharge) else { return nil }
		guard let parsedPaymentCurrencySymbol = dictionary.parseString(forKey: goTapAPI.Constants.Key.PayCurrencySymbol) else { return nil }

		model.gatewayID = parsedGatewayID
		model.vendorID = parsedVendorID
		model.vendorName = parsedVendorName
		model.vendorImageURL = dictionary.parseURL(forKey: goTapAPI.Constants.Key.VndImage)
		model.currencyCode = parsedCurrencyCode
		model.extraCharge = parsedExtraCharge
		model.paymentCurrencyCode = parsedPaymentCurrencyCode
		model.paymentExtraCharge = parsedPaymentExtraCharge
		model.paymentCurrencySymbol = parsedPaymentCurrencySymbol

		return model.tap_asSelf()
	}
}
