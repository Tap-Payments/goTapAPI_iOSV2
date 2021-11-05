//
//  VideoQuality.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/4/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

public class VideoQuality: Enum {
    
    public static let Small = goTapAPI.VideoQuality(rawValue: 0)
    public static let Medium = goTapAPI.VideoQuality(rawValue: 1)
    public static let HD720 = goTapAPI.VideoQuality(rawValue: 2)
}
