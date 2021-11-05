public class TPAction: goTapAPI.Option {

	public static let None						 = goTapAPI.TPAction(rawValue: 1 << 0)
	public static let TopAlert					 = goTapAPI.TPAction(rawValue: 1 << 1)
	public static let HideTopAlert				 = goTapAPI.TPAction(rawValue: 1 << 2)
	public static let Popup						= goTapAPI.TPAction(rawValue: 1 << 3)
	public static let PopupWithReportButton		= goTapAPI.TPAction(rawValue: 1 << 4)
	public static let Logout					   = goTapAPI.TPAction(rawValue: 1 << 5)
	public static let OpenCountryUnavailableScreen = goTapAPI.TPAction(rawValue: 1 << 6)
	public static let BlockUI					  = goTapAPI.TPAction(rawValue: 1 << 7)
}