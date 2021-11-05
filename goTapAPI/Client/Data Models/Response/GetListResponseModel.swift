//
//  GetListResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/5/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Response model for Get List request.
public class GetListResponseModel: goTapAPI.BadgedResponseModel {

	//MARK: - Public -
	//MARK: Properties

	/// Businesses.
	public private(set) var businesses: [goTapAPI.BusinessItem] = []

	/// Home items.
	public private(set) var homeItems: [goTapAPI.HomeItem] = []

	/// Groups.
	public private(set) var groups: [goTapAPI.TPGroup] = []

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.GetListResponseModel else { return nil }

		let businessParsingClosure: (AnyObject) -> goTapAPI.BusinessItem? = { object in

			return goTapAPI.BusinessItem().dataModelWith(serializedObject: object)
		}
		let emptyBusinesses: [goTapAPI.BusinessItem] = []
		let parsedBusinesses = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.Businesses), usingClosure: businessParsingClosure) ?? emptyBusinesses

		let groupParsingClosure: (AnyObject) -> goTapAPI.TPGroup? = { object in

			return goTapAPI.TPGroup().dataModelWith(serializedObject: object)
		}

		let emptyGroups: [goTapAPI.TPGroup] = []
		let parsedGroups = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.Groups), usingClosure: groupParsingClosure) ?? emptyGroups

		let homeItemParsingClosure: (AnyObject) -> goTapAPI.HomeItem? = { object in

			return goTapAPI.HomeItem().dataModelWith(serializedObject: object)
		}

		let emptyItems: [goTapAPI.HomeItem] = []
		let parsedHomeItems = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.HomeItems), usingClosure: homeItemParsingClosure) ?? emptyItems

		model.businesses = parsedBusinesses
		model.groups = parsedGroups
		model.homeItems = parsedHomeItems

		return model.tap_asSelf()
	}
}
