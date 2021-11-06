//
//  ScheduleSettings.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/5/17.
//  Copyright © 2017 Tap Payments. All rights reserved.
//

/// Schedule Settings
public class ScheduleSettings: DataModel {

	// MARK: - Public -
	// MARK: Properties

	/// Schedule type.
	public var type: ScheduleType = ScheduleType.monthly

	/// Schedule day of week.
	public var weekday: Day = Day.monday

	/// Schedule day of month.
	public var monthday: Int64 = 1

	/// Schedule date.
	public var date: ScheduleDate = ScheduleDate()

	/// Schedule amount.
	public var amount: Foundation.Decimal = Foundation.Decimal.zero

	// MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }

		guard let scheduleType = ScheduleType.with(stringValue: dictionary.parseString(forKey: Constants.Value.schedule_type)) else { return nil }

		let model = ScheduleSettings()
		model.type = scheduleType

		if scheduleType == ScheduleType.daily {

			return model.tap_asSelf()
		}
		else if scheduleType == ScheduleType.weekly {

			guard let day = Day.with(integerValue: dictionary.parseInteger(forKey: Constants.Value.schedule_value)) else { return nil }
			model.weekday = day

			return model.tap_asSelf()
		}
		else if scheduleType == ScheduleType.monthly {

			guard let day = dictionary.parseInteger(forKey: Constants.Value.schedule_value) else { return nil }
			guard 0 < day && day < 32 else { return nil }

			model.monthday = day

			return model.tap_asSelf()
		}
		else if scheduleType == ScheduleType.yearly {

			guard let monthDay = dictionary.parseInteger(forKey: Constants.Value.schedule_value) else { return nil }
			let month: Int64 = monthDay % 100
			guard (month > 0) && (month < 13) else { return nil }

			let day: Int64 = monthDay / 100
			guard (day > 0) && (day < 32) else { return nil }

			let scheduleDate = ScheduleDate()
			scheduleDate.day = day
			scheduleDate.month = month

			model.date = scheduleDate

			return model.tap_asSelf()
		}
		else {

			return nil
		}
	}

	public static func ==(lhs: ScheduleSettings, rhs: ScheduleSettings) -> Bool {

		guard lhs.type == rhs.type && lhs.amount == rhs.amount else { return false }

		if lhs.type == ScheduleType.daily {

			return true
		}
		else if lhs.type == ScheduleType.weekly {

			return lhs.weekday == rhs.weekday
		}
		else if lhs.type == ScheduleType.monthly {

			return lhs.monthday == rhs.monthday
		}
		else if lhs.type == ScheduleType.yearly {

			return lhs.date == rhs.date
		}
		else {

			return false
		}
	}
}
