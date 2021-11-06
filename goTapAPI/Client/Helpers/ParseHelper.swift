//
//  ParseHelper.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/27/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Helper class to parse objects.
internal class ParseHelper {

	//MARK: - Public -
	//MARK: Properties
	
	/// Date formatters.
	static let dateFormatters: [DateFormatter] = [
	
		DateFormatter.dateFormatterWith(localeIdentifier: Constants.Default.LocaleIdentifier, dateFormat: Constants.DateFormat.Format1),
		DateFormatter.dateFormatterWith(localeIdentifier: Constants.Default.LocaleIdentifier, dateFormat: Constants.DateFormat.Format2)
	]
	
	//MARK: Methods
	
	/**
	 Parses array of serialized objects into array of objects.
	 
	 - parameter serializedArray: Serialized array of objects.
	 - parameter closure:		 Deserialization closure.
	 
	 - returns: Deserialized array of objects.
	 */
	static func parse<T>(array serializedArray: [AnyObject]?, usingClosure closure: (AnyObject) -> T?) -> [T]? where T: DataModel {
	 
		guard let array = serializedArray else { return nil }
		
		var objects: [T] = []
		for serializedObject in array {
		 
			if let unserializedObject = closure(serializedObject) {
			 
				objects.append(unserializedObject)
			}
		}
		
		return objects
	}
	
	/**
	 Serializes array.
	 
	 - parameter unserializedArray: Array to serialize.
	 
	 - returns: Serialized array.
	 */
	static func serialize(array unserializedArray: Array<DataModel>?) -> [AnyObject]? {
		
		return serialize(array: unserializedArray, usingClosure: { (object) -> AnyObject? in
			
			return object.serializedModel!
		})
	}
	
	/**
	 Serializes array using given closure.
	 
	 - parameter unserializedArray: Array to serialize.
	 - parameter closure:		   Serializing closure
	 
	 - returns: Serialized array.
	 */
	static func serialize<T>(array unserializedArray: Array<T>?, usingClosure closure: (T) -> AnyObject?) -> [AnyObject]? where T: Any {
		
		guard unserializedArray != nil else { return nil }
		
		var objects: [AnyObject] = []
		for unserializedObject in unserializedArray! {
			
			if let serializedObject = closure(unserializedObject) {
				
				objects.append(serializedObject)
			}
		}
		
		return objects
	}
}
