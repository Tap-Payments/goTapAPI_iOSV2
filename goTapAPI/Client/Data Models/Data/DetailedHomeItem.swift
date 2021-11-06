//
//  DetailedHomeItem.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/5/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Detailed home item data model.
public class DetailedHomeItem: HomeItem {

	//MARK: - Public -
	//MARK: Properties

	/// Item ID.
	public private(set) var itemIdentifier: String = String.tap_empty

	/// Detailed title.
	public private(set) var detailedTitle: String = String.tap_empty

	/// Detailed description.
	public private(set) var detailedDescription: String = String.tap_empty

	/// Select option.
	public private(set) var selectOption: String?

	/// Message.
	public private(set) var message: String?

	/// Images.
	public private(set) var images: [ImageSource] = []

	/// Item headers.
	public private(set) var itemHeaders: [ItemHeader] = []

	/// Item header details.
	public private(set) var itemHeaderDetails: [DetailedItemHeader] = []

	/// Business theme URL.
	public private(set) var businessThemeURL: URL?

	/// Defines if the number is a primary number.
	public private(set) var isPrimaryNumber: Swift.Bool = false

	/// Model with details to get the balance.
	public private(set) var getBalance: GetBalance?

	/// Schedule settings.
	public private(set) var scheduleSettings: ScheduleSettings?

	internal override var storesOriginalObject: Swift.Bool { return true }

	//MARK: Methods

	public required init() { super.init() }

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }

		//writeLn("parsing detailed home item from dict: \n\(dictionary)")

		guard let model = super.dataModelWith(serializedObject: serializedObject) as? DetailedHomeItem else { return nil }

		//writeLn("home item parsed successfully ( parent object for detailed home item )")

		if let deserializedItemIdentifier = dictionary.parseString(forKey: Constants.Key.ItemID) {

			model.itemIdentifier = deserializedItemIdentifier
		}

		if let deserializedDetailedTitle = dictionary.parseString(forKey: Constants.Key.DtlTitle) {

			model.detailedTitle = deserializedDetailedTitle
		}

		if let deserializedDetailedDescription = dictionary.parseString(forKey: Constants.Key.DtlDesc) {

			model.detailedDescription = deserializedDetailedDescription
		}

		model.selectOption = dictionary.parseString(forKey: Constants.Key.SelectOption)
		model.message = dictionary.parseString(forKey: Constants.Key.Msg)

		let emptyImages: [ImageSource] = []
		let imageParsingClosure: (AnyObject) -> ImageSource? = { object in

			return ImageSource().dataModelWith(serializedObject: object)
		}
		let parsedImages = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.Images), usingClosure: imageParsingClosure)

		let emptyHeaders: [ItemHeader] = []
		let headerParsingClosure: (AnyObject) -> ItemHeader? = { object in

			return ItemHeader().dataModelWith(serializedObject: object)
		}
		let parsedItemHeaders = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.ItemHdrs), usingClosure: headerParsingClosure)

		let emptyHeaderDetails: [DetailedItemHeader] = []
		let headerDetailsParsingClosure: (AnyObject) -> DetailedItemHeader? = { object in

			return DetailedItemHeader().dataModelWith(serializedObject: object)
		}
		let parsedItemHeaderDetails = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.IItemHdrDtls), usingClosure: headerDetailsParsingClosure)

		model.images = parsedImages == nil ? emptyImages : parsedImages!
		model.itemHeaders = parsedItemHeaders == nil ? emptyHeaders : parsedItemHeaders!
		model.itemHeaderDetails = parsedItemHeaderDetails == nil ? emptyHeaderDetails : parsedItemHeaderDetails!

		model.businessThemeURL = dictionary.parseURL(forKey: Constants.Key.BuiThemeUrl)

		model.isPrimaryNumber = dictionary.parseBoolean(forKey: Constants.Key.is_primary_number) ?? false

		model.getBalance = GetBalance().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: Constants.Key.get_balance) as AnyObject)

		model.scheduleSettings = ScheduleSettings().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: Constants.Key.schedule_setting) as AnyObject)

		return model.tap_asSelf()
	}

	//required init?(coder aDecoder: NSCoder) {

		//guard let parsedItemID = aDecoder.decodeObject(forKey: PITAPIItemIDKey) as? String else { return nil }
		//guard let parsedDetailedTitle = aDecoder.decodeObject(forKey: PITAPIDetailedTitleKey) as? String else { return nil }
		//guard let parsedDetailedDescription = aDecoder.decodeObject(forKey: PITAPIDetailedDescriptionKey) as? String else { return nil }

		//super.init(coder: aDecoder)

		//itemID = parsedItemID
		//detailedTitle = parsedDetailedTitle
		//detailedDescription = parsedDetailedDescription
		//selectOption = aDecoder.decodeObject(forKey: PITAPISelectOptionKey) as? String
		//message = aDecoder.decodeObject(forKey: PITAPIMsgKey) as? String
		//images = aDecoder.decodeObject(forKey: PITAPIImagesKey) as? [TPAPIImageSource] ?? []
		//itemHeaders = aDecoder.decodeObject(forKey: PITAPIItemHeadersKey) as? [TPAPIItemHeader] ?? []
		//itemHeaderDetails = aDecoder.decodeObject(forKey: PITAPIItemHeaderDetailsKey) as? [TPAPIDetailedItemHeader] ?? []
		//businessThemeURL = aDecoder.decodeObject(forKey: PITAPIBusinessThemeURLKey) as? NSURL
	//}

	//override func encodeWithCoder(aCoder: NSCoder) {

		//super.encodeWithCoder(aCoder)

		//aCoder.encodeObject(itemID, forKey: PITAPIItemIDKey)
		//aCoder.encodeObject(detailedTitle, forKey: PITAPIDetailedTitleKey)
		//aCoder.encodeObject(detailedDescription, forKey: PITAPIDetailedDescriptionKey)
		//aCoder.encodeObject(selectOption, forKey: PITAPISelectOptionKey)
		//aCoder.encodeObject(message, forKey: PITAPIMsgKey)
		//aCoder.encodeObject(images, forKey: PITAPIImagesKey)
		//aCoder.encodeObject(itemHeaders, forKey: PITAPIItemHeadersKey)
		//aCoder.encodeObject(itemHeaderDetails, forKey: PITAPIItemHeaderDetailsKey)
		//aCoder.encodeObject(businessThemeURL, forKey: PITAPIBusinessThemeURLKey)
	//}
}
