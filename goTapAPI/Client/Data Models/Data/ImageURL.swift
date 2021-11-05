//
//  ImageURL.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/26/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Image URL data model.
public class ImageURL: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// URL.
	public private(set) var url: URL?
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.ImageURL else { return nil }
		guard let parsedUrl = dictionary.parseURL(forKey: goTapAPI.Constants.Key.Url) else { return nil }
		
		model.url = parsedUrl
		
		return model.tap_asSelf()
	}
	
	public required init() { super.init() }
	
	//required init?(coder aDecoder: NSCoder) {
		
		//guard let parsedUrl = aDecoder.decodeObject(forKey: PITAPIUrlKey) as? NSURL else { return nil }
		
		//super.init()
		
		//url = parsedUrl
	//}
	
	//func encodeWithCoder(aCoder: NSCoder) {
		
		//aCoder.encodeObject(url, forKey: PITAPIUrlKey)
	//}
}
