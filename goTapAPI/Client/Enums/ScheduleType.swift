/// Item Schedule Type.
public class ScheduleType: goTapAPI.Enum {

	// MARK: - Public -
	// MARK: Properties

	/// Daily.
	public static let daily = goTapAPI.ScheduleType(rawValue: 1)

	/// Weekly.
	public static let weekly = goTapAPI.ScheduleType(rawValue: 2)

	/// Monthly.
	public static let monthly = goTapAPI.ScheduleType(rawValue: 3)

	/// Yearly.
	public static let yearly = goTapAPI.ScheduleType(rawValue: 4)

	// MARK: - Internal -
	// MARK: Properties

	/// String representation of the receiver.
	internal var stringRepresentation: String {

		if self == goTapAPI.ScheduleType.daily {

			return goTapAPI.Constants.Value.D
		}
		else if self == goTapAPI.ScheduleType.weekly {

			return goTapAPI.Constants.Value.W
		}
		else if self == goTapAPI.ScheduleType.yearly {

			return goTapAPI.Constants.Value.Y
		}
		else {

			return goTapAPI.Constants.Value.M
		}
	}

	// MARK: Methods

	internal static func with(stringValue string: String?) -> goTapAPI.ScheduleType? {

		guard let value = string else { return nil }

		if value == goTapAPI.Constants.Value.D {

			return goTapAPI.ScheduleType.daily
		}
		else if value == goTapAPI.Constants.Value.W {

			return goTapAPI.ScheduleType.weekly
		}
		else if value == goTapAPI.Constants.Value.M {

			return goTapAPI.ScheduleType.monthly
		}
		else if value == goTapAPI.Constants.Value.Y {

			return goTapAPI.ScheduleType.yearly
		}
		else {

			return nil
		}
	}
}