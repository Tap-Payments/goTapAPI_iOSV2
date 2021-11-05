public class PendingRecord {

	//MARK: - Public -
	//MARK: Properties

	public private(set) var recordID: String
	public private(set) var action: goTapAPI.PendingRecordAction

	//MARK: Methods

	public init(recordID: String, action: goTapAPI.PendingRecordAction) {

		self.recordID = recordID
		self.action = action
	}
}