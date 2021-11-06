//
//  ReceiptDetails.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/1/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Receipt details data model.
public class ReceiptDetails: DataModel {

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
	public private(set) var transactionCard: TransactionCard?

	/// Businesses.
	public private(set) var businesses: [TransactionBusiness] = []

	//MARK: Methods

	public required init() { super.init() }

	public convenience init(receiptNumber: String, referenceNumber: String) {

		self.init()

		self.number = receiptNumber
		self.paymentReferenceNumber = referenceNumber
	}

	public static func instantiate(with serializedObject: AnyObject?) -> ReceiptDetails? {

		return ReceiptDetails().dataModelWith(serializedObject: serializedObject)
	}

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? ReceiptDetails else { return nil }

		guard let paymentReferenceNumberString = dictionary.parseString(forKey: Constants.Key.PayRefNumber) else { return nil }
		guard let receiptDate = dictionary.parseDate(forKey: Constants.Key.Date) else { return nil }
		guard let isCollectionAvailableNumber = dictionary.parseBoolean(forKey: Constants.Key.IsCollectionAvl) else { return nil }

		let businessParsingClosure: (AnyObject) -> TransactionBusiness? = { object in

			return TransactionBusiness().dataModelWith(serializedObject: object)
		}

		guard let parsedBusinesses = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.Businesses), usingClosure: businessParsingClosure) else { return nil }

		model.number = dictionary.parseString(forKey: Constants.Key.Number)
		model.paymentReferenceNumber = paymentReferenceNumberString
		model.date = receiptDate
		model.isCollectionAvailable = isCollectionAvailableNumber
		model.transactionCard = TransactionCard().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: Constants.Key.TxnCard) as AnyObject)
		model.businesses = parsedBusinesses

		return model.tap_asSelf()
	}
}
