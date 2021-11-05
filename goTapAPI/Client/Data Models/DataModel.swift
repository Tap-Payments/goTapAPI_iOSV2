//
//  DataModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/14/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Base class for API data models.
public class DataModel: NSObject {

	//MARK: - Public -
	//MARK: Properties

	public var jsonString: String {

		var jString = String.tap_empty

		guard let serializedObject = self.storesOriginalObject ? _originalSerializedObject : self.serializedModel else { return jString }

		

		jString = (serializedObject as! NSObject).ToJson()

		

		return jString
	}

	internal var serializedModel: AnyObject? {

		let result: [String: Any] = [:]
		return result as AnyObject
	}

	//MARK: Methods

	public func with(jString: String) -> goTapAPI.DataModel? {

		var serObject: AnyObject? = nil

		

		serObject = NSObject.FromJson(string: jString)

		

		return self.dataModelWith(serializedObject: serObject)
	}

	internal func dataModelWith(serializedObject: Any?) -> Self? {

		if self.storesOriginalObject {

			self._originalSerializedObject = serializedObject as AnyObject?
		}

		return self
	}

	public required override init() { super.init() }

	

	internal private(set) var storesOriginalObject: Swift.Bool = false

	private var _originalSerializedObject: AnyObject?
}
