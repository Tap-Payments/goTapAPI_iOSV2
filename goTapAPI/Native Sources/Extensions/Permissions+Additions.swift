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
        
        self.init(cameraGranted: aDecoder.decodeBool(forKey: Constants.Key.Camera),
                  contactsGranted: aDecoder.decodeBool(forKey: Constants.Key.Contacts),
                  locationGranted: aDecoder.decodeBool(forKey: Constants.Key.Location),
                  photosGranted: aDecoder.decodeBool(forKey: Constants.Key.Photos),
                  notifications: aDecoder.decodeObject(forKey: Constants.Key.Notifications) as! Notifications)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encode(cameraGranted, forKey: Constants.Key.Camera)
        aCoder.encode(contactsGranted, forKey: Constants.Key.Contacts)
        aCoder.encode(locationGranted, forKey: Constants.Key.Location)
        aCoder.encode(photosGranted, forKey: Constants.Key.Photos)
        aCoder.encode(notifications, forKey: Constants.Key.Notifications)
    }
}
