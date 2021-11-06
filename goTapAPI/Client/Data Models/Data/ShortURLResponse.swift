//
//  ShortURLResponse.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/27/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Short URL response model.
public class ShortURLResponse: ShortURLRequest {

	//MARK: - Public -
	//MARK: Properties

	/// Short URL.
	public var shortURL: URL? {

		return UrlExtension.with(string: shortURLString)
	}

	internal override var serializedModel: AnyObject? {

		let result: [String: Any] = [

			Constants.Key.ShortUrl: shortURLString
		]

		return result as AnyObject
	}

	//MARK: Methods

	public required init() { super.init() }

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? ShortURLResponse else { return nil }
		guard let parsedShortURL = dictionary.parseString(forKey: Constants.Key.ShortUrl) else { return nil }

		model.shortURLString = parsedShortURL

		return model.tap_asSelf()
	}

	//MARK: - Private -
	//MARK: Properties

	public var shortURLString: String = String.tap_empty
}
