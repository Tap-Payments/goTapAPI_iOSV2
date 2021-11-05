//
//  AddressBookPerson+Additions.swift
//  Pods
//
//  Created by Dennis Pashkov on 10/4/16.
//
//

import Contacts
import TapAdditionsKitV2

private typealias MappingClosure<T, U> = (T) -> U

public extension goTapAPI.AddressBookPerson {
    
    //MARK: - Public -
    //MARK: Methods
    
    @available(iOS 9.0, *)
    public convenience init(contact: CNContact) {
        
        self.init()
        
        guard contact.contactType == .person else { return }
        
        self.recordID = contact.identifier
        self.namePrefix = contact.namePrefix
        self.firstName = contact.givenName
        self.middleName = contact.middleName
        self.lastName = contact.familyName
        self.nameSuffix = contact.nameSuffix
        self.organizationName = contact.organizationName
        self.department = contact.departmentName
        self.jobTitle = contact.jobTitle
        self.birthday = contact.birthday?.date?.timeIntervalSince1970
        
        self.emailAddresses = type(of: self).parseLabeledValue(contact.emailAddresses, processingClosure: { (emailAddress) -> String in
            
            return emailAddress as String
        })
        
        self.addresses = type(of: self).parseLabeledValue(contact.postalAddresses, processingClosure: { (address) -> [String: String] in
            
            return address.tap_jsonDictionary
        })
        
        self.phones = type(of: self).parseLabeledValue(contact.phoneNumbers, processingClosure: { (phoneNumber) -> String in
            
            return phoneNumber.stringValue
        })
        
        self.instantMessages = type(of: self).parseLabeledValue(contact.instantMessageAddresses, processingClosure: { (imAddress) -> [String: String] in
            
            return imAddress.tap_jsonDictionary
        })
        
        self.urls = type(of: self).parseLabeledValue(contact.urlAddresses, processingClosure: { (url) -> String in
            
            return url as String
        })
        
        self.relatedNames = type(of: self).parseLabeledValue(contact.contactRelations, processingClosure: { (relation) -> String in
            
            return relation.name
        })
        
        self.socialProfiles = type(of: self).parseLabeledValue(contact.socialProfiles, processingClosure: { (profile) -> [String: String] in
            
            return profile.tap_jsonDictionary
        })
        
        self.imageDataBase64String = (contact.imageDataAvailable ? contact.imageData : nil)?.base64EncodedString()
    }
    
    //MARK: - Private -
    //MARK: Methods
    
    @available(iOS 9.0, *)
    private static func parseLabeledValue<T, U>(_ labeledValue: [CNLabeledValue<T>], processingClosure: MappingClosure<T, U>) -> [String: U] {
        
        var result: [String: U] = [:]
        
        for pair in labeledValue {
            
            if let label = pair.label {
                
                result[label] = processingClosure(pair.value)
            }
        }
        
        return result
    }
}
