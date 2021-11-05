//
//  Dispatcher.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 9/28/16.
//  Copyright © 2016 Dennis Pashkov. All rights reserved.
//

internal class Dispatcher {
    
    internal static func dispatchOnMainThread(closure: @escaping () -> ()) {
        
        DispatchQueue.main.async {
            
            closure()
        }
    }
    
    //MARK: - Private -
    //MARK: Methods
    
    private init() {}
}
