//
//  Dictionary+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/28/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//







/// Useful Dictionary extension.
public extension Swift.Dictionary where Key: Swift.CustomStringConvertible, Value: Any {

	//MARK: - Public -
	//MARK: Methods

	internal mutating func setNullable(value nullableValue: Any?, forKey key: String) {

		guard nullableValue != nil else { return }

		self[key as! Key] = (nullableValue as! Value)
	}

	/**
	 Parses string for a given key.

	 - parameter key: Key.

	 - returns: String or nil if key was not found, or object is not a string.
	 */
	public func parseString(forKey key: String) -> String? {

		if let stringValue = self.stringDictionary[key] as? String {

			return stringValue
		}
		else if let doubleValue = self.parseDouble(forKey: key) {

			return "\(doubleValue)"
		}
		else if let integerValue = self.parseInteger(forKey: key) {

			return "\(integerValue)"
		}

		return nil
	}

	/**
	 Parses Url for a given key.

	 - parameter key: Key.

	 - returns: Url or nil if key was not found, or object is not an Url.
	 */
	public func parseURL(forKey key: String) -> URL? {

		guard let value = self.stringDictionary[key] else { return nil }

		if let stringValue = value as? String {

			return goTapAPI.UrlExtension.with(string: stringValue)
		}
		else if let urlValue = value as? URL {

			return urlValue
		}
		else {

			return nil
		}
	}

	/**
	 Parses integer for a given key.

	 - parameter key: Key.

	 - returns: Integer or nil if key was not found, or object is not Int.
	 */
	public func parseInteger(forKey key: String) -> Int64? {

		guard let value = self.stringDictionary[key] else { return nil }

		if let stringValue = value as? String {

			return (stringValue as NSString).longLongValue
		}
		else if let integerValue = value as? Int64 {

			return integerValue
		}
		
		else if let numberValue = value as? Foundation.NSNumber {

			return numberValue.int64Value
		}
		
		else {

			return nil
		}
	}

	/**
	 Parses double for a given key.

	 - parameter key: Key.

	 - returns: double or nil if key was not found, or object is not a double.
	 */
	public func parseDouble(forKey key: String) -> Double? {

		guard let value = self.stringDictionary[key] else { return nil }

		if let stringValue = value as? String {

			return ((stringValue) as NSString).doubleValue
		}
		else if let doubleValue = value as? Double {

			return doubleValue
		}
		
		else if let numberValue = value as? Foundation.NSNumber {

			return numberValue.doubleValue
		}
		
		else {

			return nil
		}
	}

	public func parseAmount(forKey key: String) -> Foundation.Decimal? {

		guard let value = self.stringDictionary[key] else { return nil }

		if let stringValue = value as? String {

			return Foundation.Decimal(string: stringValue)
		}
		else if let doubleValue = self.parseDouble(forKey: key) {

			return Foundation.Decimal(doubleValue)
		}
		else {

			return nil
		}
	}

	/**
	 Parses bool for a given key.

	 - parameter key: Key.

	 - returns: bool or nil if key was not found, or object is not a bool.
	 */
	public func parseBoolean(forKey key: String) -> Swift.Bool? {

		guard let value = self.stringDictionary[key] else { return nil }

		if let stringValue = value as? String {

			return (stringValue as NSString).boolValue
		}
		else if let boolValue = value as? Swift.Bool {

			return boolValue
		}
		else {

			return nil
		}
	}

	/**
	 Parses date for a given key.

	 - parameter key: Key.

	 - returns: NSDate or nil if key was not found, or object cannot be mapped to NSDate.
	 */
	public func parseDate(forKey key: String) -> Date? {

		guard let value = self.parseString(forKey: key) else { return nil }

		var date: Date? = nil

		for dateFormatter in goTapAPI.ParseHelper.dateFormatters {

			if let parsedDate = dateFormatter.date(from: value) {

				date = parsedDate
				break
			}
		}

		return date
	}

	/**
	 Parses color for a given key.

	 - parameter key: Key.

	 - returns: Color or nil if key was not found, or object cannot be mapped to Color.
	 */
	public func parseColor(forKey key: String) -> TPColor? {

		guard let value = self.parseString(forKey: key) else { return nil }

		return TPColor.colorWith(value)
	}

	/**
	 Parses array for a given key.

	 - parameter key: Key.

	 - returns: Array or nil if key was not found, or object is not an array.
	 */
	public func parseArray(forKey key: String) -> [AnyObject]? {

		guard let value = self.stringDictionary[key] else { return nil }

		guard let array = value as? [AnyObject] else { return nil }

		return array
	}

	/**
	 Parses dictionary for a given key.

	 - parameter key: Key.

	 - returns: Dictionary or nil if key was not found, or object is not a dictionary.
	 */
	public func parseDictionary(forKey key: String) -> Swift.Dictionary<String, Any>? {

		guard let value = self.stringDictionary[key] else { return nil }

		guard let dictionary = value as? Swift.Dictionary<String, Any> else { return nil }

		return dictionary
	}

	
	

	//MARK: - Private -
	//MARK: Properties

	private var stringDictionary: Swift.Dictionary<String, AnyObject> {

		return (self as AnyObject) as! Swift.Dictionary<String, AnyObject>
	}
}