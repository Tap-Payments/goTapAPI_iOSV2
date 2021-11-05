//
//  LocalizationData.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/29/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Localization data model.
public class LocalizationData: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Icon URL.
	public var iconURL: URL? {

		return goTapAPI.UrlExtension.with(string: iconURLString)
	}

	/// Icon image. If nil. use @c iconURL property to load
	public var iconImage: goTapAPI.TPImage?

	/// Locale identifier.
	public private(set) var localeIdentifier: String = String.tap_empty

	/// Locale name.
	public private(set) var localeName: String = String.tap_empty

	/// Language font that should be used for this language.
	public private(set) var languageFont: goTapAPI.LanguageFont = goTapAPI.LanguageFont.Default

	/// Translation file URL.
	public var translationFileURL: URL? {

		return goTapAPI.UrlExtension.with(string: translationFileURLString)
	}

	/// Sharing file URL.
	public var sharingFileURL: URL? {

		return goTapAPI.UrlExtension.with(string: sharingFileURLString)
	}

	internal override var serializedModel: AnyObject? {

		var result: [String: Any] = [:]

			result[goTapAPI.Constants.Key.icon] = iconURLString
			result[goTapAPI.Constants.Key.localeIdentifier] = localeIdentifier
			result[goTapAPI.Constants.Key.localeName] = localeName
			result[goTapAPI.Constants.Key.LanguageFont] = languageFont
			result[goTapAPI.Constants.Key.translationFileURL] = translationFileURLString
			result[goTapAPI.Constants.Key.shareFileURL] = sharingFileURLString

		return result as AnyObject
	}

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.LocalizationData else { return nil }

		guard let parsedIconURL = dictionary.parseString(forKey: goTapAPI.Constants.Key.icon) else { return nil }
		guard let parsedLocaleIdentifier = dictionary.parseString(forKey: goTapAPI.Constants.Key.localeIdentifier) else { return nil }
		guard let parsedLocaleName = dictionary.parseString(forKey: goTapAPI.Constants.Key.localeName) else { return nil }
		guard let parsedTranslationFileURL = dictionary.parseString(forKey: goTapAPI.Constants.Key.translationFileURL) else { return nil }
		guard let parsedSharingFileURL = dictionary.parseString(forKey: goTapAPI.Constants.Key.shareFileURL) else { return nil }

		model.iconURLString = parsedIconURL
		model.localeIdentifier = parsedLocaleIdentifier
		model.localeName = parsedLocaleName
		model.translationFileURLString = parsedTranslationFileURL
		model.sharingFileURLString = parsedSharingFileURL
		model.languageFont = goTapAPI.LanguageFont.with(intValue: dictionary.parseInteger(forKey: goTapAPI.Constants.Key.LanguageFont))

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
	public init(iconImage: goTapAPI.TPImage, localeIdentifier: String, localeName: String!, languageFont: goTapAPI.LanguageFont, translationFileURL: String, sharingFileURL: String) {

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
