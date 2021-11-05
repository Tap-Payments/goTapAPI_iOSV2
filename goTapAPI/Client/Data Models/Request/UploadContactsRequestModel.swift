//
//  UploadContactsRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model to upload contacts.
internal class UploadContactsRequestModel: goTapAPI.RequestModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Actions for contact to upload.
	internal private(set) var actions: [goTapAPI.PendingRecord] = []
	
	/// Contacts to upload.
	internal private(set) var contacts: [goTapAPI.AddressBookPerson] = []
	
	internal override var serializedModel: AnyObject? {
		
		var serializedContacts: [String] = []
		
		for (index, contact) in contacts.enumerated() {
			
			let action = actions[index]
			
			let contactDict: [String: String] = [
			
				goTapAPI.Constants.Value.ID: "\(action.recordID)",
				goTapAPI.Constants.Value.VAL: contact.jsonString,
				goTapAPI.Constants.Value.STTS: action.action.stringRepresentation
			]
			
			let encryptedContactString = goTapAPI.Client.sharedInstance.dataSource!.encryptDictionary(contactDict)
			
			serializedContacts.append(encryptedContactString)
		}
		
		let result: [String: Any] = [
		
			goTapAPI.Constants.Key.Value: serializedContacts
		]
		
		return result as AnyObject
	}
	
	//MARK: Methods
	
	/**
	 Initializes data model with contacts and actions.
	 
	 - parameter contacts: Contacts.
	 - parameter actions:  Contact actions.
	 
	 - returns: TPAPIUploadContactsRequestModel
	 */
	internal init(contacts: [goTapAPI.AddressBookPerson], actions: [goTapAPI.PendingRecord]) {
		
		super.init()
		
		self.contacts = contacts
		self.actions = actions
	}
	
	public required init() { super.init() }
}