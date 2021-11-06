public class AddressBookPerson {

	//MARK: - Public -
	//MARK: Properties

	public var addresses: [String: [String: String]]?
	public var birthday: Double?
	public var department: String?
	public var emailAddresses: [String: String]?
	public var firstName: String?
	public var imageDataBase64String: String?
	public var instantMessages: [String: [String: String]]?
	public var jobTitle: String?
	public var lastName: String?
	public var middleName: String?
	public var organizationName: String?
	public var phones: [String: String]?
	public var namePrefix: String?
	public var recordID: String = String.tap_empty
	public var relatedNames: [String: String]?
	public var socialProfiles: [String: [String: String]]?
	public var nameSuffix: String?
	public var urls: [String: String]?

	public var jsonString: String {

		var model: [String: Any] = [Constants.Key.RecordID: recordID]

		if let nonnullAddresses = self.addresses, nonnullAddresses.count > 0 {

			model[Constants.Key.Addresses] = nonnullAddresses
		}

		if let nonnullBirthday = self.birthday {

			model[Constants.Key.Birthday] = nonnullBirthday
		}

		if let nonnullDepartment = self.department {

			model[Constants.Key.Department] = nonnullDepartment
		}

		if let nonnullEmailAddresses = self.emailAddresses, nonnullEmailAddresses.count > 0 {

			model[Constants.Key.EmailAddresses] = nonnullEmailAddresses
		}

		if let nonnullFirstName = self.firstName, !nonnullFirstName.isEmpty {

			model[Constants.Key.FirstName] = nonnullFirstName
		}

		if let nonnullImageDataString = self.imageDataBase64String, !nonnullImageDataString.isEmpty {

			model[Constants.Key.ImageData] = nonnullImageDataString
		}

		if let nonnullInstantMessages = self.instantMessages, nonnullInstantMessages.count > 0 {

			model[Constants.Key.InstantMessages] = nonnullInstantMessages
		}

		if let nonnullJobTitle = self.jobTitle, !nonnullJobTitle.isEmpty {

			model[Constants.Key.JobTitle] = nonnullJobTitle
		}

		if let nonnullLastName = self.lastName, !nonnullLastName.isEmpty {

			model[Constants.Key.LastName] = nonnullLastName
		}

		if let nonnullMiddleName = self.middleName, !nonnullMiddleName.isEmpty {

			model[Constants.Key.MiddleName] = nonnullMiddleName
		}

		if let nonnullOrganizationName = self.organizationName, !nonnullOrganizationName.isEmpty {

			model[Constants.Key.OrganizationName] = nonnullOrganizationName
		}

		if let nonnullPhones = self.phones, nonnullPhones.count > 0 {

			model[Constants.Key.Phones] = nonnullPhones
		}

		if let nonnullNamePrefix = self.namePrefix, !nonnullNamePrefix.isEmpty {

			model[Constants.Key.Prefix] = nonnullNamePrefix
		}

		if let nonnullRelatedNames = self.relatedNames, nonnullRelatedNames.count > 0 {

			model[Constants.Key.RelatedNames] = nonnullRelatedNames
		}

		if let nonnullSocialProfiles = self.socialProfiles, nonnullSocialProfiles.count > 0 {

			model[Constants.Key.SocialProfiles] = nonnullSocialProfiles
		}

		if let nonnullNameSuffix = self.nameSuffix, !nonnullNameSuffix.isEmpty {

			model[Constants.Key.Suffix] = nonnullNameSuffix
		}

		if let nonnullURLs = self.urls, nonnullURLs.count > 0 {

			model[Constants.Key.URLs] = nonnullURLs
		}

		return model.jsonString
	}
}
