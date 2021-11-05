//
//  FileSerializable.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/17/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

public protocol FileSerializable {
    
    func save(to file: String)
    
    static func load<T>(from file: String) -> T? where T: DataModel
    
    static func save<T>(array: [T], to file: String) where T: DataModel
    
    static func loadArray<T>(from file: String) -> [T]? where T: DataModel
}
