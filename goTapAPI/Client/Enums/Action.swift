public class TPAction: Option {

	public static let None						 = TPAction(rawValue: 1 << 0)
	public static let TopAlert					 = TPAction(rawValue: 1 << 1)
	public static let HideTopAlert				 = TPAction(rawValue: 1 << 2)
	public static let Popup						= TPAction(rawValue: 1 << 3)
	public static let PopupWithReportButton		= TPAction(rawValue: 1 << 4)
	public static let Logout					   = TPAction(rawValue: 1 << 5)
	public static let OpenCountryUnavailableScreen = TPAction(rawValue: 1 << 6)
	public static let BlockUI					  = TPAction(rawValue: 1 << 7)
}
