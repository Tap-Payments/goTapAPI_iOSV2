//
//  GetUpdatesResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/3/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Response model with application updates.
public class GetUpdatesResponseModel: goTapAPI.ResponseModel {

	//MARK: - Public -
	//MARK: Properties

	/// Layer image updates.
	public private(set) var layerImageUpdates: [goTapAPI.LayerImageUpdate] = []

	/// Active sectors.
	public private(set) var activeSectors: [goTapAPI.DetailedSector] = []

	/// Future sectors.
	public private(set) var futureSectors: [goTapAPI.DetailedSector] = []

	/// Greeting URL.
	public private(set) var greetingURL: URL?

	/// Defines if gender screen should be shown.
	public private(set) var requestGender: Swift.Bool = false

	/// Tutorials string mask.
	public private(set) var showTutorials: String?

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.GetUpdatesResponseModel else { return nil }

		let emptyImageUpdatesArray: [goTapAPI.LayerImageUpdate] = []
		let layerImageUpdateParsingClosure: (AnyObject) -> goTapAPI.LayerImageUpdate? = { object in

			return goTapAPI.LayerImageUpdate().dataModelWith(serializedObject: object)
		}

		let parsedLayerImageUpdates: [goTapAPI.LayerImageUpdate]? = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.LayerImgUpdates) ?? emptyImageUpdatesArray, usingClosure: layerImageUpdateParsingClosure)
		model.layerImageUpdates = parsedLayerImageUpdates == nil ? emptyImageUpdatesArray : parsedLayerImageUpdates!

		let emptySectorsArray: [goTapAPI.DetailedSector] = []
		let sectorParsingClosure: (AnyObject) -> goTapAPI.DetailedSector? = { object in

			return goTapAPI.DetailedSector().dataModelWith(serializedObject: object)
		}

		let parsedActiveSectors: [goTapAPI.DetailedSector]? = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.ActiveSectors) ?? emptySectorsArray, usingClosure: sectorParsingClosure)
		model.activeSectors = parsedActiveSectors == nil ? emptySectorsArray : parsedActiveSectors!

		let parsedFutureSectors: [goTapAPI.DetailedSector]? = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.NewSectors) ?? emptySectorsArray, usingClosure: sectorParsingClosure)
		model.futureSectors = parsedFutureSectors == nil ? emptySectorsArray : parsedFutureSectors!

		model.greetingURL = dictionary.parseURL(forKey: goTapAPI.Constants.Key.GreetingURL)
		model.showTutorials = dictionary.parseString(forKey: goTapAPI.Constants.Key.ShowTutorials)
		model.requestGender = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.RequestGender) ?? false

		return model.tap_asSelf()
	}
}
