//
//  Created by Dennis Pashkov on 12/1/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 *  Card brand enum.
 */
public class CardBrand: goTapAPI.Enum {

	public static let Unknown           = goTapAPI.CardBrand(rawValue:  0)

	public static let AiywaLoyalty      = goTapAPI.CardBrand(rawValue:  1)
	public static let AmericanExpress   = goTapAPI.CardBrand(rawValue:  2)
	public static let BENEFIT           = goTapAPI.CardBrand(rawValue:  3)
	public static let CardGuard         = goTapAPI.CardBrand(rawValue:  4)
	public static let CBK               = goTapAPI.CardBrand(rawValue:  5)
	public static let Dankort           = goTapAPI.CardBrand(rawValue:  6)
	public static let DinersClub        = goTapAPI.CardBrand(rawValue:  7)
	public static let Discover          = goTapAPI.CardBrand(rawValue:  8)
	public static let FAWRY             = goTapAPI.CardBrand(rawValue:  9)
	public static let InstaPayment      = goTapAPI.CardBrand(rawValue: 10)
	public static let InterPayment      = goTapAPI.CardBrand(rawValue: 11)
	public static let JCB               = goTapAPI.CardBrand(rawValue: 12)
	public static let KNET              = goTapAPI.CardBrand(rawValue: 13)
	public static let MADA              = goTapAPI.CardBrand(rawValue: 14)
	public static let Maestro           = goTapAPI.CardBrand(rawValue: 15)
	public static let MasterCard        = goTapAPI.CardBrand(rawValue: 16)
	public static let NAPS              = goTapAPI.CardBrand(rawValue: 17)
	public static let NSPKMIR           = goTapAPI.CardBrand(rawValue: 18)
	public static let SADAD             = goTapAPI.CardBrand(rawValue: 19)
	public static let Tap               = goTapAPI.CardBrand(rawValue: 20)
	public static let UATP              = goTapAPI.CardBrand(rawValue: 21)
	public static let UnionPay          = goTapAPI.CardBrand(rawValue: 22)
	public static let Verve             = goTapAPI.CardBrand(rawValue: 23)
	public static let Visa              = goTapAPI.CardBrand(rawValue: 24)
	public static let Viva              = goTapAPI.CardBrand(rawValue: 25)
	public static let Wataniya          = goTapAPI.CardBrand(rawValue: 26)
	public static let Zain              = goTapAPI.CardBrand(rawValue: 27)

