/// API client data source.
public protocol ClientDataSource {

	func applicationBuildString() -> String
	func countryNameFor(_ isoCountryCode: String) -> String?
	func countryWith(_ isdNumber: String) -> goTapAPI.Country?
	func deviceModel() -> String
	func deviceName() -> String
	func deviceValue() -> String
	func encryptDictionary(_ dictionary: [String: String]) -> String
	func encryptError(_ error: goTapAPI.APIError) -> String
	func encryptString(_ string: String?) -> String
	func languageCode() -> String
	func localizedDeviceModel() -> String
	func localizedString(forKey key: String) -> String
	func mobileCountryCode() -> String?
	func mobileNetworkCode() -> String?
	func numberOfApplicationInstallations() -> Int64
	func operatingSystemName() -> String
	func operatingSystemVersion() -> String
	func preferredSystemLanguageCode() -> String
	func saveToKeychain(_ string: String?, forKey key: String)
	func saveToUserSettings(_ string: String?, forKey key: String)
	func shouldUseProductionServer() -> Bool
	func stringFromKeychain(forKey key: String) -> String?
	func stringFromUserSettings(forKey key: String) -> String?
	func userInterfaceIdiom() -> goTapAPI.UserInterfaceIdiom
	func isSharingOptionAvailable(_ sharingOption: goTapAPI.SharingOption) -> Bool

	
	func decryptDictionary(_ string: String) -> [String: String]
	func selfDecryptDictionary(_ string: String) -> [String: String]
	func errorDescription(for errorCode: Int64) -> ErrorDescription?
	
}