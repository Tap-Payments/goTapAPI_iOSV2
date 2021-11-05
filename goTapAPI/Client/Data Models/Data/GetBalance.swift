public class GetBalance: goTapAPI.DataModel {

	// MARK: - Public -
	// MARK: Properties

	/// GSM number.
	public private(set) var gsmNumber: String?

	/// to: field of SMS content.
	public private(set) var smsToSender: String?

	/// SMS content.
	public private(set) var smsContent: String?

	/// Number to dial.
	public private(set) var dialNumber: String?

	/// USSD code.
	public private(set) var ussdCode: String?

	// MARK: - Internal -
	// MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.GetBalance else { return nil }

		model.gsmNumber = dictionary.parseString(forKey: goTapAPI.Constants.Key.gsm_number)
		model.smsToSender = dictionary.parseString(forKey: goTapAPI.Constants.Key.sms_to_sender)
		model.smsContent = dictionary.parseString(forKey: goTapAPI.Constants.Key.sms_content)
		model.dialNumber = dictionary.parseString(forKey: goTapAPI.Constants.Key.dial_number)
		model.ussdCode = dictionary.parseString(forKey: goTapAPI.Constants.Key.ussd_code)

		return model.tap_asSelf()
	}
}
