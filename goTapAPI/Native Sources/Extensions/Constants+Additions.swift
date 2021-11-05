//
//  Constants+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/4/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

internal extension goTapAPI.Constants.Key {
    
    internal static let hd720: String = "hd720"
    internal static let thumbnail_url: String = "thumbnail_url"
    internal static let Last_Modified: String = "Last-Modified"
    internal static let length_seconds: String = "length_seconds"
    internal static let medium: String = "medium"
    internal static let moreInfo: String = "moreInfo"
    internal static let small: String = "small"
    internal static let string: String = "string"
    internal static let title: String = "title"
}

internal extension goTapAPI.Constants.Error {
    
    internal struct UserInfoKey {
        
        internal static let RequestHeaders: String = "RequestHeaders"
        internal static let RequestParameters: String = "RequestParameters"
        internal static let ResponseHeaders: String = "ResponseHeaders"
        internal static let ResponseParameters: String = "ResponseParameters"
        internal static let URL: String = "URL"
    }
}
