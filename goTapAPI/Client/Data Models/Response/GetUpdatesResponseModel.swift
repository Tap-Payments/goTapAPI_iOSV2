//
//  GetUpdatesResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/3/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Response model with application updates.
public class GetUpdatesResponseModel: ResponseModel {

	//MARK: - Public -
	//MARK: Properties

	/// Layer image updates.
	public private(set) var layerImageUpdates: [LayerImageUpdate] = []

	/// Active sectors.
	public private(set) var activeSectors: [DetailedSector] = []

	/// Future sectors.
	public private(set) var futureSectors: [DetailedSector] = []

	/// Greeting URL.
	public private(set) var greetingURL: URL?

	/// Defines if gender screen should be shown.
	public private(set) var requestGender: Swift.Bool = false

	/// Tutorials string mask.
	public private(set) var showTutorials: String?

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? GetUpdatesResponseModel else { return nil }

		let emptyImageUpdatesArray: [LayerImageUpdate] = []
		let layerImageUpdateParsingClosure: (AnyObject) -> LayerImageUpdate? = { object in

			return LayerImageUpdate().dataModelWith(serializedObject: object)
		}

		let parsedLayerImageUpdates: [LayerImageUpdate]? = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.LayerImgUpdates) ?? emptyImageUpdatesArray, usingClosure: layerImageUpdateParsingClosure)
		model.layerImageUpdates = parsedLayerImageUpdates == nil ? emptyImageUpdatesArray : parsedLayerImageUpdates!

		let emptySectorsArray: [DetailedSector] = []
		let sectorParsingClosure: (AnyObject) -> DetailedSector? = { object in

			return DetailedSector().dataModelWith(serializedObject: object)
		}

		let parsedActiveSectors: [DetailedSector]? = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.ActiveSectors) ?? emptySectorsArray, usingClosure: sectorParsingClosure)
		model.activeSectors = parsedActiveSectors == nil ? emptySectorsArray : parsedActiveSectors!

		let parsedFutureSectors: [DetailedSector]? = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.NewSectors) ?? emptySectorsArray, usingClosure: sectorParsingClosure)
		model.futureSectors = parsedFutureSectors == nil ? emptySectorsArray : parsedFutureSectors!

		model.greetingURL = dictionary.parseURL(forKey: Constants.Key.GreetingURL)
		model.showTutorials = dictionary.parseString(forKey: Constants.Key.ShowTutorials)
		model.requestGender = dictionary.parseBoolean(forKey: Constants.Key.RequestGender) ?? false

		return model.tap_asSelf()
	}
}
