//
//  GetListResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/5/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Response model for Get List request.
public class GetListResponseModel: BadgedResponseModel {

	//MARK: - Public -
	//MARK: Properties

	/// Businesses.
	public private(set) var businesses: [BusinessItem] = []

	/// Home items.
	public private(set) var homeItems: [HomeItem] = []

	/// Groups.
	public private(set) var groups: [TPGroup] = []

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? GetListResponseModel else { return nil }

		let businessParsingClosure: (AnyObject) -> BusinessItem? = { object in

			return BusinessItem().dataModelWith(serializedObject: object)
		}
		let emptyBusinesses: [BusinessItem] = []
		let parsedBusinesses = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.Businesses), usingClosure: businessParsingClosure) ?? emptyBusinesses

		let groupParsingClosure: (AnyObject) -> TPGroup? = { object in

			return TPGroup().dataModelWith(serializedObject: object)
		}

		let emptyGroups: [TPGroup] = []
		let parsedGroups = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.Groups), usingClosure: groupParsingClosure) ?? emptyGroups

		let homeItemParsingClosure: (AnyObject) -> HomeItem? = { object in

			return HomeItem().dataModelWith(serializedObject: object)
		}

		let emptyItems: [HomeItem] = []
		let parsedHomeItems = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.HomeItems), usingClosure: homeItemParsingClosure) ?? emptyItems

		model.businesses = parsedBusinesses
		model.groups = parsedGroups
		model.homeItems = parsedHomeItems

		return model.tap_asSelf()
	}
}
