//
//  HomeItem.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Home item data model.
public class HomeItem: DataModel, PaymentSerialization, ListIDRepresentable, ItemIDRepresentable {

	//MARK: - Public -
	//MARK: Properties

	/// Action.
	public private(set) var action: ItemAction = ItemAction.None

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
	public private(set) var itemRowType: ItemRowType = ItemRowType.None

	/// Item type.
	public private(set) var itemType: ItemType = ItemType.Static

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
	public private(set) var status: ItemStatus = ItemStatus.Failed

	/// Minimal custom amount.
	public private(set) var minimalCustomAmount: Foundation.Decimal = Foundation.Decimal.zero

	/// Maximal custom amount.
	public private(set) var maximalCustomAmount: Foundation.Decimal = Foundation.Decimal.zero

	/// Schedule day.
	public private(set) var scheduleDay: Int64 = 1

	/// Generated list ID of the item.
	public var listID: ListID {

		return ListID(number: self.identifier, type: self.itemType)
	}

	public var itemID: ItemID {

		return ItemID(businessID: self.businessID, identifier: self.identifier, itemType: self.itemType.stringRepresentation)
	}

	internal override var storesOriginalObject: Swift.Bool { return true }

	/// Data model with required fields to pay.
	internal var changedDetails: ChangedDetailsHomeItem! {

		return ChangedDetailsHomeItem(

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

		return status == ItemStatus.Active
	}

	/// Defines if item is paid.
	public var isPaid: Swift.Bool {

		return itemRowType == ItemRowType.Paid
	}

	//MARK: Methods

	public required init() { super.init() }

	public convenience init(group aGroup: TPGroup) {

		self.init()
		self.group = aGroup
	}

	public convenience init(identifier: Int64, type: ItemType) {

		self.init()

		self.identifier = identifier
		self.itemType = type
	}

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? HomeItem else { return nil }

		guard let parsedListName = dictionary.parseString(forKey: Constants.Key.LstName) else {

			return nil
		}

		guard parsedListName.Length > 0 else { return nil }

		if let parsedBusinessAccount = dictionary.parseString(forKey: Constants.Key.BizAcN) {

			model.businessAccount = parsedBusinessAccount
		}

		if let parsedDate = dictionary.parseDate(forKey: Constants.Key.Date) {

			model.date = parsedDate
		}

		if let parsedDueDate = dictionary.parseDate(forKey: Constants.Key.DueDate) {

			model.dueDate = parsedDueDate
		}

		if let parsedNextUpdateDate = dictionary.parseDate(forKey: Constants.Key.NextUpdateDate) {

			model.nextUpdateDate = parsedNextUpdateDate
		}

		if let parsedPaymentCurrencyCode = dictionary.parseString(forKey: Constants.Key.PayCurrCode) {

			model.payCurrencyCode = parsedPaymentCurrencyCode
		}

		if let parsedPaymentDescription = dictionary.parseString(forKey: Constants.Key.PayDesc) {

			model.paymentDescription = parsedPaymentDescription
		}

		if let parsedProductCurrencyCode = dictionary.parseString(forKey: Constants.Key.PrdCurrCode) {

			model.productCurrencyCode = parsedProductCurrencyCode
		}

		if let parsedProductDescription = dictionary.parseString(forKey: Constants.Key.PrdDesc) {

			model.productDescription = parsedProductDescription
		}

		model.action = ItemAction.with(stringValue: dictionary.parseString(forKey: Constants.Key.Action))
		model.amount = dictionary.parseAmount(forKey: Constants.Key.Amount) ?? Foundation.Decimal.zero
		model.businessID = dictionary.parseInteger(forKey: Constants.Key.BizID) ?? 0
		model.canBeDeleted = dictionary.parseBoolean(forKey: Constants.Key.CanDelete) ?? false
		model.shouldEnableAlert = dictionary.parseBoolean(forKey: Constants.Key.EnableAlert) ?? false
		model.groupID = dictionary.parseInteger(forKey: Constants.Key.GroupID) ?? 0
		model.groupItemOrderBy = dictionary.parseInteger(forKey: Constants.Key.GroupItemOrderBy) ?? 0
		model.identifier = dictionary.parseInteger(forKey: Constants.Key.ID) ?? 0
		model.itemOrderBy = dictionary.parseInteger(forKey: Constants.Key.ItemOrderBy) ?? 0
		model.itemRowType = ItemRowType.with(stringValue: dictionary.parseString(forKey: Constants.Key.ItemRowType))
		model.itemType = ItemType.with(stringValue: dictionary.parseString(forKey: Constants.Key.ItemType))
		model.lastUpdatedOn = dictionary.parseDate(forKey: Constants.Key.LastUpdatedOn)
		model.linkedAccountDescription = dictionary.parseString(forKey: Constants.Key.LinkedAccDesc)
		model.listName = parsedListName
		model.isLinkedItem = dictionary.parseBoolean(forKey: Constants.Key.LinkedItems) ?? false
		model.isMyListItem = dictionary.parseBoolean(forKey: Constants.Key.MyList) ?? false
		model.productID = dictionary.parseInteger(forKey: Constants.Key.PrdID) ?? 0
		model.productImageURL = dictionary.parseURL(forKey: Constants.Key.PrdImage)
		model.remarks = dictionary.parseString(forKey: Constants.Key.Remarks)
		model.status = ItemStatus.with(stringValue: dictionary.parseString(forKey: Constants.Key.Status))
		model.minimalCustomAmount = dictionary.parseAmount(forKey: Constants.Key.MinAmount) ?? Foundation.Decimal.zero
		model.maximalCustomAmount = dictionary.parseAmount(forKey: Constants.Key.MaxAmount) ?? Foundation.Decimal.zero
		model.scheduleDay = dictionary.parseInteger(forKey: Constants.Key.schedule_day) ?? 1

		return model.tap_asSelf()
	}

	public func Equals(object: AnyObject?) -> Swift.Bool {

		guard let otherObject = object as? HomeItem else { return false }

		return ( otherObject.identifier == identifier &&
				 otherObject.businessID == businessID )
	}

	/**
	 Comparison method.

	 - parameter other: AnyObject to compare to.

	 - returns: NSComparisonResult.
	 */
	public func compare(other: HomeItem) -> ComparisonResult {

		let dateResult = ComparisonResult.with(intValue: date.CompareTo(other.date))
		if dateResult != ComparisonResult.OrderedSame {

			return dateResult
		}

		return compareByTitle(other)
	}

	/**
	 Compares items by display title.

	 - parameter other: AnyObject to compare to.

	 - returns: NSComparisonResult.
	 */
	public func compareByTitle(_ other: HomeItem) -> ComparisonResult {

		return ComparisonResult.with(intValue: listName.CompareToIgnoreCase(other.listName))
	}

	/**
	 Compares items by group item order by field.

	 - parameter other: AnyObject to compare to.

	 - returns: NSComparisonResult.
	 */
	public func compareByGroupItemOrderBy(other: HomeItem) -> ComparisonResult {

		return IntExtension.compare(first: groupItemOrderBy, toOther: other.groupItemOrderBy)
	}

	/**
	 Compares items by item order by field.

	 - parameter other: AnyObject to compare to.

	 - returns: NSComparisonResult.
	 */
	public func compareByItemOrderBy(other: HomeItem!) -> ComparisonResult {

		return IntExtension.compare(first: itemOrderBy, toOther: other.itemOrderBy)
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
