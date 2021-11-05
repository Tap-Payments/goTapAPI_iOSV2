//
//  ReceiptDetails.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/1/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Receipt details data model.
public class ReceiptDetails: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Receipt number.
	public private(set) var number: String?

	/// Payment reference number.
	public private(set) var paymentReferenceNumber: String = String.tap_empty

	/// Receipt date.
	public private(set) var date: Date = Date()

	/// Collection available flag.
	public private(set) var isCollectionAvailable: Swift.Bool = false

	/// Transaction card.
	public private(set) var transactionCard: goTapAPI.TransactionCard?

	/// Businesses.
	public private(set) var businesses: [goTapAPI.TransactionBusiness] = []

	//MARK: Methods

	public required init() { super.init() }

	public convenience init(receiptNumber: String, referenceNumber: String) {

		self.init()

		self.number = receiptNumber
		self.paymentReferenceNumber = referenceNumber
	}

	public static func instantiate(with serializedObject: AnyObject?) -> goTapAPI.ReceiptDetails? {

		return goTapAPI.ReceiptDetails().dataModelWith(serializedObject: serializedObject)
	}

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.ReceiptDetails else { return nil }

		guard let paymentReferenceNumberString = dictionary.parseString(forKey: goTapAPI.Constants.Key.PayRefNumber) else { return nil }
		guard let receiptDate = dictionary.parseDate(forKey: goTapAPI.Constants.Key.Date) else { return nil }
		guard let isCollectionAvailableNumber = dictionary.parseBoolean(forKey: goTapAPI.Constants.Key.IsCollectionAvl) else { return nil }

		let businessParsingClosure: (AnyObject) -> goTapAPI.TransactionBusiness? = { object in

			return goTapAPI.TransactionBusiness().dataModelWith(serializedObject: object)
		}

		guard let parsedBusinesses = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.Businesses), usingClosure: businessParsingClosure) else { return nil }

		model.number = dictionary.parseString(forKey: goTapAPI.Constants.Key.Number)
		model.paymentReferenceNumber = paymentReferenceNumberString
		model.date = receiptDate
		model.isCollectionAvailable = isCollectionAvailableNumber
		model.transactionCard = goTapAPI.TransactionCard().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: goTapAPI.Constants.Key.TxnCard) as AnyObject)
		model.businesses = parsedBusinesses

		return model.tap_asSelf()
	}
}
