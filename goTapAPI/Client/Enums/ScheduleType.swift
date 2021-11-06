/// Item Schedule Type.
public class ScheduleType: Enum {

	// MARK: - Public -
	// MARK: Properties

	/// Daily.
	public static let daily = ScheduleType(rawValue: 1)

	/// Weekly.
	public static let weekly = ScheduleType(rawValue: 2)

	/// Monthly.
	public static let monthly = ScheduleType(rawValue: 3)

	/// Yearly.
	public static let yearly = ScheduleType(rawValue: 4)

	// MARK: - Internal -
	// MARK: Properties

	/// String representation of the receiver.
	internal var stringRepresentation: String {

		if self == ScheduleType.daily {

			return Constants.Value.D
		}
		else if self == ScheduleType.weekly {

			return Constants.Value.W
		}
		else if self == ScheduleType.yearly {

			return Constants.Value.Y
		}
		else {

			return Constants.Value.M
		}
	}

	// MARK: Methods

	internal static func with(stringValue string: String?) -> ScheduleType? {

		guard let value = string else { return nil }

		if value == Constants.Value.D {

			return ScheduleType.daily
		}
		else if value == Constants.Value.W {

			return ScheduleType.weekly
		}
		else if value == Constants.Value.M {

			return ScheduleType.monthly
		}
		else if value == Constants.Value.Y {

			return ScheduleType.yearly
		}
		else {

			return nil
		}
	}
}
