//
//  YoutubeVideo.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/4/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

public class YoutubeVideo: DataModel {
    
    //MARK: - Public -
    //MARK: Properties
    
    public private(set) var videoURLs: [VideoQuality: URL] = [:]
    
    public private(set) var previewURL: URL?
    
    public private(set) var length: UInt = 0
    
    public private(set) var title: String = ""
    
    public var bestQualityURL: URL? {
        
        if let hd720URL = videoURLs[VideoQuality.HD720] {
            
            return hd720URL
        }
        else if let mediumURL = videoURLs[VideoQuality.Medium] {
            
            return mediumURL
        }
        else {
            
            return videoURLs[VideoQuality.Small]
        }
    }
    
    //MARK: Methods
    
    override func dataModelWith(serializedObject: Any?) -> Self? {
        
        guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
        
        if let smallURL = dictionary.parseURL(forKey: Constants.Key.small) {
            
            self.videoURLs[VideoQuality.Small] = smallURL
        }
        
        if let mediumURL = dictionary.parseURL(forKey: Constants.Key.medium) {
            
            self.videoURLs[VideoQuality.Medium] = mediumURL
        }
        
        if let hd720URL = dictionary.parseURL(forKey: Constants.Key.hd720) {
            
            self.videoURLs[VideoQuality.HD720] = hd720URL
        }
        
        guard let moreInfoDictionary = dictionary.parseDictionary(forKey: Constants.Key.moreInfo) else { return self }
        
        self.previewURL = moreInfoDictionary.parseURL(forKey: Constants.Key.thumbnail_url)
        self.length = UInt(moreInfoDictionary.parseInteger(forKey: Constants.Key.length_seconds) ?? 0)
        self.title = moreInfoDictionary.parseString(forKey: Constants.Key.title) ?? ""
        
        return self
    }
}
