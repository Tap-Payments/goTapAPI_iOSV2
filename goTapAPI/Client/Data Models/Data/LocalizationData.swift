//
//  LocalizationData.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/29/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Localization data model.
public class LocalizationData: DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Icon URL.
	public var iconURL: URL? {

		return UrlExtension.with(string: iconURLString)
	}

	/// Icon image. If nil. use @c iconURL property to load
	public var iconImage: TPImage?

	/// Locale identifier.
	public private(set) var localeIdentifier: String = String.tap_empty

	/// Locale name.
	public private(set) var localeName: String = String.tap_empty

	/// Language font that should be used for this language.
	public private(set) var languageFont: LanguageFont = LanguageFont.Default

	/// Translation file URL.
	public var translationFileURL: URL? {

		return UrlExtension.with(string: translationFileURLString)
	}

	/// Sharing file URL.
	public var sharingFileURL: URL? {

		return UrlExtension.with(string: sharingFileURLString)
	}

	internal override var serializedModel: AnyObject? {

		var result: [String: Any] = [:]

			result[Constants.Key.icon] = iconURLString
			result[Constants.Key.localeIdentifier] = localeIdentifier
			result[Constants.Key.localeName] = localeName
			result[Constants.Key.LanguageFont] = languageFont
			result[Constants.Key.translationFileURL] = translationFileURLString
			result[Constants.Key.shareFileURL] = sharingFileURLString

		return result as AnyObject
	}

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? LocalizationData else { return nil }

		guard let parsedIconURL = dictionary.parseString(forKey: Constants.Key.icon) else { return nil }
		guard let parsedLocaleIdentifier = dictionary.parseString(forKey: Constants.Key.localeIdentifier) else { return nil }
		guard let parsedLocaleName = dictionary.parseString(forKey: Constants.Key.localeName) else { return nil }
		guard let parsedTranslationFileURL = dictionary.parseString(forKey: Constants.Key.translationFileURL) else { return nil }
		guard let parsedSharingFileURL = dictionary.parseString(forKey: Constants.Key.shareFileURL) else { return nil }

		model.iconURLString = parsedIconURL
		model.localeIdentifier = parsedLocaleIdentifier
		model.localeName = parsedLocaleName
		model.translationFileURLString = parsedTranslationFileURL
		model.sharingFileURLString = parsedSharingFileURL
		model.languageFont = LanguageFont.with(intValue: dictionary.parseInteger(forKey: Constants.Key.LanguageFont))

		return model.tap_asSelf()
	}

	/**
	 Initializes new instance of TPAPILocalization data with given parameters.

	 - parameter iconImage:          Icon image.
	 - parameter localeIdentifier:   Locale identifier.
	 - parameter localeName:         Locale name.
	 - parameter languageFont:       Language font.
	 - parameter translationFileURL: Translation file URL.
	 - parameter sharingFileURL:     Sharing file URL.

	 - returns: New instance of TPAPILocalizationData.
	 */
	public init(iconImage: TPImage, localeIdentifier: String, localeName: String!, languageFont: LanguageFont, translationFileURL: String, sharingFileURL: String) {

		super.init()

		self.iconImage = iconImage
		self.localeIdentifier = localeIdentifier
		self.localeName = localeName
		self.languageFont = languageFont
		self.translationFileURLString = translationFileURL
		self.sharingFileURLString = sharingFileURL
	}

	public required init() { super.init() }

	//MARK: - Private -
	//MARK: Properties

	private var iconURLString: String = String.tap_empty
	private var translationFileURLString: String = String.tap_empty
	private var sharingFileURLString: String = String.tap_empty
}
