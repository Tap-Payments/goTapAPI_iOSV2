//
//  Created by Dennis Pashkov on 12/1/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 *  Card brand enum.
 */
public class CardBrand: Enum {

	public static let Unknown           = CardBrand(rawValue:  0)

	public static let AiywaLoyalty      = CardBrand(rawValue:  1)
	public static let AmericanExpress   = CardBrand(rawValue:  2)
	public static let BENEFIT           = CardBrand(rawValue:  3)
	public static let CardGuard         = CardBrand(rawValue:  4)
	public static let CBK               = CardBrand(rawValue:  5)
	public static let Dankort           = CardBrand(rawValue:  6)
	public static let DinersClub        = CardBrand(rawValue:  7)
	public static let Discover          = CardBrand(rawValue:  8)
	public static let FAWRY             = CardBrand(rawValue:  9)
	public static let InstaPayment      = CardBrand(rawValue: 10)
	public static let InterPayment      = CardBrand(rawValue: 11)
	public static let JCB               = CardBrand(rawValue: 12)
	public static let KNET              = CardBrand(rawValue: 13)
	public static let MADA              = CardBrand(rawValue: 14)
	public static let Maestro           = CardBrand(rawValue: 15)
	public static let MasterCard        = CardBrand(rawValue: 16)
	public static let NAPS              = CardBrand(rawValue: 17)
	public static let NSPKMIR           = CardBrand(rawValue: 18)
	public static let SADAD             = CardBrand(rawValue: 19)
	public static let Tap               = CardBrand(rawValue: 20)
	public static let UATP              = CardBrand(rawValue: 21)
	public static let UnionPay          = CardBrand(rawValue: 22)
	public static let Verve             = CardBrand(rawValue: 23)
	public static let Visa              = CardBrand(rawValue: 24)
	public static let Viva              = CardBrand(rawValue: 25)
	public static let Wataniya          = CardBrand(rawValue: 26)
	public static let Zain              = CardBrand(rawValue: 27)

	public var localizedTitle: String {

		guard let datasource = Client.sharedInstance.dataSource else { return String.tap_empty }

		if self == CardBrand.AiywaLoyalty {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.AiywaLoyalty)
		}
		else if self == CardBrand.AmericanExpress {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.AmericanExpress)
		}
		else if self == CardBrand.BENEFIT {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.BENEFIT)
		}
		else if self == CardBrand.CardGuard {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.CardGuard)
		}
		else if self == CardBrand.CBK {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.CBK)
		}
		else if self == CardBrand.Dankort {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.Dankort)
		}
		else if self == CardBrand.DinersClub {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.DinersClub)
		}
		else if self == CardBrand.Discover {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.Discover)
		}
		else if self == CardBrand.FAWRY {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.FAWRY)
		}
		else if self == CardBrand.InstaPayment {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.InstaPayment)
		}
		else if self == CardBrand.InterPayment {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.InterPayment)
		}
		else if self == CardBrand.JCB {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.JCB)
		}
		else if self == CardBrand.KNET {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.KNET)
		}
		else if self == CardBrand.MADA {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.MADA)
		}
		else if self == CardBrand.Maestro {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.Maestro)
		}
		else if self == CardBrand.MasterCard {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.MasterCard)
		}
		else if self == CardBrand.NAPS {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.NAPS)
		}
		else if self == CardBrand.NSPKMIR {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.NSPKMIR)
		}
		else if self == CardBrand.SADAD {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.SADAD)
		}
		else if self == CardBrand.Tap {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.Tap)
		}
		else if self == CardBrand.UATP {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.UATP)
		}
		else if self == CardBrand.UnionPay {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.UnionPay)
		}
		else if self == CardBrand.Verve {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.Verve)
		}
		else if self == CardBrand.Visa {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.Visa)
		}
		else if self == CardBrand.Viva {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.Viva)
		}
		else if self == CardBrand.Wataniya {

			return datasource.localizedString(forKey: Constants.Key.Localization.CardBrand.Wataniya)
		}
		else if self == CardBrand.Zain {

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
	internal static func with(stringValue: String?) -> CardBrand? {

		guard let string = stringValue else {

			return nil
		}

		switch string {

			case Constants.Value.Aiywa_Loyalty:

				return CardBrand.AiywaLoyalty

			case Constants.Value.AMEX:

				return CardBrand.AmericanExpress

			case Constants.Value.BENEFIT:

				return CardBrand.BENEFIT

			case Constants.Value.CARDGUARD:

				return CardBrand.CardGuard

			case Constants.Value.CBK:

				return CardBrand.CBK

			case Constants.Value.DANKORT:

				return CardBrand.Dankort

			case Constants.Value.DINERS:

				return CardBrand.DinersClub

			case Constants.Value.DISCOVER:

				return CardBrand.Discover

			case Constants.Value.FAWRY:

				return CardBrand.FAWRY

			case Constants.Value.INSTAPAY:

				return CardBrand.InstaPayment

			case Constants.Value.INTERPAY:

				return CardBrand.InterPayment

			case Constants.Value.JCB:

				return CardBrand.JCB

			case Constants.Value.KNET:

				return CardBrand.KNET

			case Constants.Value.MADA:

				return CardBrand.MADA

			case Constants.Value.MAESTRO:

				return CardBrand.Maestro

			case Constants.Value.MASTERCARD:

				return CardBrand.MasterCard

			case Constants.Value.NAPS:

				return CardBrand.NAPS

			case Constants.Value.NSPK:

				return CardBrand.NSPKMIR

			case Constants.Value.SADAD:

				return CardBrand.SADAD

			case Constants.Value.TAP:

				return CardBrand.Tap

			case Constants.Value.UATP:

				return CardBrand.UATP

			case Constants.Value.UNIONPAY:

				return CardBrand.UnionPay

			case Constants.Value.VERVE:

				return CardBrand.Verve

			case Constants.Value.VISA:

				return CardBrand.Visa

			case Constants.Value.Viva_PAY:

				return CardBrand.Viva

			case Constants.Value.Wataniya_PAY:

				return CardBrand.Wataniya

			case Constants.Value.Zain_PAY:

				return CardBrand.Zain

			default:

				return nil
		}
	}
}
