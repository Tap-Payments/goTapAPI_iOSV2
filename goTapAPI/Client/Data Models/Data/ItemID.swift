public class ItemID: DataModel {

	//MARK: - Public -
	//MARK: Properties

	internal private(set) var businessID: Int64 = 0

	internal private(set) var identifier: Int64 = 0

	internal private(set) var itemType: String = String.tap_empty

	internal override var serializedModel: AnyObject? {

		let result: [String: Any] = [

			Constants.Key.BizID: self.businessID,
			Constants.Key.ID: self.identifier,
			Constants.Key.ItemType: self.itemType
		]

		return result as AnyObject
	}

	//MARK: Methods

	public required init() { super.init() }

	internal convenience init(businessID: Int64, identifier: Int64, itemType: String) {

		self.init()

		self.businessID = businessID
		self.identifier = identifier
		self.itemType = itemType
	}
}
