public class PendingRecord {

	//MARK: - Public -
	//MARK: Properties

	public private(set) var recordID: String
	public private(set) var action: PendingRecordAction

	//MARK: Methods

	public init(recordID: String, action: PendingRecordAction) {

		self.recordID = recordID
		self.action = action
	}
}
