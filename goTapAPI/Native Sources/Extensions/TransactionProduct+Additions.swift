//
//  TransactionProduct+Additions.swift
//  Pods
//
//  Created by Dennis Pashkov on 10/10/16.
//
//

import Foundation

/** Additions Extends TransactionProduct

*/
public extension TransactionProduct {
    
    /// Defines if product can be redeemed.
    public var canRedeem: Bool {
        
        switch actionType {
            
        case ActionType.None:
            
            return false
            
        case ActionType.OpenURL:
            
            guard redeemURL != nil else { return false }
            return UIApplication.shared.canOpenURL(redeemURL!)
            
        case ActionType.PhoneCall:
            
            guard let phoneNumberLength = phoneNumber?.Length, phoneNumberLength > 0 else { return false }
            guard let cleanNumberString = phoneNumber?.byRemovingAllCharacters(exceptCharactersFrom: "0123456789-+()") else { return false }
            guard let phoneNumberURL = URL(string: "tel:\(cleanNumberString)") else { return false }
            return UIApplication.shared.canOpenURL(phoneNumberURL)
            
        case ActionType.Refresh:
            
            return false
            
        case ActionType.SendSMS:
            
            guard let phoneNumberLength = phoneNumber?.Length, phoneNumberLength > 0 else { return false }
            guard let messageLength = message?.Length, messageLength > 0 else { return false }
            
            return true
            
        default:
            
            return false
        }
    }
}
