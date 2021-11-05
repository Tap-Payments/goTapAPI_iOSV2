@objc public protocol PaymentSerialization {

	func paymentAmount() -> Foundation.Decimal

	func paymentBusinessID() -> Int64

	func paymentName() -> String
	
	func paymentCurrencyCode() -> String

	func paymentProductImageURL() -> URL?
	
	func paymentSerializedModel() -> AnyObject
}