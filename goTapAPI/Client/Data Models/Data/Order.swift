//
//  Order.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Order data model.
public class Order: DataModel, PaymentSerialization, ListIDRepresentable {

	//MARK: - Public -
	//MARK: Properties

	/// Identifier.
	public private(set) var identifier: Int64 = 0

	/// Action.
	public private(set) var action: TransactionAction = TransactionAction()

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
	public private(set) var products: [TransactionProduct] = []

	/// Order status.
	public private(set) var status: String = String.tap_empty

	/// Order type.
	public private(set) var type: ItemType = ItemType.Static

	/// Vendor identifier.
	public private(set) var vendorID: Int64 = 0

	/// Vendor image URL.
	public private(set) var vendorImageURL: URL?

	/// Vendor name.
	public private(set) var vendorName: String = String.tap_empty

	/// Generated list ID of the order.
	public var listID: ListID {

		return ListID(number: self.identifier, type: self.type)
	}

	internal override var serializedModel: AnyObject? {

		let result: [String: Any] = [

			Constants.Key.ID: identifier,
			Constants.Key.ItemType: type
		]

		return result as AnyObject
	}

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? Order else { return nil }

		guard let parsedIdentifier = dictionary.parseInteger(forKey: Constants.Key.ID) else { return nil }
		guard let parsedType = dictionary.parseString(forKey: Constants.Key.Type_) else { return nil }
		guard let parsedStatus = dictionary.parseString(forKey: Constants.Key.Status) else { return nil }
		guard let parsedVendorID = dictionary.parseInteger(forKey: Constants.Key.VndID) else { return nil }
		guard let parsedDueDate = dictionary.parseDate(forKey: Constants.Key.DueDate) else { return nil }
		guard let parsedVendorName = dictionary.parseString(forKey: Constants.Key.VndName) else { return nil }
		guard let parsedCurrencyCode = dictionary.parseString(forKey: Constants.Key.CurrencyCD) else { return nil }
		guard let parsedAmount = dictionary.parseAmount(forKey: Constants.Key.Amount) else { return nil }

		let productParsingClosure: (AnyObject) -> TransactionProduct? = { object in

			return TransactionProduct().dataModelWith(serializedObject: object)
		}

		guard let parsedProducts = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.Products), usingClosure: productParsingClosure) else { return nil }

		guard let parsedAction = TransactionAction().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: Constants.Key.Action) as AnyObject) else { return nil }

		model.identifier = parsedIdentifier
		model.action = parsedAction
		model.amount = parsedAmount
		model.currencyCode = parsedCurrencyCode
		model.dueDate = parsedDueDate
		model.shouldEnableAlert = dictionary.parseBoolean(forKey: Constants.Key.EnableAlert) ?? false
		model.isTipAvailable = dictionary.parseBoolean(forKey: Constants.Key.IsTipAvail) ?? false
		model.products = parsedProducts
		model.status = parsedStatus
		model.type = ItemType.with(stringValue: parsedType)
		model.vendorID = parsedVendorID
		model.vendorImageURL = dictionary.parseURL(forKey: Constants.Key.VndImage)
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
