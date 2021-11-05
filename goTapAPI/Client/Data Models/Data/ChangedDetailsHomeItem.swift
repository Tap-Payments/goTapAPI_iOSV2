//
//  ChangedDetailsHomeItem.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/7/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Detailed home item changes data model to be posted on the server.
public class ChangedDetailsHomeItem: goTapAPI.DataModel, goTapAPI.PaymentSerialization {

	//MARK: - Public -
	//MARK: Properties

	/// Identifier.
	private(set) var identifier: Int64 = 0

	/// Product identifier.
	private(set) var productID: Int64 = 0

	/// Business identifier.
	public private(set) var businessID: Int64 = 0

	/// Business account number.
	private(set) var businessAccount: String = String.tap_empty

	/// Display name.
	private(set) var displayName: String?

	/// Item type.
	private(set) var itemType: goTapAPI.ItemType = goTapAPI.ItemType.Static

	/// Payment currency code.
	private(set) var payCurrencyCode: String?

	/// Total amount.
	private(set) var totalAmount: Foundation.Decimal = Foundation.Decimal.zero

	/// Product currency code.
	private(set) var productCurrencyCode: String?

	/// Item headers.
	private(set) var itemHeaders: [goTapAPI.ItemHeader] = []

	/// Item header details.
	private(set) var itemHeaderDetails: [goTapAPI.DetailedItemHeader] = []

	/// Product image URL.
	public private(set) var productImageURL: URL?

	override var serializedModel: AnyObject? {

		var result: [String: Any] = [

			goTapAPI.Constants.Key.ID: identifier,
			goTapAPI.Constants.Key.PrdID: productID,
			goTapAPI.Constants.Key.BizID: businessID,
			goTapAPI.Constants.Key.TotalAmount: totalAmount
		]

		result[goTapAPI.Constants.Key.BizAcN] = businessAccount
		result[goTapAPI.Constants.Key.ItemType] = itemType.stringRepresentation
		result[goTapAPI.Constants.Key.PayCurrCode] = payCurrencyCode ?? NSNull()
		result[goTapAPI.Constants.Key.PrdCurrCode] = productCurrencyCode ?? NSNull()

		if itemHeaders.count > 0 && itemHeaderDetails.count > 0 {

			result.setNullable(value: goTapAPI.ParseHelper.serialize(array: itemHeaders), forKey: goTapAPI.Constants.Key.ItemHdrs)
			result.setNullable(value: goTapAPI.ParseHelper.serialize(array: itemHeaderDetails), forKey: goTapAPI.Constants.Key.IItemHdrDtls)
		}

		return result as AnyObject
	}

	//MARK: Methods

	/**
	 Initializes data model with the fields.

	 - parameter identifier:          Identifier.
	 - parameter productID:           Product identifier.
	 - parameter businessID:          Business identifier.
	 - parameter businessAccount:     Business account.
	 - parameter itemType:            Item type.
	 - parameter paymentCurrencyCode: Payment currency code.
	 - parameter totalAmount:         Total amount.
	 - parameter productCurrencyCode: Product currency code.
	 - parameter itemHeaders:         Item headers.
	 - parameter itemHeaderDetails:   Item header details.
	 - parameter productImageURL:     Product image URL.

	 - returns: TPAPIChangedDetailsHomeItem
	 */
	public init(identifier: Int64, productID: Int64, businessID: Int64, businessAccount: String, displayName: String?, itemType: goTapAPI.ItemType, paymentCurrencyCode: String?, totalAmount: Foundation.Decimal, productCurrencyCode: String?, itemHeaders: [goTapAPI.ItemHeader], itemHeaderDetails: [goTapAPI.DetailedItemHeader], productImageURL: URL?) {

		super.init()

		self.identifier = identifier
		self.productID = productID
		self.businessID = businessID
		self.businessAccount = businessAccount
		self.displayName = displayName
		self.itemType = itemType
		self.payCurrencyCode = paymentCurrencyCode
		self.totalAmount = totalAmount
		self.productCurrencyCode = productCurrencyCode
		self.itemHeaders = itemHeaders
		self.itemHeaderDetails = itemHeaderDetails
		self.productImageURL = productImageURL
	}

	public func paymentAmount() -> Foundation.Decimal {

		return self.totalAmount
	}

	public func paymentBusinessID() -> Int64 {

		return self.businessID
	}

	public func paymentName() -> String {

		return self.displayName ?? self.businessAccount
	}

	public func paymentCurrencyCode() -> String {

		return self.payCurrencyCode ?? self.productCurrencyCode ?? String.tap_empty
	}

	public func paymentProductImageURL() -> URL? {

		return self.productImageURL
	}

	public func paymentSerializedModel() -> AnyObject {

		return serializedModel ?? NSNull()
	}

	public required init() { super.init() }

	public override func isEqual(_ object: Any?) -> Bool {

		guard let changedItem = object as? goTapAPI.ChangedDetailsHomeItem else { return false }

		if self.identifier != changedItem.identifier { return false }
		if self.productID != changedItem.productID { return false }
		if self.businessID != changedItem.businessID { return false }
		if !StringExtension.equal(string1: self.businessAccount, string2: changedItem.businessAccount) { return false }
		if !StringExtension.equal(string1: self.displayName, string2: changedItem.displayName) { return false }
		if self.itemType != changedItem.itemType { return false }
		if !StringExtension.equal(string1: self.payCurrencyCode, string2: changedItem.payCurrencyCode) { return false }
		if self.totalAmount != changedItem.totalAmount { return false }
		if !StringExtension.equal(string1: self.productCurrencyCode, string2: changedItem.productCurrencyCode) { return false }

		if self.itemHeaders.count != changedItem.itemHeaders.count { return false }
		for header in self.itemHeaders {

			var found = false
			for otherHeader in changedItem.itemHeaders {

				guard header.identifier == otherHeader.identifier else { continue }

				if header.isEqual(otherHeader) {

					found = true
					break
				}
			}

			if !found {

				return false
			}
		}

		if self.itemHeaderDetails.count != changedItem.itemHeaderDetails.count { return false }
		for detailedHeader in self.itemHeaderDetails {

			var found = false
			for otherDetailedHeader in changedItem.itemHeaderDetails {

				guard detailedHeader.identifier == otherDetailedHeader.identifier else { continue }

				if detailedHeader.isEqual(otherDetailedHeader) {

					found = true
					break
				}
			}

			if !found {

				return false
			}
		}

		return true
	}
}
