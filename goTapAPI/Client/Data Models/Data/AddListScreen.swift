//
//  AddListScreen.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 1/28/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Add List Screen.
public class AddListScreen: goTapAPI.DataModel {
	
	//MARK: - Public -
	//MARK: Properties
	
	/// Available screens ID.
	public private(set) var screenID: goTapAPI.AddToListScreen = goTapAPI.AddToListScreen.None
	
	/// Default screen ID.
	public private(set) var defaultScreenID: goTapAPI.AddToListScreen = goTapAPI.AddToListScreen.None
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.AddListScreen else { return nil }
		
		guard let screenIDNumber = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.ID) else { return nil }
		guard let defaultScreenIDNumber = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.DefaultID) else { return nil }
		
		model.screenID = goTapAPI.AddToListScreen(rawValue: screenIDNumber)
		model.defaultScreenID = goTapAPI.AddToListScreen(rawValue: defaultScreenIDNumber)
		
		return model.tap_asSelf()
	}
}
