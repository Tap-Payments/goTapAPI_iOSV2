//
//  GetInvoiceDetailsResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/1/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Response model for GetInvoiceDetails request.
public class GetInvoiceDetailsResponseModel: BadgedResponseModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Defines if invoice can be deleted.
	public private(set) var canDelete: Swift.Bool = false
	
	/// Message details.
	public private(set) var messageDetails: [MessageDetails] = []
	
	/// Orders.
	public private(set) var orders: [Order] = []
	
	/// Payment details.
	public private(set) var paymentDetails: [PaymentDetail] = []
	
	/// Screen to show.
	public private(set) var showScreen: ReceiptScreen = ReceiptScreen.None
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
	 
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? GetInvoiceDetailsResponseModel else { return nil }
		
		model.canDelete = dictionary.parseBoolean(forKey: Constants.Key.CanDelete) ?? false
		model.showScreen = ReceiptScreen(rawValue: dictionary.parseInteger(forKey: Constants.Key.ShowScreen) ?? ReceiptScreen.None.rawValue)
		
		let emptyMessageDetails: [MessageDetails] = []
		let messageParsingClosure: (AnyObject) -> MessageDetails? = { object in
		
			return MessageDetails().dataModelWith(serializedObject: object)
		}
		let parsedMessageDetails = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.MsgDetails), usingClosure: messageParsingClosure)
		model.messageDetails = parsedMessageDetails == nil ? emptyMessageDetails : parsedMessageDetails!
		
		let emptyOrders: [Order] = []
		let orderParsingClosure: (AnyObject) -> Order? = { object in
		
			return Order().dataModelWith(serializedObject: object)
		}
		let parsedOrders = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.Orders), usingClosure: orderParsingClosure)
		model.orders = parsedOrders == nil ? emptyOrders : parsedOrders!
		
		let emptyPaymentDetails: [PaymentDetail] = []
		let paymentDetailParsingClosure: (AnyObject) -> PaymentDetail? = { object in
		
			return PaymentDetail().dataModelWith(serializedObject: object)
		}
		let parsedPaymentDetails = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.PayDetails), usingClosure: paymentDetailParsingClosure)
		model.paymentDetails = parsedPaymentDetails == nil ? emptyPaymentDetails : parsedPaymentDetails!
		
		return model.tap_asSelf()
	}
}
