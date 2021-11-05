//
//  HomeItem.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Home item data model.
public class HomeItem: goTapAPI.DataModel, goTapAPI.PaymentSerialization, goTapAPI.ListIDRepresentable, goTapAPI.ItemIDRepresentable {

	//MARK: - Public -
	//MARK: Properties

	/// Action.
	public private(set) var action: goTapAPI.ItemAction = goTapAPI.ItemAction.None

	/// Amount.
	public private(set) var amount: Foundation.Decimal = Foundation.Decimal.zero

	/// Business account.
	public private(set) var businessAccount: String = String.tap_empty

	/// Business item.
	public var business: BusinessItem?

	/// Business ID.
	public private(set) var businessID: Int64 = 0

	/// Defines if item can be deleted.
	public private(set) var canBeDeleted: Swift.Bool = false

	/// Date.
	public private(set) var date: Date = Date()

	/// Due date.
	public private(set) var dueDate: Date = Date()

	/// Defines if alert should be enabled.
	public var shouldEnableAlert: Swift.Bool = false

	/// Group.
	public var group: TPGroup?

	/// Group ID.
	public private(set) var groupID: Int64 = 0

	/// Group item order by.
	public private(set) var groupItemOrderBy: Int64 = 0

	/// Identifier.
	public private(set) var identifier: Int64 = 0

	/// Defines if item is new.
	public var isNew: Swift.Bool = false

	/// Item order by.
	public private(set) var itemOrderBy: Int64 = 0

	/// Item row type.
	public private(set) var itemRowType: goTapAPI.ItemRowType = goTapAPI.ItemRowType.None

	/// Item type.
	public private(set) var itemType: goTapAPI.ItemType = goTapAPI.ItemType.Static

	/// Last updated on.
	public private(set) var lastUpdatedOn: Date?

	/// Linked account description.
	public private(set) var linkedAccountDescription: String?

	/// Defines if item is linked.
	public private(set) var isLinkedItem: Swift.Bool = false

	/// List name.
	public private(set) var listName: String = String.tap_empty

	/// Defines if item is my list.
	public var isMyListItem: Swift.Bool = false

	/// Next update date.
	public private(set) var nextUpdateDate: Date = Date(9999, 1, 1)

	/// Payment currency code.
	public private(set) var payCurrencyCode: String = String.tap_empty

	/// Payment description.
	public private(set) var paymentDescription: String = String.tap_empty

	/// Product currency code.
	public private(set) var productCurrencyCode: String = String.tap_empty

	/// Product description.
	public private(set) var productDescription: String = String.tap_empty

	/// Product ID.
	public private(set) var productID: Int64 = 0

	/// Product image URL.
	public private(set) var productImageURL: URL?

	/// Remarks.
	public private(set) var remarks: String?

	/// Status.
	public private(set) var status: goTapAPI.ItemStatus = goTapAPI.ItemStatus.Failed

	/// Minimal custom amount.
	public private(set) var minimalCustomAmount: Foundation.Decimal = Foundation.Decimal.zero

	/// Maximal custom amount.
	public private(set) var maximalCustomAmount: Foundation.Decimal = Foundation.Decimal.zero

	/// Schedule day.
	public private(set) var scheduleDay: Int64 = 1

	/// Generated list ID of the item.
	public var listID: goTapAPI.ListID {

		return goTapAPI.ListID(number: self.identifier, type: self.itemType)
	}

	public var itemID: goTapAPI.ItemID {

		return goTapAPI.ItemID(businessID: self.businessID, identifier: self.identifier, itemType: self.itemType.stringRepresentation)
	}

	internal override var storesOriginalObject: Swift.Bool { return true }

	/// Data model with required fields to pay.
	internal var changedDetails: goTapAPI.ChangedDetailsHomeItem! {

		return goTapAPI.ChangedDetailsHomeItem(

			identifier: identifier,
			productID: productID,
			businessID: businessID,
			businessAccount: businessAccount,
			displayName: listName,
			itemType: itemType,
			paymentCurrencyCode: payCurrencyCode,
			totalAmount: amount,
			productCurrencyCode: productCurrencyCode,
			itemHeaders: [],
			itemHeaderDetails: [],
			productImageURL: productImageURL
		)
	}

	/// Defines if item can be paid.
	public var canBePaid: Swift.Bool {

		return status == goTapAPI.ItemStatus.Active
	}

	/// Defines if item is paid.
	public var isPaid: Swift.Bool {

		return itemRowType == goTapAPI.ItemRowType.Paid
	}

	//MARK: Methods

	public required init() { super.init() }

	public convenience init(group aGroup: TPGroup) {

		self.init()
		self.group = aGroup
	}

	public convenience init(identifier: Int64, type: goTapAPI.ItemType) {

		self.init()

		self.identifier = identifier
		self.itemType = type
	}

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.HomeItem else { return nil }

		guard let parsedListName = dictionary.parseString(forKey: goTapAPI.Constants.Key.LstName) else {

			return nil
		}

		guard parsedListName.Length > 0 else { return nil }

		if let parsedBusinessAccount = dictionary.parseString(forKey: goTapAPI.Constants.Key.BizAcN) {

			model.businessAccount = parsedBusinessAccount
		}

		if let parsedDate = dictionary.parseDate(forKey: goTapAPI.Constants.Key.Date) {

			model.date = parsedDate
		}

		if let parsedDueDate = dictionary.parseDate(forKey: goTapAPI.Constants.Key.DueDate) {

			model.dueDate = parsedDueDate
		}

