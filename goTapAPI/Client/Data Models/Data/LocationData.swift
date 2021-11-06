//
//  LocationData.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Location data model.
class LocationData: DataModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Country name.
	private(set) var countryName: String?
	
	/// City name.
	private(set) var city: String?
	
	/// Latitude.
	private(set) var latitude: String?
	
	/// Longitude.
	private(set) var longitude: String?
	
	override var serializedModel: AnyObject? {
		
		var result: [String: Any] = [:]
		
		result.setNullable(value: countryName, forKey: Constants.Key.CntryName)
		result.setNullable(value: city, forKey: Constants.Key.City)
		result.setNullable(value: latitude, forKey: Constants.Key.Latitude)
		result.setNullable(value: longitude, forKey: Constants.Key.Longitude)
		
		guard result.keys.count > 0 else { return nil }
		
		return result as AnyObject
	}
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? LocationData else { return nil }
		
		model.countryName = dictionary.parseString(forKey: Constants.Key.CntryName)
		model.city = dictionary.parseString(forKey: Constants.Key.City)
		model.latitude = dictionary.parseString(forKey: Constants.Key.Latitude)
		model.longitude = dictionary.parseString(forKey: Constants.Key.Longitude)
		
		return model.tap_asSelf()
	}
	
	/**
	 Initializes data model object with latitude and longitude.
	 
	 - parameter latitude:  Latitude.
	 - parameter longitude: Longitude.
	 
	 - returns: New instance of LocationData.
	 */
	internal init(location: Location) {
	 
		super.init()
		
		self.latitude = "\(location.latitude)"
		self.longitude = "\(location.longitude)"
	}
	
	public required init() { super.init() }
}
