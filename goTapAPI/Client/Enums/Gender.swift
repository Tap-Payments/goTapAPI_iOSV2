public class Gender: goTapAPI.Enum {

	public static let Unspecified = goTapAPI.Gender(rawValue: 0)
	public static let Male = goTapAPI.Gender(rawValue: 1)
	public static let Female = goTapAPI.Gender(rawValue: 2)

	internal var stringRepresentation: String {

			if self == Gender.Male {

			return goTapAPI.Constants.Value.MALE
		}
		else  if self == Gender.Female {

			return goTapAPI.Constants.Value.FEMALE
		}
		else {

			return String.tap_empty
		}
	}
}