		if let parsedNextUpdateDate = dictionary.parseDate(forKey: goTapAPI.Constants.Key.NextUpdateDate) {

			model.nextUpdateDate = parsedNextUpdateDate
		}

		if let parsedPaymentCurrencyCode = dictionary.parseString(forKey: goTapAPI.Constants.Key.PayCurrCode) {

			model.payCurrencyCode = parsedPaymentCurrencyCode
		}

		if let parsedPaymentDescription = dictionary.parseString(forKey: goTapAPI.Constants.Key.PayDesc) {

			model.paymentDescription = parsedPaymentDescription
		}

		if let parsedProductCurrencyCode = dictionary.parseString(forKey: goTapAPI.Constants.Key.PrdCurrCode) {

			model.productCurrencyCode = parsedProductCurrencyCode
		}

		if let parsedProductDescription = dictionary.parseString(forKey: goTapAPI.Constants.Key.PrdDesc) {

			model.productDescription = parsedProductDescription
		}

		model.action = goTapAPI.ItemAction.with(stringValue: dictionary.parseString(forKey: goTapAPI.Constants.Key.Action))
		model.amount = dictionary.parseAmount(forKey: goTapAPI.Constants.Key.Amount) ?? Foundation.Decimal.zero
		model.businessID = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.BizID) ?? 0
		model.canBeDeleted = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.CanDelete) ?? false
		model.shouldEnableAlert = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.EnableAlert) ?? false
		model.groupID = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.GroupID) ?? 0
		model.groupItemOrderBy = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.GroupItemOrderBy) ?? 0
		model.identifier = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.ID) ?? 0
		model.itemOrderBy = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.ItemOrderBy) ?? 0
		model.itemRowType = goTapAPI.ItemRowType.with(stringValue: dictionary.parseString(forKey: goTapAPI.Constants.Key.ItemRowType))
		model.itemType = goTapAPI.ItemType.with(stringValue: dictionary.parseString(forKey: goTapAPI.Constants.Key.ItemType))
		model.lastUpdatedOn = dictionary.parseDate(forKey: goTapAPI.Constants.Key.LastUpdatedOn)
		model.linkedAccountDescription = dictionary.parseString(forKey: goTapAPI.Constants.Key.LinkedAccDesc)
		model.listName = parsedListName
		model.isLinkedItem = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.LinkedItems) ?? false
		model.isMyListItem = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.MyList) ?? false
		model.productID = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.PrdID) ?? 0
		model.productImageURL = dictionary.parseURL(forKey: goTapAPI.Constants.Key.PrdImage)
		model.remarks = dictionary.parseString(forKey: goTapAPI.Constants.Key.Remarks)
		model.status = goTapAPI.ItemStatus.with(stringValue: dictionary.parseString(forKey: goTapAPI.Constants.Key.Status))
		model.minimalCustomAmount = dictionary.parseAmount(forKey: goTapAPI.Constants.Key.MinAmount) ?? Foundation.Decimal.zero
		model.maximalCustomAmount = dictionary.parseAmount(forKey: goTapAPI.Constants.Key.MaxAmount) ?? Foundation.Decimal.zero
		model.scheduleDay = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.schedule_day) ?? 1

		return model.tap_asSelf()
	}

	public func Equals(object: AnyObject?) -> Swift.Bool {

		guard let otherObject = object as? goTapAPI.HomeItem else { return false }

		return ( otherObject.identifier == identifier &&
				 otherObject.businessID == businessID )
	}

	/**
	 Comparison method.

	 - parameter other: AnyObject to compare to.

	 - returns: NSComparisonResult.
	 */
	public func compare(other: goTapAPI.HomeItem) -> goTapAPI.ComparisonResult {

		let dateResult = goTapAPI.ComparisonResult.with(intValue: date.CompareTo(other.date))
		if dateResult != goTapAPI.ComparisonResult.OrderedSame {

			return dateResult
		}

		return compareByTitle(other)
	}

	/**
	 Compares items by display title.

	 - parameter other: AnyObject to compare to.

	 - returns: NSComparisonResult.
	 */
	public func compareByTitle(_ other: goTapAPI.HomeItem) -> goTapAPI.ComparisonResult {

		return goTapAPI.ComparisonResult.with(intValue: listName.CompareToIgnoreCase(other.listName))
	}

	/**
	 Compares items by group item order by field.

	 - parameter other: AnyObject to compare to.

	 - returns: NSComparisonResult.
	 */
	public func compareByGroupItemOrderBy(other: goTapAPI.HomeItem) -> goTapAPI.ComparisonResult {

		return goTapAPI.IntExtension.compare(first: groupItemOrderBy, toOther: other.groupItemOrderBy)
	}

	/**
	 Compares items by item order by field.

	 - parameter other: AnyObject to compare to.

	 - returns: NSComparisonResult.
	 */
	public func compareByItemOrderBy(other: goTapAPI.HomeItem!) -> goTapAPI.ComparisonResult {

		return goTapAPI.IntExtension.compare(first: itemOrderBy, toOther: other.itemOrderBy)
	}

	public func paymentAmount() -> Foundation.Decimal {

		return self.amount
	}

	public func paymentBusinessID() -> Int64 {

		return self.businessID
	}

	public func paymentName() -> String {

		return self.listName
	}

	public func paymentCurrencyCode() -> String {

		return self.payCurrencyCode
	}

	public func paymentProductImageURL() -> URL? {

		return self.productImageURL
	}

	public func paymentSerializedModel() -> AnyObject {

		return changedDetails.serializedModel ?? NSNull()
	}
}
