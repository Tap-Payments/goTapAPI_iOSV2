//
//  Created by Dennis Pashkov on 12/1/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 *  Card brand enum.
 */
public class TapApiCardBrand: Enum {

	public static let Unknown           = TapApiCardBrand(rawValue:  0)

	public static let AiywaLoyalty      = TapApiCardBrand(rawValue:  1)
	public static let AmericanExpress   = TapApiCardBrand(rawValue:  2)
	public static let BENEFIT           = TapApiCardBrand(rawValue:  3)
	public static let CardGuard         = TapApiCardBrand(rawValue:  4)
	public static let CBK               = TapApiCardBrand(rawValue:  5)
	public static let Dankort           = TapApiCardBrand(rawValue:  6)
	public static let DinersClub        = TapApiCardBrand(rawValue:  7)
	public static let Discover          = TapApiCardBrand(rawValue:  8)
	public static let FAWRY             = TapApiCardBrand(rawValue:  9)
	public static let InstaPayment      = TapApiCardBrand(rawValue: 10)
	public static let InterPayment      = TapApiCardBrand(rawValue: 11)
	public static let JCB               = TapApiCardBrand(rawValue: 12)
	public static let KNET              = TapApiCardBrand(rawValue: 13)
	public static let MADA              = TapApiCardBrand(rawValue: 14)
	public static let Maestro           = TapApiCardBrand(rawValue: 15)
	public static let MasterCard        = TapApiCardBrand(rawValue: 16)
	public static let NAPS              = TapApiCardBrand(rawValue: 17)
	public static let NSPKMIR           = TapApiCardBrand(rawValue: 18)
	public static let SADAD             = TapApiCardBrand(rawValue: 19)
	public static let Tap               = TapApiCardBrand(rawValue: 20)
	public static let UATP              = TapApiCardBrand(rawValue: 21)
	public static let UnionPay          = TapApiCardBrand(rawValue: 22)
	public static let Verve             = TapApiCardBrand(rawValue: 23)
	public static let Visa              = TapApiCardBrand(rawValue: 24)
	public static let Viva              = TapApiCardBrand(rawValue: 25)
	public static let Wataniya          = TapApiCardBrand(rawValue: 26)
	public static let Zain              = TapApiCardBrand(rawValue: 27)

	public var localizedTitle: String {

		guard let datasource = Client.sharedInstance.dataSource else { return String.tap_empty }

		if self == TapApiCardBrand.AiywaLoyalty {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.AiywaLoyalty)
		}
		else if self == TapApiCardBrand.AmericanExpress {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.AmericanExpress)
		}
		else if self == TapApiCardBrand.BENEFIT {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.BENEFIT)
		}
		else if self == TapApiCardBrand.CardGuard {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.CardGuard)
		}
		else if self == TapApiCardBrand.CBK {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.CBK)
		}
		else if self == TapApiCardBrand.Dankort {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.Dankort)
		}
		else if self == TapApiCardBrand.DinersClub {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.DinersClub)
		}
		else if self == TapApiCardBrand.Discover {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.Discover)
		}
		else if self == TapApiCardBrand.FAWRY {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.FAWRY)
		}
		else if self == TapApiCardBrand.InstaPayment {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.InstaPayment)
		}
		else if self == TapApiCardBrand.InterPayment {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.InterPayment)
		}
		else if self == TapApiCardBrand.JCB {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.JCB)
		}
		else if self == TapApiCardBrand.KNET {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.KNET)
		}
		else if self == TapApiCardBrand.MADA {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.MADA)
		}
		else if self == TapApiCardBrand.Maestro {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.Maestro)
		}
		else if self == TapApiCardBrand.MasterCard {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.MasterCard)
		}
		else if self == TapApiCardBrand.NAPS {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.NAPS)
		}
		else if self == TapApiCardBrand.NSPKMIR {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.NSPKMIR)
		}
		else if self == TapApiCardBrand.SADAD {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.SADAD)
		}
		else if self == TapApiCardBrand.Tap {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.Tap)
		}
		else if self == TapApiCardBrand.UATP {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.UATP)
		}
		else if self == TapApiCardBrand.UnionPay {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.UnionPay)
		}
		else if self == TapApiCardBrand.Verve {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.Verve)
		}
		else if self == TapApiCardBrand.Visa {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.Visa)
		}
		else if self == TapApiCardBrand.Viva {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.Viva)
		}
		else if self == TapApiCardBrand.Wataniya {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.Wataniya)
		}
		else if self == TapApiCardBrand.Zain {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.Zain)
		}
		else {

			return String.tap_empty
		}
	}

	/**
	 Initializes enum from string.

	 - parameter string: String representation of enum.

	 - returns: CardBrand.
	 */
	internal static func with(stringValue: String?) -> TapApiCardBrand? {

		guard let string = stringValue else {

			return nil
		}

		switch string {

			case Constants.Value.Aiywa_Loyalty:

				return TapApiCardBrand.AiywaLoyalty

			case Constants.Value.AMEX:

				return TapApiCardBrand.AmericanExpress

			case Constants.Value.BENEFIT:

				return TapApiCardBrand.BENEFIT

			case Constants.Value.CARDGUARD:

				return TapApiCardBrand.CardGuard

			case Constants.Value.CBK:

				return TapApiCardBrand.CBK

			case Constants.Value.DANKORT:

				return TapApiCardBrand.Dankort

			case Constants.Value.DINERS:

				return TapApiCardBrand.DinersClub

			case Constants.Value.DISCOVER:

				return TapApiCardBrand.Discover

			case Constants.Value.FAWRY:

				return TapApiCardBrand.FAWRY

			case Constants.Value.INSTAPAY:

				return TapApiCardBrand.InstaPayment

			case Constants.Value.INTERPAY:

				return TapApiCardBrand.InterPayment

			case Constants.Value.JCB:

				return TapApiCardBrand.JCB

			case Constants.Value.KNET:

				return TapApiCardBrand.KNET

			case Constants.Value.MADA:

				return TapApiCardBrand.MADA

			case Constants.Value.MAESTRO:

				return TapApiCardBrand.Maestro

			case Constants.Value.MASTERCARD:

				return TapApiCardBrand.MasterCard

			case Constants.Value.NAPS:

				return TapApiCardBrand.NAPS

			case Constants.Value.NSPK:

				return TapApiCardBrand.NSPKMIR

			case Constants.Value.SADAD:

				return TapApiCardBrand.SADAD

			case Constants.Value.TAP:

				return TapApiCardBrand.Tap

			case Constants.Value.UATP:

				return TapApiCardBrand.UATP

			case Constants.Value.UNIONPAY:

				return TapApiCardBrand.UnionPay

			case Constants.Value.VERVE:

				return TapApiCardBrand.Verve

			case Constants.Value.VISA:

				return TapApiCardBrand.Visa

			case Constants.Value.Viva_PAY:

				return TapApiCardBrand.Viva

			case Constants.Value.Wataniya_PAY:

				return TapApiCardBrand.Wataniya

			case Constants.Value.Zain_PAY:

				return TapApiCardBrand.Zain

			default:

				return nil
		}
	}
}
