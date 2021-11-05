//
//  ShortURLRequest.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/28/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Short URL request model.
public class ShortURLRequest: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Medium.
	public private(set) var medium: goTapAPI.SharingOption = goTapAPI.SharingOption.Mail
	
	/// Request purpose.
	public private(set) var purpose: goTapAPI.Purpose = goTapAPI.Purpose.Video
	
	/// Parameters.
	public private(set) var params: String?
	
	internal override var serializedModel: AnyObject? {
		
		var result: [String: Any] = [
		
			goTapAPI.Constants.Key.Medium: medium.stringRepresentation,
			goTapAPI.Constants.Key.Purpose: purpose.stringRepresentation
		]
		
		result.setNullable(value: params, forKey: goTapAPI.Constants.Key.Params)
		
		return result as AnyObject
	}
	
	//MARK: Methods
	
	public required init() { super.init() }
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.ShortURLRequest else { return nil }
		
		model.medium = goTapAPI.SharingOption.with(stringValue: dictionary.parseString(forKey: goTapAPI.Constants.Key.Medium))
		model.purpose = goTapAPI.Purpose.with(stringValue: dictionary.parseString(forKey: goTapAPI.Constants.Key.Purpose))
		model.params = dictionary.parseString(forKey: goTapAPI.Constants.Key.Params)
		
		return model.tap_asSelf()
	}
	
	/**
	 Initializes data model with medium, purpose and parameters.
	 
	 - parameter medium:  Medium.
	 - parameter purpose: Purpose.
	 - parameter params:  Parameters.
	 
	 - returns: TPAPIShortURLRequest.
	 */
	internal init(medium: goTapAPI.SharingOption, purpose: goTapAPI.Purpose, params: String?) {
	
		super.init()
	
		self.medium = medium
		self.purpose = purpose
		self.params = params
	}
}
