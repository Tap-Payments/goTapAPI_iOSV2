//
//  ItemHeader.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/28/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Item header data model.
public class ItemHeader: DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Identifier.
	public internal(set) var identifier: String?

	/// Header identifier.
	public internal(set) var headerID: String?

	/// Name.
	public internal(set) var name: String = String.tap_empty

	/// Order by.
	public internal(set) var orderBy: Int64 = 0

	/// Field type.
	public internal(set) var fieldType: HeaderFieldType = HeaderFieldType.label

	/// Images.
	public internal(set) var images: [ImageSource]?

	internal override var serializedModel: AnyObject? {

		let emptyArray: [ImageSource] = []
		let unserializedArray: [ImageSource] = images == nil ? emptyArray : images!
		let serializedImages = ParseHelper.serialize(array: unserializedArray)

		var result: [String: Any] = [

			Constants.Key.OrderBy: orderBy,
			Constants.Key.FieldType: fieldType.stringRepresentation
		]

		result[Constants.Key.ID] = identifier ?? NSNull()
		result[Constants.Key.HdrID] = headerID ?? NSNull()
		result[Constants.Key.Name] = name
		result[Constants.Key.Images] = serializedImages ?? NSNull()

		return result as AnyObject
	}

	//MARK: Methods

	public required init() { super.init() }

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? ItemHeader else { return nil }

		model.identifier = dictionary.parseString(forKey: Constants.Key.ID)
		model.headerID = dictionary.parseString(forKey: Constants.Key.HdrID)

		if model is DetailedItemHeader {

			model.name = dictionary.parseString(forKey:  Constants.Key.Name) ?? String.tap_empty
		}
		else {

			guard let headerName = dictionary.parseString(forKey:  Constants.Key.Name) else { return nil }
			model.name = headerName
		}

		model.orderBy = dictionary.parseInteger(forKey: Constants.Key.OrderBy) ?? 0
		model.fieldType = HeaderFieldType.with(stringValue: dictionary.parseString(forKey: Constants.Key.FieldType))

		let imagesParsingClosure: (AnyObject) -> ImageSource? = { object in

			return ImageSource().dataModelWith(serializedObject: object)
		}

		model.images = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.Images), usingClosure: imagesParsingClosure)

		return model.tap_asSelf()
	}

	//func copyWithZone(zone: NSZone) -> AnyObject {

		//let headerCopy = self.dynamicType.init()

		//headerCopy.identifier = identifier
		//headerCopy.headerID = headerID
		//headerCopy.name = name
		//headerCopy.orderBy = orderBy
		//headerCopy.fieldType = fieldType
		//headerCopy.images = images

		//return headerCopy
	//}

	public override func isEqual(_ object: Any?) -> Bool {

		guard let headerObject = object as? ItemHeader else { return false }

		guard identifier == headerObject.identifier else { return false }
		guard headerID == headerObject.headerID else { return false }
		guard name == headerObject.name else { return false }
		guard fieldType == headerObject.fieldType else { return false }

		return true
	}

	public func compare(other: ItemHeader!) -> ComparisonResult {

		return IntExtension.compare(first: orderBy, toOther: other.orderBy)
	}
}
