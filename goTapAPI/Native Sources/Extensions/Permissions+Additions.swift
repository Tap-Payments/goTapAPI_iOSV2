//
//  Permissions+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/7/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/** Additions Extends Permissions

*/
extension Permissions {
    
    public convenience init(coder aDecoder: NSCoder) {
        
        self.init(cameraGranted: aDecoder.decodeBool(forKey: goTapAPI.Constants.Key.Camera),
                  contactsGranted: aDecoder.decodeBool(forKey: goTapAPI.Constants.Key.Contacts),
                  locationGranted: aDecoder.decodeBool(forKey: goTapAPI.Constants.Key.Location),
                  photosGranted: aDecoder.decodeBool(forKey: goTapAPI.Constants.Key.Photos),
                  notifications: aDecoder.decodeObject(forKey: goTapAPI.Constants.Key.Notifications) as! Notifications)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encode(cameraGranted, forKey: goTapAPI.Constants.Key.Camera)
        aCoder.encode(contactsGranted, forKey: goTapAPI.Constants.Key.Contacts)
        aCoder.encode(locationGranted, forKey: goTapAPI.Constants.Key.Location)
        aCoder.encode(photosGranted, forKey: goTapAPI.Constants.Key.Photos)
        aCoder.encode(notifications, forKey: goTapAPI.Constants.Key.Notifications)
    }
}
