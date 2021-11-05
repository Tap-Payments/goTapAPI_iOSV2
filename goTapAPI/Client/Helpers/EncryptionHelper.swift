internal class EncryptionHelper {

	internal static func encrypt(paymentCard card: goTapAPI.PaymentCard, amount: Foundation.Decimal) -> String {

		var data: [String: String] = [:]

		data[goTapAPI.Constants.Key.CNO] = card.cardNumber
		data[goTapAPI.Constants.Key.EXP] = card.expirationDate
		data[goTapAPI.Constants.Key.CVV] = card.cvv
		data[goTapAPI.Constants.Key.NMC] = card.nameOnCard
		data[goTapAPI.Constants.Key.AMT] = amount.stringValue
		data[goTapAPI.Constants.Key.CCD] = card.currencyCode
		data[goTapAPI.Constants.Key.GID] = "\(card.gatewayID)"
		data[goTapAPI.Constants.Key.CID] = card.cardID
		data[goTapAPI.Constants.Key.CTP] = card.cardType.stringRepresentation

		return goTapAPI.Client.sharedInstance.dataSource!.encryptDictionary(data)
	}
}