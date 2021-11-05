//
//  ColorModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 2/14/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Color data model.
public class ColorModel: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Clear color.
	internal static let clearColor = goTapAPI.ColorModel(normalColor: goTapAPI.TPColor.clear, highlightedColor: goTapAPI.TPColor.clear, selectedColor: goTapAPI.TPColor.clear)

	/// Normal color.
	public private(set) var normalColor: UIColor?

	/// Highlighted color.
	public private(set) var highlightedColor: UIColor?

	/// Selected color.
	public private(set) var selectedColor: UIColor?

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.ColorModel else { return nil }
		model.normalColor = dictionary.parseColor(forKey: goTapAPI.Constants.Key.NormalColor)
		model.highlightedColor = dictionary.parseColor(forKey: goTapAPI.Constants.Key.HighlightedColor)
		model.selectedColor = dictionary.parseColor(forKey: goTapAPI.Constants.Key.SelectedColor)

		return model.tap_asSelf()
	}

	public override func isEqual(_ object: Any?) -> Bool {

		guard let color = object as? goTapAPI.ColorModel else { return false }

		return ( MappedTPColorExtension.equal(color1: normalColor, color2: color.normalColor) &&
				 MappedTPColorExtension.equal(color1: highlightedColor, color2: color.highlightedColor) &&
				 MappedTPColorExtension.equal(color1: selectedColor, color2: color.selectedColor) )
	}

	public required init() { super.init() }

	//required init?(coder aDecoder: NSCoder) {

		//super.init()

		//normalColor = aDecoder.decodeObject(forKey: PITAPINormalColorKey) as? UIColor
		//highlightedColor = aDecoder.decodeObject(forKey: PITAPIHighlightedColorKey) as? UIColor
		//selectedColor = aDecoder.decodeObject(forKey: PITAPISelectedColorKey) as? UIColor
	//}

	//func encodeWithCoder(aCoder: NSCoder) {

		//aCoder.encodeObject(normalColor, forKey: PITAPINormalColorKey)
		//aCoder.encodeObject(highlightedColor, forKey: PITAPIHighlightedColorKey)
		//aCoder.encodeObject(selectedColor, forKey: PITAPISelectedColorKey)
	//}

	//MARK: - Private -
	//MARK: Methods

	private init(normalColor nColor: UIColor?, highlightedColor hColor: UIColor?, selectedColor sColor: UIColor?) {

		super.init()

		self.normalColor = nColor
		self.highlightedColor = hColor
		self.selectedColor = sColor
	}
}

//// MARK: - NSCopying
//extension TPAPIColor: NSCopying {

	//func copyWithZone(zone: NSZone) -> AnyObject {

		//let color = self.dynamicType.init()
		//color.normalColor = normalColor?.copyWithZone(zone) as? UIColor
		//color.highlightedColor = highlightedColor?.copyWithZone(zone) as? UIColor
		//color.selectedColor = selectedColor?.copyWithZone(zone) as? UIColor

		//return color
	//}
//}
