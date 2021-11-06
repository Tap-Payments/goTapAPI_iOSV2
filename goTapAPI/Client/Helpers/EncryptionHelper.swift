internal class EncryptionHelper {

	internal static func encrypt(paymentCard card: PaymentCard, amount: Foundation.Decimal) -> String {

		var data: [String: String] = [:]

		data[Constants.Key.CNO] = card.cardNumber
		data[Constants.Key.EXP] = card.expirationDate
		data[Constants.Key.CVV] = card.cvv
		data[Constants.Key.NMC] = card.nameOnCard
		data[Constants.Key.AMT] = amount.stringValue
		data[Constants.Key.CCD] = card.currencyCode
		data[Constants.Key.GID] = "\(card.gatewayID)"
		data[Constants.Key.CID] = card.cardID
		data[Constants.Key.CTP] = card.cardType.stringRepresentation

		return Client.sharedInstance.dataSource!.encryptDictionary(data)
	}
}
