//
//  BusinessItem.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/2/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Business item model.
public class BusinessItem: DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Currency code.
	public private(set) var currencyCode: String = String.tap_empty

	/// Sector image URL.
	public var sectorImageURL: URL? {

		return UrlExtension.with(string: sectorImageURLString)
	}

	/// Vendor ID.
	public private(set) var vendorID: Int64 = 0

	/// Vendor image URL.
	public var vendorImageURL: URL? {

		return UrlExtension.with(string: vendorImageURLString)
	}

	/// Vendor name.
	public private(set) var vendorName: String = String.tap_empty

	internal override var storesOriginalObject: Swift.Bool { return true }

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? BusinessItem else { return nil }

		guard let currencyCodeString = dictionary.parseString(forKey: Constants.Key.CurrencyCD) else { return nil }
		guard let vendorIDNumber = dictionary.parseInteger(forKey: Constants.Key.VndID) else { return nil }
		guard let vendorNameString = dictionary.parseString(forKey: Constants.Key.VndName) else { return nil }

		model.currencyCode = currencyCodeString
		model.vendorID = vendorIDNumber
		model.vendorName = vendorNameString
		model.sectorImageURLString = dictionary.parseString(forKey: Constants.Key.SctrImage)
		model.vendorImageURLString = dictionary.parseString(forKey: Constants.Key.VndImage)

		return model.tap_asSelf()
	}

	//required init?(coder aDecoder: NSCoder) {

		//currencyCode = aDecoder.decodeObject(forKey: PITAPICurrencyCDKey) as? String
		//sectorImageURL = aDecoder.decodeObject(forKey: PITAPISectorImageKey) as? NSURL
		//vendorID = aDecoder.decodeInteger(forKey: PITAPIVendorIDKey)
		//vendorImageURL = aDecoder.decodeObject(forKey: PITAPIVendorImageKey) as? NSURL
		//vendorName = aDecoder.decodeObject(forKey: PITAPIVendorNameKey) as? String

		//super.init()
	//}

	//func encodeWithCoder(aCoder: NSCoder) {

		//aCoder.encodeObject(currencyCode, forKey: PITAPICurrencyCDKey)
		//aCoder.encodeObject(sectorImageURL, forKey: PITAPISectorImageKey)
		//aCoder.encodeInteger(vendorID, forKey: PITAPIVendorIDKey)
		//aCoder.encodeObject(vendorImageURL, forKey: PITAPIVendorImageKey)
		//aCoder.encodeObject(vendorName, forKey: PITAPIVendorNameKey)
	//}

	public override func isEqual(_ object: Any?) -> Bool {

		guard let otherBusiness = object as? BusinessItem else { return false }

		return ( currencyCode == otherBusiness.currencyCode &&
				 StringExtension.equal(string1: sectorImageURLString, string2: otherBusiness.sectorImageURLString) &&
				 vendorID == otherBusiness.vendorID &&
				 StringExtension.equal(string1: vendorImageURLString, string2: otherBusiness.vendorImageURLString) &&
				 vendorName == otherBusiness.vendorName )
	}

	//MARK: - Private -
	//MARK: Properties

	private var sectorImageURLString: String?
	private var vendorImageURLString: String?
}
