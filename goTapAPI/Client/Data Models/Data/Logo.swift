//
//  Logo.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/3/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Logo model.
public class Logo: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties
	
	internal override var storesOriginalObject: Swift.Bool { return true }
	
	/// Available screens to show the logo.
	public private(set) var screenID: Int64 = 0
	
	/// Business ID.
	public private(set) var businessID: Int64 = 0
	
	/// ISD number.
	public private(set) var isdNumber: Int64 = 0
	
	/// Logo ID.
	public private(set) var logoID: Int64 = 0
	
	/// Logo URL.
	public private(set) var url: URL?
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.Logo else { return nil }
	 
		guard let screenIDNumber = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.ScreenID) else { return nil }
		guard let businessIDNumber = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.BusinessID) else { return nil }
		guard let isdNumberNumber = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.ISDNmbr) else { return nil }
		guard let logoIDNumber = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.LogoID) else { return nil }
		guard let logoURL = dictionary.parseURL(forKey: goTapAPI.Constants.Key.LogoURL) else { return nil }
		
		model.screenID = screenIDNumber
		model.businessID = businessIDNumber
		model.isdNumber = isdNumberNumber
		model.logoID = logoIDNumber
		model.url = logoURL
		
		return model.tap_asSelf()
	}
	
	/**
	 Compares by Logo ID.
	 
	 - parameter other: Other Logo object.
	 
	 - returns: NSComparisonResult value.
	 */
	public func compareByLogoID(other: goTapAPI.Logo) -> goTapAPI.ComparisonResult {
		
		return goTapAPI.IntExtension.compare(first: logoID, toOther: other.logoID)
	}
}
