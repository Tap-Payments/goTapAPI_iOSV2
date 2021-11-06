//
//  HeaderAttributes.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/4/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Header attributes data model.
public class HeaderAttributes: DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Header background attributes.
	public private(set) var background: ColorModel = ColorModel.clearColor

	/// Header border attributes.
	public private(set) var border: ColorModel = ColorModel.clearColor

	/// Header text attributes.
	public private(set) var text: ColorModel = ColorModel.clearColor

	//MARK: Methods

	public required init() { super.init() }

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? HeaderAttributes else { return nil }

		model.background = ColorModel().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: Constants.Key.background) as AnyObject) ?? ColorModel.clearColor
		model.border = ColorModel().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: Constants.Key.border) as AnyObject) ?? ColorModel.clearColor
		model.text = ColorModel().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: Constants.Key.text) as AnyObject) ?? ColorModel.clearColor

		return model.tap_asSelf()
	}

	//required convenience init?(coder aDecoder: NSCoder) {

		//var back: TPAPIColor!
		//var border: TPAPIColor!
		//var txt: TPAPIColor!

		//do {

			//try NSObject.catchException {

				//guard let decodedBackground = aDecoder.decodeObject(forKey: PITAPIbackgroundKey) as? TPAPIColor else { return }
				//guard let decodedBorder = aDecoder.decodeObject(forKey: PITAPIborderKey) as? TPAPIColor else { return }
				//guard let decodedText = aDecoder.decodeObject(forKey: PITAPItextKey) as? TPAPIColor else { return }

				//back = decodedBackground
				//border = decodedBorder
				//txt = decodedText
			//}
		//}
		//catch {

			//return nil
		//}

		//self.init(backgroundColor: back, borderColor: border, textColor: txt)
	//}

	//func encodeWithCoder(aCoder: NSCoder) {

		//aCoder.encodeObject(background, forKey: PITAPIbackgroundKey)
		//aCoder.encodeObject(border, forKey: PITAPIborderKey)
		//aCoder.encodeObject(text, forKey: PITAPItextKey)
	//}

	public override func isEqual(_ object: Any?) -> Bool {

		guard let otherObject = object as? HeaderAttributes else { return false }

		return ( background.isEqual(otherObject.background) &&
				 border.isEqual(otherObject.border) &&
				 text.isEqual(otherObject.text) )
	}

	//func copyWithZone(zone: NSZone) -> AnyObject {

		//let newObject = TPAPIHeaderAttributes(backgroundColor: background, borderColor: border, textColor: text)
		//return newObject
	//}

	//MARK: - Private -
	//MARK: Methods

	private init(backgroundColor: ColorModel, borderColor: ColorModel, textColor: ColorModel) {

		super.init()

		self.background = backgroundColor
		self.border = borderColor
		self.text = textColor
	}
}
