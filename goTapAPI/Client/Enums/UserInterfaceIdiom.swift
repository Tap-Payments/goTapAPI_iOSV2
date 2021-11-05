public class UserInterfaceIdiom: goTapAPI.Enum {

	public static let Phone = goTapAPI.UserInterfaceIdiom(rawValue: 0)
	public static let Tablet = goTapAPI.UserInterfaceIdiom(rawValue: 1)
	public static let Other = goTapAPI.UserInterfaceIdiom(rawValue: 2)
	
	internal var stringRepresentation: String {
	 
			if self == UserInterfaceIdiom.Phone {
				
			return goTapAPI.Constants.Value.Phone
		}
		else  if self == UserInterfaceIdiom.Tablet {
				
			return goTapAPI.Constants.Value.Tablet
		}
		else  if self == UserInterfaceIdiom.Other {
				
			return goTapAPI.Constants.Value.Unspecified
		}
		
		return goTapAPI.Constants.Value.Unspecified
	}
}