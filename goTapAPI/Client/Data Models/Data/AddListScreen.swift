//
//  AddListScreen.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 1/28/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Add List Screen.
public class AddListScreen: DataModel {
	
	//MARK: - Public -
	//MARK: Properties
	
	/// Available screens ID.
	public private(set) var screenID: AddToListScreen = AddToListScreen.None
	
	/// Default screen ID.
	public private(set) var defaultScreenID: AddToListScreen = AddToListScreen.None
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? AddListScreen else { return nil }
		
		guard let screenIDNumber = dictionary.parseInteger(forKey: Constants.Key.ID) else { return nil }
		guard let defaultScreenIDNumber = dictionary.parseInteger(forKey: Constants.Key.DefaultID) else { return nil }
		
		model.screenID = AddToListScreen(rawValue: screenIDNumber)
		model.defaultScreenID = AddToListScreen(rawValue: defaultScreenIDNumber)
		
		return model.tap_asSelf()
	}
}
