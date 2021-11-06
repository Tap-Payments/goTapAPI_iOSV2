//
//  LanguageFont.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/29/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 Language font.
 
 - Default: Default font.
 - Arabic:  Font for arabic languages.
 */
public class LanguageFont: Enum {
	
	public static let Default = LanguageFont(rawValue: 0)
	public static let Arabic = LanguageFont(rawValue: 1)
	
	static func with(intValue: Int64?) -> LanguageFont {
	
		guard let value = intValue else {
		 
			return LanguageFont.Default
		}
	
		if value == 1 {
		 
			return LanguageFont.Arabic
		}
		else {
		 
			return LanguageFont.Default
		}
	}
}
