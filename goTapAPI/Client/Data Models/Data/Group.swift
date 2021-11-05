//
//  Group.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/4/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Group data model.
public class TPGroup: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Group ID.
	public private(set) var groupID: Int64 = 0

	/// Group name.
	public private(set) var groupName: String = String.tap_empty

	/// Header attributes.
	public private(set) var headerAttributes: goTapAPI.HeaderAttributes = goTapAPI.HeaderAttributes()

	internal override var storesOriginalObject: Swift.Bool { return true }

	/// Selected items count in a group.
	public var selectedItemsCount: Int64 = 0

	/// Items in a group.
	public var items: [goTapAPI.HomeItem]?

	//MARK: Methods

	public required init() { super.init() }

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.TPGroup else { return nil }

		guard let groupIDNumber = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.GroupID) else { return nil }
		guard let groupNameString = dictionary.parseString(forKey: goTapAPI.Constants.Key.GroupName) else { return nil }
		guard let headerAttributesModel = goTapAPI.HeaderAttributes().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: goTapAPI.Constants.Key.HeaderAttributes) as AnyObject) else { return nil }

		model.groupID = groupIDNumber
		model.groupName = groupNameString
		model.headerAttributes = headerAttributesModel

		return model.tap_asSelf()
	}

	//required convenience init?(coder aDecoder: NSCoder) {

		//guard let decodedGroupName = aDecoder.decodeObject(forKey: PITAPIGroupNameKey) as? String else { return nil }
		//guard let decodedHeaderAttributes = aDecoder.decodeObject(forKey: PITAPIHeaderAttributesKey) as? TPAPIHeaderAttributes else { return nil }

		//self.init(identifier: aDecoder.decodeInteger(forKey: PITAPIGroupIDKey), name: decodedGroupName, attributes: decodedHeaderAttributes)
	//}

	//func encodeWithCoder(aCoder: NSCoder) {

		//aCoder.encodeInteger(groupID, forKey: PITAPIGroupIDKey)
		//aCoder.encodeObject(groupName, forKey: PITAPIGroupNameKey)
		//aCoder.encodeObject(headerAttributes, forKey: PITAPIHeaderAttributesKey)
	//}

	public override func isEqual(_ object: Any?) -> Bool {

		guard let otherGroup = object as? goTapAPI.TPGroup else { return false }

		return ( otherGroup.groupID == groupID &&
				 otherGroup.groupName == groupName &&
				 otherGroup.headerAttributes.isEqual(headerAttributes) )
	}

	func compare(other: goTapAPI.TPGroup) -> goTapAPI.ComparisonResult {

		return goTapAPI.IntExtension.compare(first: groupID, toOther: other.groupID)
	}

	//func copyWithZone(zone: NSZone) -> AnyObject {

		//let newGroup = TPAPIGroup(identifier: groupID, name: groupName, attributes: headerAttributes)
		//return newGroup
	//}

	internal init(identifier: Int64, name: String, attributes: goTapAPI.HeaderAttributes) {

		super.init()

		self.groupID = identifier
		self.groupName = name
		self.headerAttributes = attributes
	}
}
