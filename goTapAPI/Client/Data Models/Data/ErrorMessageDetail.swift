//  ErrorMessageDetail.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/21/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Error message details model.
public class ErrorMessageDetail: DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Parameter name.
	public private(set) var parameterName: String!
	
	/// Parameter value.
	public private(set) var parameterValue: String!
	
	//MARK: - Internal -
	//MARK: Properties
	
	internal override var serializedModel: AnyObject? {
			
		var result: [String: Any] = [:]
			
		result[Constants.Key.ParamName] = self.parameterName
		result[Constants.Key.ParamValue] = self.parameterValue
			
		return result as AnyObject
	}
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
	
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? ErrorMessageDetail else { return nil }
		
		guard let nonnullParameterName = dictionary.parseString(forKey: Constants.Key.ParamName) else { return nil }
		guard let nonnullParameterValue = dictionary.parseString(forKey: Constants.Key.ParamValue) else { return nil }
		
		model.parameterName = nonnullParameterName
		model.parameterValue = nonnullParameterValue
		
		return model.tap_asSelf()
	}
}
