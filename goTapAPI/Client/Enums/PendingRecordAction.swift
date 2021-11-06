public class PendingRecordAction: Enum {

	public static let Add = PendingRecordAction(rawValue: 0)
	public static let Update = PendingRecordAction(rawValue: 1)
	public static let Delete = PendingRecordAction(rawValue: 2)

	/// Returns string representation of the receiver.
	internal var stringRepresentation: String {

			if self == PendingRecordAction.Add {

			return Constants.Value.A
		}
		else  if self == PendingRecordAction.Update {

			return Constants.Value.U
		}
		else  if self == PendingRecordAction.Delete {

			return Constants.Value.D
		}

		return String.tap_empty
	}
}
