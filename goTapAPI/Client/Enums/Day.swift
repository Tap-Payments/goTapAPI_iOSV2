/// Enum to represent the day of the week.
public class Day: goTapAPI.Enum {

	// MARK: - Public -
	// MARK: Properties

	/// Sunday.
	public static let sunday = goTapAPI.Day(rawValue: 1)

	/// Monday.
	public static let monday = goTapAPI.Day(rawValue: 2)

	/// Tuesday.
	public static let tuesday = goTapAPI.Day(rawValue: 3)

	/// Wednesday.
	public static let wednesday = goTapAPI.Day(rawValue: 4)

	/// Thursday.
	public static let thursday = goTapAPI.Day(rawValue: 5)

	/// Friday
	public static let friday = goTapAPI.Day(rawValue: 6)

	/// Saturday
	public static let saturday = goTapAPI.Day(rawValue: 7)

	// MARK: - Internal -
	// MARK: Properties

	/// String representation of the receiver.
	internal var stringRepresentation: String {

			if self == Day.sunday {

			return goTapAPI.Constants.Value.SUN
		}
		else  if self == Day.monday {

			return goTapAPI.Constants.Value.MON
		}
		else  if self == Day.tuesday {

			return goTapAPI.Constants.Value.TUE
		}
		else  if self == Day.wednesday {

			return goTapAPI.Constants.Value.WED
		}
		else  if self == Day.thursday {

			return goTapAPI.Constants.Value.THU
		}
		else  if self == Day.friday {

			return goTapAPI.Constants.Value.FRI
		}
		else {

			return goTapAPI.Constants.Value.SAT
		}
	}

	// MARK: Methods

	internal static func with(integerValue intValue: Int64?) -> goTapAPI.Day? {

		guard let value = intValue else { return nil }

		if value == 1 {

			return goTapAPI.Day.sunday
		}
		else if value == 2 {

			return goTapAPI.Day.monday
		}
		else if value == 3 {

			return goTapAPI.Day.tuesday
		}
		else if value == 4 {

			return goTapAPI.Day.wednesday
		}
		else if value == 5 {

			return goTapAPI.Day.thursday
		}
		else if value == 6 {

			return goTapAPI.Day.friday
		}
		else if value == 7 {

			return goTapAPI.Day.saturday
		}
		else {

			return nil
		}
	}
}