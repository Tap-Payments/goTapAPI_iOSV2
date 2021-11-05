public class PendingRecordAction: goTapAPI.Enum {

	public static let Add = goTapAPI.PendingRecordAction(rawValue: 0)
	public static let Update = goTapAPI.PendingRecordAction(rawValue: 1)
	public static let Delete = goTapAPI.PendingRecordAction(rawValue: 2)

	/// Returns string representation of the receiver.
	internal var stringRepresentation: String {

			if self == PendingRecordAction.Add {

			return goTapAPI.Constants.Value.A
		}
		else  if self == PendingRecordAction.Update {

			return goTapAPI.Constants.Value.U
		}
		else  if self == PendingRecordAction.Delete {

			return goTapAPI.Constants.Value.D
		}

		return String.tap_empty
	}
}
