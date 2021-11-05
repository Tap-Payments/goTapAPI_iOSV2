//
//  Order.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Order data model.
public class Order: goTapAPI.DataModel, goTapAPI.PaymentSerialization, goTapAPI.ListIDRepresentable {

	//MARK: - Public -
	//MARK: Properties

	/// Identifier.
	public private(set) var identifier: Int64 = 0

	/// Action.
	public private(set) var action: goTapAPI.TransactionAction = goTapAPI.TransactionAction()

	/// Amount.
	public private(set) var amount: Foundation.Decimal = Foundation.Decimal.zero

	/// Currency code.
	public private(set) var currencyCode: String = String.tap_empty

	/// Due date.
	public private(set) var dueDate: Date = Date()

	/// Defines if alret should be enabled.
	public private(set) var shouldEnableAlert: Swift.Bool = false

	/// Defines if tip is available.
	public private(set) var isTipAvailable: Swift.Bool = false

	/// Products.
	public private(set) var products: [goTapAPI.TransactionProduct] = []

	/// Order status.
	public private(set) var status: String = String.tap_empty

	/// Order type.
	public private(set) var type: goTapAPI.ItemType = goTapAPI.ItemType.Static

	/// Vendor identifier.
	public private(set) var vendorID: Int64 = 0

	/// Vendor image URL.
	public private(set) var vendorImageURL: URL?

	/// Vendor name.
	public private(set) var vendorName: String = String.tap_empty

	/// Generated list ID of the order.
	public var listID: goTapAPI.ListID {

		return goTapAPI.ListID(number: self.identifier, type: self.type)
	}

	internal override var serializedModel: AnyObject? {

		let result: [String: Any] = [

			goTapAPI.Constants.Key.ID: identifier,
			goTapAPI.Constants.Key.ItemType: type
		]

		return result as AnyObject
	}

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.Order else { return nil }

		guard let parsedIdentifier = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.ID) else { return nil }
		guard let parsedType = dictionary.parseString(forKey: goTapAPI.Constants.Key.Type_) else { return nil }
		guard let parsedStatus = dictionary.parseString(forKey: goTapAPI.Constants.Key.Status) else { return nil }
		guard let parsedVendorID = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.VndID) else { return nil }
		guard let parsedDueDate = dictionary.parseDate(forKey: goTapAPI.Constants.Key.DueDate) else { return nil }
		guard let parsedVendorName = dictionary.parseString(forKey: goTapAPI.Constants.Key.VndName) else { return nil }
		guard let parsedCurrencyCode = dictionary.parseString(forKey: goTapAPI.Constants.Key.CurrencyCD) else { return nil }
		guard let parsedAmount = dictionary.parseAmount(forKey: goTapAPI.Constants.Key.Amount) else { return nil }

		let productParsingClosure: (AnyObject) -> goTapAPI.TransactionProduct? = { object in

			return goTapAPI.TransactionProduct().dataModelWith(serializedObject: object)
		}

		guard let parsedProducts = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.Products), usingClosure: productParsingClosure) else { return nil }

		guard let parsedAction = goTapAPI.TransactionAction().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: goTapAPI.Constants.Key.Action) as AnyObject) else { return nil }

		model.identifier = parsedIdentifier
		model.action = parsedAction
		model.amount = parsedAmount
		model.currencyCode = parsedCurrencyCode
		model.dueDate = parsedDueDate
		model.shouldEnableAlert = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.EnableAlert) ?? false
		model.isTipAvailable = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.IsTipAvail) ?? false
		model.products = parsedProducts
		model.status = parsedStatus
		model.type = goTapAPI.ItemType.with(stringValue: parsedType)
		model.vendorID = parsedVendorID
		model.vendorImageURL = dictionary.parseURL(forKey: goTapAPI.Constants.Key.VndImage)
		model.vendorName = parsedVendorName

		return model.tap_asSelf()
	}

	public func paymentAmount() -> Foundation.Decimal {

		return self.amount
	}

	public func paymentBusinessID() -> Int64 {

		return self.vendorID
	}

	public func paymentName() -> String {

		return self.vendorName
	}

	public func paymentCurrencyCode() -> String {

		return self.currencyCode
	}

	public func paymentProductImageURL() -> URL? {

		return self.vendorImageURL
	}

	public func paymentSerializedModel() -> AnyObject {

		return serializedModel ?? NSNull()
	}
}
