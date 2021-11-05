//
//  GetInvoiceDetailsResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/1/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Response model for GetInvoiceDetails request.
public class GetInvoiceDetailsResponseModel: goTapAPI.BadgedResponseModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Defines if invoice can be deleted.
	public private(set) var canDelete: Swift.Bool = false
	
	/// Message details.
	public private(set) var messageDetails: [goTapAPI.MessageDetails] = []
	
	/// Orders.
	public private(set) var orders: [goTapAPI.Order] = []
	
	/// Payment details.
	public private(set) var paymentDetails: [goTapAPI.PaymentDetail] = []
	
	/// Screen to show.
	public private(set) var showScreen: goTapAPI.ReceiptScreen = goTapAPI.ReceiptScreen.None
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
	 
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.GetInvoiceDetailsResponseModel else { return nil }
		
		model.canDelete = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.CanDelete) ?? false
		model.showScreen = goTapAPI.ReceiptScreen(rawValue: dictionary.parseInteger(forKey: goTapAPI.Constants.Key.ShowScreen) ?? goTapAPI.ReceiptScreen.None.rawValue)
		
		let emptyMessageDetails: [goTapAPI.MessageDetails] = []
		let messageParsingClosure: (AnyObject) -> goTapAPI.MessageDetails? = { object in
		
			return goTapAPI.MessageDetails().dataModelWith(serializedObject: object)
		}
		let parsedMessageDetails = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.MsgDetails), usingClosure: messageParsingClosure)
		model.messageDetails = parsedMessageDetails == nil ? emptyMessageDetails : parsedMessageDetails!
		
		let emptyOrders: [goTapAPI.Order] = []
		let orderParsingClosure: (AnyObject) -> goTapAPI.Order? = { object in
		
			return goTapAPI.Order().dataModelWith(serializedObject: object)
		}
		let parsedOrders = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.Orders), usingClosure: orderParsingClosure)
		model.orders = parsedOrders == nil ? emptyOrders : parsedOrders!
		
		let emptyPaymentDetails: [goTapAPI.PaymentDetail] = []
		let paymentDetailParsingClosure: (AnyObject) -> goTapAPI.PaymentDetail? = { object in
		
			return goTapAPI.PaymentDetail().dataModelWith(serializedObject: object)
		}
		let parsedPaymentDetails = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.PayDetails), usingClosure: paymentDetailParsingClosure)
		model.paymentDetails = parsedPaymentDetails == nil ? emptyPaymentDetails : parsedPaymentDetails!
		
		return model.tap_asSelf()
	}
}