	public var localizedTitle: String {

		guard let datasource = goTapAPI.Client.sharedInstance.dataSource else { return String.tap_empty }

		if self == goTapAPI.CardBrand.AiywaLoyalty {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.AiywaLoyalty)
		}
		else if self == goTapAPI.CardBrand.AmericanExpress {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.AmericanExpress)
		}
		else if self == goTapAPI.CardBrand.BENEFIT {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.BENEFIT)
		}
		else if self == goTapAPI.CardBrand.CardGuard {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.CardGuard)
		}
		else if self == goTapAPI.CardBrand.CBK {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.CBK)
		}
		else if self == goTapAPI.CardBrand.Dankort {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.Dankort)
		}
		else if self == goTapAPI.CardBrand.DinersClub {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.DinersClub)
		}
		else if self == goTapAPI.CardBrand.Discover {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.Discover)
		}
		else if self == goTapAPI.CardBrand.FAWRY {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.FAWRY)
		}
		else if self == goTapAPI.CardBrand.InstaPayment {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.InstaPayment)
		}
		else if self == goTapAPI.CardBrand.InterPayment {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.InterPayment)
		}
		else if self == goTapAPI.CardBrand.JCB {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.JCB)
		}
		else if self == goTapAPI.CardBrand.KNET {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.KNET)
		}
		else if self == goTapAPI.CardBrand.MADA {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.MADA)
		}
		else if self == goTapAPI.CardBrand.Maestro {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.Maestro)
		}
		else if self == goTapAPI.CardBrand.MasterCard {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.MasterCard)
		}
		else if self == goTapAPI.CardBrand.NAPS {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.NAPS)
		}
		else if self == goTapAPI.CardBrand.NSPKMIR {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.NSPKMIR)
		}
		else if self == goTapAPI.CardBrand.SADAD {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.SADAD)
		}
		else if self == goTapAPI.CardBrand.Tap {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.Tap)
		}
		else if self == goTapAPI.CardBrand.UATP {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.UATP)
		}
		else if self == goTapAPI.CardBrand.UnionPay {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.UnionPay)
		}
		else if self == goTapAPI.CardBrand.Verve {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.Verve)
		}
		else if self == goTapAPI.CardBrand.Visa {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.Visa)
		}
		else if self == goTapAPI.CardBrand.Viva {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.Viva)
		}
		else if self == goTapAPI.CardBrand.Wataniya {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.Wataniya)
		}
		else if self == goTapAPI.CardBrand.Zain {

			return datasource.localizedString(forKey: goTapAPI.Constants.Key.Localization.CardBrand.Zain)
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
	internal static func with(stringValue: String?) -> goTapAPI.CardBrand? {

		guard let string = stringValue else {

			return nil
		}

		switch string {

			case goTapAPI.Constants.Value.Aiywa_Loyalty:

				return goTapAPI.CardBrand.AiywaLoyalty

			case goTapAPI.Constants.Value.AMEX:

				return goTapAPI.CardBrand.AmericanExpress

			case goTapAPI.Constants.Value.BENEFIT:

				return goTapAPI.CardBrand.BENEFIT

			case goTapAPI.Constants.Value.CARDGUARD:

				return goTapAPI.CardBrand.CardGuard

			case goTapAPI.Constants.Value.CBK:

				return goTapAPI.CardBrand.CBK

			case goTapAPI.Constants.Value.DANKORT:

				return goTapAPI.CardBrand.Dankort

			case goTapAPI.Constants.Value.DINERS:

				return goTapAPI.CardBrand.DinersClub

			case goTapAPI.Constants.Value.DISCOVER:

				return goTapAPI.CardBrand.Discover

			case goTapAPI.Constants.Value.FAWRY:

				return goTapAPI.CardBrand.FAWRY

			case goTapAPI.Constants.Value.INSTAPAY:

				return goTapAPI.CardBrand.InstaPayment

			case goTapAPI.Constants.Value.INTERPAY:

				return goTapAPI.CardBrand.InterPayment

			case goTapAPI.Constants.Value.JCB:

				return goTapAPI.CardBrand.JCB

			case goTapAPI.Constants.Value.KNET:

				return goTapAPI.CardBrand.KNET

			case goTapAPI.Constants.Value.MADA:

				return goTapAPI.CardBrand.MADA

			case goTapAPI.Constants.Value.MAESTRO:

				return goTapAPI.CardBrand.Maestro

			case goTapAPI.Constants.Value.MASTERCARD:

				return goTapAPI.CardBrand.MasterCard

			case goTapAPI.Constants.Value.NAPS:

				return goTapAPI.CardBrand.NAPS

			case goTapAPI.Constants.Value.NSPK:

				return goTapAPI.CardBrand.NSPKMIR

			case goTapAPI.Constants.Value.SADAD:

				return goTapAPI.CardBrand.SADAD

			case goTapAPI.Constants.Value.TAP:

				return goTapAPI.CardBrand.Tap

			case goTapAPI.Constants.Value.UATP:

				return goTapAPI.CardBrand.UATP

			case goTapAPI.Constants.Value.UNIONPAY:

				return goTapAPI.CardBrand.UnionPay

			case goTapAPI.Constants.Value.VERVE:

				return goTapAPI.CardBrand.Verve

			case goTapAPI.Constants.Value.VISA:

				return goTapAPI.CardBrand.Visa

			case goTapAPI.Constants.Value.Viva_PAY:

				return goTapAPI.CardBrand.Viva

			case goTapAPI.Constants.Value.Wataniya_PAY:

				return goTapAPI.CardBrand.Wataniya

			case goTapAPI.Constants.Value.Zain_PAY:

				return goTapAPI.CardBrand.Zain

			default:

				return nil
		}
	}
}
