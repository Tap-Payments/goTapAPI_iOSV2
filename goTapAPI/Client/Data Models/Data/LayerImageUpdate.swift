//
//  LayerImageUpdate.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/21/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Data model with layer image updates.
public class LayerImageUpdate: DataModel {
	
	//MARK: - Public -
	//MARK: Properties
	
	/// Layer index.
	public internal(set) var layerIndex: Int64 = 0
	
	/// Image URLs.
	public internal(set) var imageURLs: [ImageURL] = []
	
	/// Defines if layer is visible in registration.
	public internal(set) var visibleInRegistration: Swift.Bool = false
	
	/// Defines if layer is visible in My List.
	public internal(set) var visibleInMyList: Swift.Bool = false
	
	/// Updated date.
	public internal(set) var updatedDate: Date?
	
	internal override var storesOriginalObject: Swift.Bool { return true }
	
	//MARK: Methods
	
	public required init() { super.init() }
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? LayerImageUpdate else { return nil }
	 
		model.layerIndex = dictionary.parseInteger(forKey: Constants.Key.LayerIndex) ?? 0
		
		let imageURLParsingClosure: (AnyObject) -> ImageURL? = { object in
		
			return ImageURL().dataModelWith(serializedObject: object)
		}
		
		let emptyImageURLs: [ImageURL] = []
		let serializedImageURLs = dictionary.parseArray(forKey: Constants.Key.ImageUrls) ?? emptyImageURLs
		let parsedImageURLs: [ImageURL]? = ParseHelper.parse(array: serializedImageURLs, usingClosure: imageURLParsingClosure)
		model.imageURLs = parsedImageURLs == nil ? emptyImageURLs : parsedImageURLs!
	 
		model.visibleInRegistration = dictionary.parseBoolean(forKey: Constants.Key.VisibleInRegistration) ?? false
		model.visibleInMyList = dictionary.parseBoolean(forKey: Constants.Key.VisibleInMyList) ?? false
		model.updatedDate = dictionary.parseDate(forKey: Constants.Key.UpdatedDate)
		
		return model.tap_asSelf()
	}
}
