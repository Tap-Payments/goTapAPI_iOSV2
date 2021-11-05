//
//  DetailedItemHeader.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/28/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Detailed item header model.
public class DetailedItemHeader: goTapAPI.ItemHeader {

	//MARK: - Public -
	//MARK: Properties

	/// Amount.
	public var amount: Foundation.Decimal = Foundation.Decimal.zero

	/// Defines if detailed header needs custom amount input.
	public private(set) var hasCustomAmount: Swift.Bool = false

	/// Header details ID.
	public internal(set) var headerDetailsID: String?

	/// Link ID.
	public internal(set) var linkID: String?

	/// Display value.
	public var displayValue: String?

	/// Header description.
	public internal(set) var headerDescription: String?

	/// Custom amount.
	public private(set) var customAmount: Foundation.Decimal = Foundation.Decimal.zero

	/// Defines if current detailed header is default.
	public internal(set) var isDefaultHeader: Swift.Bool = false

	/// Defines if detailed item header needs description to be shown.
	public private(set) var shouldShowDescription: Swift.Bool = false

	internal override var serializedModel: AnyObject? {

		guard var result = super.serializedModel as? [String: Any] else { return nil }

		result[goTapAPI.Constants.Key.Amount] = self.amount
		result[goTapAPI.Constants.Key.IsDefault] = self.isDefaultHeader
		result[goTapAPI.Constants.Key.HdrDtlID] = self.headerDetailsID ?? NSNull()
		result[goTapAPI.Constants.Key.LinkID] = self.linkID ?? NSNull()
		result[goTapAPI.Constants.Key.Display] = self.displayValue ?? NSNull()
		result[goTapAPI.Constants.Key.Description] = self.headerDescription ?? NSNull()

		return result as AnyObject
	}

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.DetailedItemHeader else { return nil }

		model.headerDetailsID = dictionary.parseString(forKey: goTapAPI.Constants.Key.HdrDtlID)
		model.amount = dictionary.parseAmount(forKey: goTapAPI.Constants.Key.Amount) ?? Foundation.Decimal.zero
		model.hasCustomAmount = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.HasCustomAmount) ?? false
		model.shouldShowDescription = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.IsDtldItem) ?? false
		model.linkID = dictionary.parseString(forKey: goTapAPI.Constants.Key.LinkID)
		model.displayValue = dictionary.parseString(forKey: goTapAPI.Constants.Key.Display)
		model.isDefaultHeader = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.IsDefault) ?? false

		return model.tap_asSelf()
	}

	//override func copyWithZone(zone: NSZone) -> AnyObject {

		//let detailedHeaderCopy = super.copyWithZone(zone) as! TPAPIDetailedItemHeader

		//detailedHeaderCopy.headerDetailsID = headerDetailsID
		//detailedHeaderCopy.amount = amount
		//detailedHeaderCopy.linkID = linkID
		//detailedHeaderCopy.displayValue = displayValue
		//detailedHeaderCopy.headerDescription = headerDescription
		//detailedHeaderCopy.isDefaultHeader = isDefaultHeader

		//return detailedHeaderCopy
	//}

	public override func isEqual(_ object: Any?) -> Bool {

		guard super.isEqual(object) else { return false }

		guard let headerObject = object as? goTapAPI.DetailedItemHeader else { return false }

		if amount != headerObject.amount { return false }
		if hasCustomAmount != headerObject.hasCustomAmount { return false }
		if !goTapAPI.StringExtension.equal(string1: headerDetailsID, string2: headerObject.headerDetailsID) { return false }
		if !goTapAPI.StringExtension.equal(string1: linkID, string2: headerObject.linkID) { return false }
		if !goTapAPI.StringExtension.equal(string1: displayValue, string2: headerObject.displayValue) { return false }
		if !goTapAPI.StringExtension.equal(string1: headerDescription, string2: headerObject.headerDescription) { return false }
		if customAmount != headerObject.customAmount { return false }
		if isDefaultHeader != headerObject.isDefaultHeader { return false }
		if shouldShowDescription != headerObject.shouldShowDescription { return false }

		return true
	}

	//MARK: - Private -
	//MARK: Methods

	public required init() { super.init() }
}
