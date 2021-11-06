//
//  PaymentCard.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/9/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Payment card data model.
public class PaymentCard: TransactionCard {

	//MARK: - Public -
	//MARK: Properties

	/// Added type.
	public private(set) var addedType: AddedType = AddedType.Unknown

	/// Address.
	public private(set) var address: Address?

	/// Bank ID.
	public private(set) var bankID: Int64 = 0

	/// Bank name.
	public private(set) var bankName: String = String.tap_empty

	/// Defines if card can be used for payments.
	public private(set) var canPay: Swift.Bool = false

	/// Card brand.
	public private(set) var cardBrand: CardBrand = CardBrand.Tap

	/// Card category.
	public private(set) var cardCategory: String = String.tap_empty

	/// Card image URL.
	public private(set) var cardImageURL: URL?

	/// Card type ID.
	public private(set) var cardTypeID: Int64 = 0

	/// Country code.
	public private(set) var countryCode: String?

	/// Currency code.
	public private(set) var currencyCode: String = String.tap_empty

	/// Currency symbol.
	public private(set) var currencySymbol: String = String.tap_empty

	/// Defines if payment option should be shown to the user.
	public private(set) var showCard: Bool = false

	/// Defines if card can be edit.
	public private(set) var isCardEditable: Swift.Bool = false

	/// Defines if currency can be edited.
	public private(set) var isCurrencyEditable: Swift.Bool = false

	/// Defines if authentication is required.
	public private(set) var isAuthenticationRequired: Swift.Bool = false

	/// Sorting order.
	public private(set) var orderBy: Int64 = 0

	/// Payment process type.
	public private(set) var paymentProcessType: PaymentProcessType = PaymentProcessType.CardInfo

	/// Remarks.
	public private(set) var remarks: String?

	/// Transaction card.
	internal var transactionCard: TransactionCard {

		return TransactionCard(

			cardID: cardID,
			cardNumber: cardNumber,
			gatewayID: gatewayID,
			expirationDate: expirationDate,
			cvv: cvv,
			nameOnCard: nameOnCard,
			cardType: cardType
		)
	}

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? PaymentCard else { return nil }

		guard let parsedBankID = dictionary.parseInteger(forKey: Constants.Key.BankID) else { return nil }
		guard let parsedBankName = dictionary.parseString(forKey: Constants.Key.BankName) else { return nil }
		guard let parsedCardBrand = CardBrand.with(stringValue: dictionary.parseString(forKey: Constants.Key.CardBrand)) else { return nil }
		guard let parsedCurrencyCode = dictionary.parseString(forKey: Constants.Key.CurrencyCode) else { return nil }
		guard let parsedCurrencySymbol = dictionary.parseString(forKey: Constants.Key.CurrencySymbol) else { return nil }

		model.addedType = AddedType.with(stringValue: dictionary.parseString(forKey: Constants.Key.AddedType))
		model.address = Address().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: Constants.Key.Address) as AnyObject)
		model.bankID = parsedBankID
		model.bankName = parsedBankName
		model.canPay = dictionary.parseBoolean(forKey: Constants.Key.CanPay) ?? false
		model.cardBrand = parsedCardBrand
		model.cardCategory = dictionary.parseString(forKey: Constants.Key.CardCategory) ?? String.tap_empty
		model.cardImageURL = dictionary.parseURL(forKey: Constants.Key.CardImg)
		model.cardTypeID = dictionary.parseInteger(forKey: Constants.Key.CardTypeID) ?? 0
		model.countryCode = dictionary.parseString(forKey: Constants.Key.CountryCode)
		model.currencyCode = parsedCurrencyCode
		model.currencySymbol = parsedCurrencySymbol
		model.isCardEditable = dictionary.parseBoolean(forKey: Constants.Key.EditCard) ?? false
		model.isCurrencyEditable = dictionary.parseBoolean(forKey: Constants.Key.EditCurr) ?? false
		model.isAuthenticationRequired = dictionary.parseBoolean(forKey: Constants.Key.IsAuthReq) ?? false
		model.orderBy = dictionary.parseInteger(forKey: Constants.Key.OrderBy) ?? 0
		model.paymentProcessType = PaymentProcessType.with(intValue: dictionary.parseInteger(forKey: Constants.Key.PayProcessID) ?? 0)
		model.showCard = dictionary.parseBoolean(forKey: Constants.Key.ShowCard) ?? false

		model.remarks = dictionary.parseString(forKey: Constants.Key.Remarks)

		return model.tap_asSelf()
	}

	public required init() { super.init() }
}
