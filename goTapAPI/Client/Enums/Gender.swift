public class Gender: Enum {

	public static let Unspecified = Gender(rawValue: 0)
	public static let Male = Gender(rawValue: 1)
	public static let Female = Gender(rawValue: 2)

	internal var stringRepresentation: String {

			if self == Gender.Male {

			return Constants.Value.MALE
		}
		else  if self == Gender.Female {

			return Constants.Value.FEMALE
		}
		else {

			return String.tap_empty
		}
	}
}
