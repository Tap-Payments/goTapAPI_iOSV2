//
//  DetailedSector.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/21/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Detailed sector model.
public class DetailedSector: goTapAPI.Sector {

	//MARK: - Public -
	//MARK: Properties
	
	/// Parent model.
	public var sector: goTapAPI.Sector? {
		
		return goTapAPI.Sector(identifier: identifier, name: name)
	}
	
	/// Image URL.
	public private(set) var imageURL: URL?
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.DetailedSector else { return nil }
		
		model.imageURL = dictionary.parseURL(forKey: goTapAPI.Constants.Key.ImageURL)
		
		return model.tap_asSelf()
	}
	
	//required init?(coder aDecoder: NSCoder) {
		
		//super.init(coder: aDecoder)
		
		//imageURL = aDecoder.decodeObject(forKey: PITAPIImageURLKey) as? NSURL
	//}
	
	//override func encodeWithCoder(aCoder: NSCoder) {
		
		//super.encodeWithCoder(aCoder)
		
		//aCoder.encodeObject(imageURL, forKey: PITAPIImageURLKey)
	//}
	
	public required init() { super.init() }
}
