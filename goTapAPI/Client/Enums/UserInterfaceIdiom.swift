public class UserInterfaceIdiom: Enum {

	public static let Phone = UserInterfaceIdiom(rawValue: 0)
	public static let Tablet = UserInterfaceIdiom(rawValue: 1)
	public static let Other = UserInterfaceIdiom(rawValue: 2)
	
	internal var stringRepresentation: String {
	 
			if self == UserInterfaceIdiom.Phone {
				
			return Constants.Value.Phone
		}
		else  if self == UserInterfaceIdiom.Tablet {
				
			return Constants.Value.Tablet
		}
		else  if self == UserInterfaceIdiom.Other {
				
			return Constants.Value.Unspecified
		}
		
		return Constants.Value.Unspecified
	}
}
