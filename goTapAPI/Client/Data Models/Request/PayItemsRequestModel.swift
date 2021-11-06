//
//  PayItemsRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Pay items request model.
internal class PayItemsRequestModel: RequestModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Items.
	private(set) var items: [PaymentSerialization] = []
	
	internal override var serializedModel: AnyObject? {
		
		guard var result = super.serializedModel as? [String: Any] else { return nil }
		
		let itemsSerializationClosure: (PaymentSerialization) -> AnyObject? = { item in
		
			return item.paymentSerializedModel()
		}
		
		let emptyArray: [AnyObject] = []
		
		result[Constants.Key.Items] = ParseHelper.serialize(array: items, usingClosure: itemsSerializationClosure) ?? emptyArray
		
		result.setNullable(value: ApplicationData.sharedInstance.serializedModel, forKey: Constants.Key.AppData)
		
		return result as AnyObject
	}
	
	//MARK: Methods
	
	/**
	 Initializes model with items.
	 
	 - parameter items: Items.
	 
	 - returns: TPAPIPayItemsRequestModel.
	 */
	internal init(items: [PaymentSerialization]) {
		
		super.init()
		self.items = items
	}
	
	public required init() { super.init() }
}
