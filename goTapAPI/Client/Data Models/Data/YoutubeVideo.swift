//
//  YoutubeVideo.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/4/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

public class YoutubeVideo: goTapAPI.DataModel {
    
    //MARK: - Public -
    //MARK: Properties
    
    public private(set) var videoURLs: [goTapAPI.VideoQuality: URL] = [:]
    
    public private(set) var previewURL: URL?
    
    public private(set) var length: UInt = 0
    
    public private(set) var title: String = ""
    
    public var bestQualityURL: URL? {
        
        if let hd720URL = videoURLs[goTapAPI.VideoQuality.HD720] {
            
            return hd720URL
        }
        else if let mediumURL = videoURLs[goTapAPI.VideoQuality.Medium] {
            
            return mediumURL
        }
        else {
            
            return videoURLs[goTapAPI.VideoQuality.Small]
        }
    }
    
    //MARK: Methods
    
    override func dataModelWith(serializedObject: Any?) -> Self? {
        
        guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
        
        if let smallURL = dictionary.parseURL(forKey: goTapAPI.Constants.Key.small) {
            
            self.videoURLs[goTapAPI.VideoQuality.Small] = smallURL
        }
        
        if let mediumURL = dictionary.parseURL(forKey: goTapAPI.Constants.Key.medium) {
            
            self.videoURLs[goTapAPI.VideoQuality.Medium] = mediumURL
        }
        
        if let hd720URL = dictionary.parseURL(forKey: goTapAPI.Constants.Key.hd720) {
            
            self.videoURLs[goTapAPI.VideoQuality.HD720] = hd720URL
        }
        
        guard let moreInfoDictionary = dictionary.parseDictionary(forKey: goTapAPI.Constants.Key.moreInfo) else { return self }
        
        self.previewURL = moreInfoDictionary.parseURL(forKey: goTapAPI.Constants.Key.thumbnail_url)
        self.length = UInt(moreInfoDictionary.parseInteger(forKey: goTapAPI.Constants.Key.length_seconds) ?? 0)
        self.title = moreInfoDictionary.parseString(forKey: goTapAPI.Constants.Key.title) ?? ""
        
        return self
    }
}
