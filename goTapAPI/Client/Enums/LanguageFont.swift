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
public class LanguageFont: goTapAPI.Enum {
	
	public static let Default = goTapAPI.LanguageFont(rawValue: 0)
	public static let Arabic = goTapAPI.LanguageFont(rawValue: 1)
	
	static func with(intValue: Int64?) -> goTapAPI.LanguageFont {
	
		guard let value = intValue else {
		 
			return goTapAPI.LanguageFont.Default
		}
	
		if value == 1 {
		 
			return goTapAPI.LanguageFont.Arabic
		}
		else {
		 
			return goTapAPI.LanguageFont.Default
		}
	}
}