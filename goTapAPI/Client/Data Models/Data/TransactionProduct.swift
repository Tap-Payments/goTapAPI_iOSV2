//
//  TransactionProduct.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Transaction product data model.
public class TransactionProduct: DataModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Action type.
	public private(set) var actionType: ActionType = ActionType.None
	
	/// Amount.
	public private(set) var amount: Foundation.Decimal = Foundation.Decimal.zero
	
	/// Description.
	public private(set) var descriptionString: String?
	
	/// Defines if serial is available.
	public private(set) var isSerialAvailable: Swift.Bool = false
	
	/// Defines if serial is loaded.
	public private(set) var isSerialLoaded: Swift.Bool = false
	
	/// Message.
	public private(set) var message: String?
	
	/// Phone number.
	public private(set) var phoneNumber: String?
	
	/// Product ID.
	public private(set) var productID: Int64 = 0
	
	/// Product image URL.
	public private(set) var productImageURL: URL?
	
	/// Product name.
	public private(set) var productName: String?
	
	/// Quantity.
	public private(set) var quantity: Int64 = 0
	
	/// Redeem URL.
	public private(set) var redeemURL: URL?
	
	/// Row ID.
	public private(set) var rowID: Int64 = 0
	
	/// Serial number.
	public private(set) var serialNumber: String?
	
	/// Vendor ID.
	public private(set) var vendorID: Int64 = 0
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? TransactionProduct else { return nil }
		
		model.actionType = ActionType.with(stringValue: dictionary.parseString(forKey: Constants.Key.ActionType))
		model.amount = dictionary.parseAmount(forKey: Constants.Key.Amount) ?? Foundation.Decimal.zero
		model.descriptionString = dictionary.parseString(forKey: Constants.Key.Description)
		model.isSerialAvailable = dictionary.parseBoolean(forKey: Constants.Key.IsSrlAvailable) ?? false
		model.isSerialLoaded = dictionary.parseBoolean(forKey: Constants.Key.IsSrlLoaded) ?? false
		model.message = dictionary.parseString(forKey: Constants.Key.Msg)
		model.phoneNumber = dictionary.parseString(forKey: Constants.Key.PhNumber)
		model.productID = dictionary.parseInteger(forKey: Constants.Key.PrdID) ?? 0
		model.productImageURL = dictionary.parseURL(forKey: Constants.Key.PrdImage)
		model.productName = dictionary.parseString(forKey: Constants.Key.PrdName)
		model.quantity = dictionary.parseInteger(forKey: Constants.Key.Quantity) ?? 0
		model.redeemURL = dictionary.parseURL(forKey: Constants.Key.RedeemUrl)
		model.rowID = dictionary.parseInteger(forKey: Constants.Key.RowID) ?? 0
		model.serialNumber = dictionary.parseString(forKey: Constants.Key.SerialNumber)
		model.vendorID = dictionary.parseInteger(forKey: Constants.Key.VndID) ?? 0
		
		return model.tap_asSelf()
	}
}
