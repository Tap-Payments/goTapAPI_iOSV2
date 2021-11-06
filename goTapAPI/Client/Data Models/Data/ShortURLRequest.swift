//
//  ShortURLRequest.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/28/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Short URL request model.
public class ShortURLRequest: DataModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Medium.
	public private(set) var medium: SharingOption = SharingOption.Mail
	
	/// Request purpose.
	public private(set) var purpose: Purpose = Purpose.Video
	
	/// Parameters.
	public private(set) var params: String?
	
	internal override var serializedModel: AnyObject? {
		
		var result: [String: Any] = [
		
			Constants.Key.Medium: medium.stringRepresentation,
			Constants.Key.Purpose: purpose.stringRepresentation
		]
		
		result.setNullable(value: params, forKey: Constants.Key.Params)
		
		return result as AnyObject
	}
	
	//MARK: Methods
	
	public required init() { super.init() }
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? ShortURLRequest else { return nil }
		
		model.medium = SharingOption.with(stringValue: dictionary.parseString(forKey: Constants.Key.Medium))
		model.purpose = Purpose.with(stringValue: dictionary.parseString(forKey: Constants.Key.Purpose))
		model.params = dictionary.parseString(forKey: Constants.Key.Params)
		
		return model.tap_asSelf()
	}
	
	/**
	 Initializes data model with medium, purpose and parameters.
	 
	 - parameter medium:  Medium.
	 - parameter purpose: Purpose.
	 - parameter params:  Parameters.
	 
	 - returns: TPAPIShortURLRequest.
	 */
	internal init(medium: SharingOption, purpose: Purpose, params: String?) {
	
		super.init()
	
		self.medium = medium
		self.purpose = purpose
		self.params = params
	}
}
