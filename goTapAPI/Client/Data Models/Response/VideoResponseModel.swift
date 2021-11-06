//
//  VideoResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 2/13/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Response model for video request operation.
public class VideoResponseModel: ResponseModel {
	
	//MARK: - Public -
	//MARK: Properties
	
	/// Video URLs.
	public private(set) var videoURLs: [String: URL] = [:]
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
	 
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? VideoResponseModel else { return nil }
		
		model.videoURLs = [:]
		
		for key in dictionary.keys {
			
			guard let url = dictionary.parseURL(forKey: key) else { continue }
			
			model.videoURLs[key] = url
		}
		
		return model.tap_asSelf()
	}
}
