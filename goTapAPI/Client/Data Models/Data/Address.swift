//
//  Address.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Address data model.
public class Address: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Additional info.
	public private(set) var additionalInfo: String?
	
	/// Address 1.
	public private(set) var address1: String?
	
	/// Address 2.
	public private(set) var address2: String?
	
	/// Apartment.
	public private(set) var apartment: String?
	
	/// Area.
	public private(set) var area: String?
	
	/// Avenue.
	public private(set) var avenue: String?
	
	/// Block.
	public private(set) var block: String?
	
	/// Building.
	public private(set) var building: String?
	
	/// City.
	public private(set) var city: String?
	
	/// Country.
	public private(set) var country: String?
	
	/// Floor.
	public private(set) var floor: String?
	
	/// Governarate.
	public private(set) var governarate: String?
	
	/// Postal box.
	public private(set) var postalBox: String?
	
	/// Postal code.
	public private(set) var postalCode: String?
	
	/// State.
	public private(set) var state: String?
	
	/// State and ZIP.
	public private(set) var stateAndZip: String?
	
	/// Street.
	public private(set) var street: String?
	
	/// ZIP code.
	public private(set) var zipCode: String?
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.Address else { return nil }
		
		model.additionalInfo = dictionary.parseString(forKey: goTapAPI.Constants.Key.AdditionalInfo)
		model.address1 = dictionary.parseString(forKey: goTapAPI.Constants.Key.Address1)
		model.address2 = dictionary.parseString(forKey: goTapAPI.Constants.Key.Address2)
		model.apartment = dictionary.parseString(forKey: goTapAPI.Constants.Key.Apartment)
		model.area = dictionary.parseString(forKey: goTapAPI.Constants.Key.Area)
		model.avenue = dictionary.parseString(forKey: goTapAPI.Constants.Key.Avenue)
		model.block = dictionary.parseString(forKey: goTapAPI.Constants.Key.Block)
		model.building = dictionary.parseString(forKey: goTapAPI.Constants.Key.Building)
		model.city = dictionary.parseString(forKey: goTapAPI.Constants.Key.City)
		model.country = dictionary.parseString(forKey: goTapAPI.Constants.Key.Country)
		model.floor = dictionary.parseString(forKey: goTapAPI.Constants.Key.Floor)
		model.governarate = dictionary.parseString(forKey: goTapAPI.Constants.Key.Governarate)
		model.postalBox = dictionary.parseString(forKey: goTapAPI.Constants.Key.POBox)
		model.postalCode = dictionary.parseString(forKey: goTapAPI.Constants.Key.PostalCode)
		model.state = dictionary.parseString(forKey: goTapAPI.Constants.Key.State)
		model.stateAndZip = dictionary.parseString(forKey: goTapAPI.Constants.Key.StateAndZip)
		model.street = dictionary.parseString(forKey: goTapAPI.Constants.Key.Street)
		model.zipCode = dictionary.parseString(forKey: goTapAPI.Constants.Key.ZipCode)
		
		return model.tap_asSelf()
	}
}
