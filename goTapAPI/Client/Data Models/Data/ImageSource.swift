//
//  ImageSource.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/29/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Image source model.
public class ImageSource: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Image source identifier.
	public private(set) var identifier: String?
	
	/// Small image URL.
	public var smallImageURL: URL? {
	 
		return goTapAPI.UrlExtension.with(string: smallImageURLString) 
	}
	
	/// Normal image URL.
	public var normalImageURL: URL? {
		
		return goTapAPI.UrlExtension.with(string: normalImageURLString)
	}
	
	/// Icon URL.
	public var iconURL: URL? {
	 
		return goTapAPI.UrlExtension.with(string: iconURLString)
	}
	
	internal override var serializedModel: AnyObject? {
		
		var result: [String: Any] = [:]
		
		result[goTapAPI.Constants.Key.ID] = identifier ?? NSNull()
		result[goTapAPI.Constants.Key.SmallImg] = smallImageURLString ?? NSNull()
		result[goTapAPI.Constants.Key.NormalImg] = normalImageURLString ?? NSNull()
		result[goTapAPI.Constants.Key.Icon] = iconURLString ?? NSNull()
		
		return result as AnyObject
	}
	
	//MARK: Methods
	
	public required init() { super.init() }
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.ImageSource else { return nil }
		
		model.identifier = dictionary.parseString(forKey: goTapAPI.Constants.Key.ID)
		model.smallImageURLString = dictionary.parseString(forKey: goTapAPI.Constants.Key.SmallImg)
		model.normalImageURLString = dictionary.parseString(forKey: goTapAPI.Constants.Key.NormalImg)
		model.iconURLString = dictionary.parseString(forKey: goTapAPI.Constants.Key.Icon)
		
		return model.tap_asSelf()
	}
	
	//MARK: - Private -
	//MARK: Properties
	
	private var smallImageURLString: String?
	private var normalImageURLString: String?
	private var iconURLString: String?
}
