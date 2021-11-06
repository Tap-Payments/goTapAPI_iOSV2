/// Enum to represent the day of the week.
public class Day: Enum {

	// MARK: - Public -
	// MARK: Properties

	/// Sunday.
	public static let sunday = Day(rawValue: 1)

	/// Monday.
	public static let monday = Day(rawValue: 2)

	/// Tuesday.
	public static let tuesday = Day(rawValue: 3)

	/// Wednesday.
	public static let wednesday = Day(rawValue: 4)

	/// Thursday.
	public static let thursday = Day(rawValue: 5)

	/// Friday
	public static let friday = Day(rawValue: 6)

	/// Saturday
	public static let saturday = Day(rawValue: 7)

	// MARK: - Internal -
	// MARK: Properties

	/// String representation of the receiver.
	internal var stringRepresentation: String {

			if self == Day.sunday {

			return Constants.Value.SUN
		}
		else  if self == Day.monday {

			return Constants.Value.MON
		}
		else  if self == Day.tuesday {

			return Constants.Value.TUE
		}
		else  if self == Day.wednesday {

			return Constants.Value.WED
		}
		else  if self == Day.thursday {

			return Constants.Value.THU
		}
		else  if self == Day.friday {

			return Constants.Value.FRI
		}
		else {

			return Constants.Value.SAT
		}
	}

	// MARK: Methods

	internal static func with(integerValue intValue: Int64?) -> Day? {

		guard let value = intValue else { return nil }

		if value == 1 {

			return Day.sunday
		}
		else if value == 2 {

			return Day.monday
		}
		else if value == 3 {

			return Day.tuesday
		}
		else if value == 4 {

			return Day.wednesday
		}
		else if value == 5 {

			return Day.thursday
		}
		else if value == 6 {

			return Day.friday
		}
		else if value == 7 {

			return Day.saturday
		}
		else {

			return nil
		}
	}
}
