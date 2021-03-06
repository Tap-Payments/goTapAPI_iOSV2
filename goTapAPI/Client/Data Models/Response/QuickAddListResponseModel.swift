//
//  QuickAddListResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/4/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Quick add list response model.
public class QuickAddListResponseModel: GetListResponseModel {
	
	//MARK: - Public -
	//MARK: Properties
	
	/// Screen.
	public var screen: QuickAddListResponseScreen = QuickAddListResponseScreen.Home
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? QuickAddListResponseModel else { return nil }
		
		model.screen = QuickAddListResponseScreen.with(stringValue: dictionary.parseString(forKey: Constants.Key.Screen))
		
		return model.tap_asSelf()
	}
}
