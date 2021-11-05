//
//  ScheduleDate.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/5/17.
//  Copyright © 2017 Tap Payments. All rights reserved.
//

/// Schedule Date.
public class ScheduleDate {

	// MARK: - Public -
	// MARK: Properties

	/// Day in range 1..31 ( based on month ).
	public var day: Int64 = 1

	/// Month in range 1..12
	public var month: Int64 = 1

	public init() { }

	public static func ==(lhs: ScheduleDate, rhs: ScheduleDate) -> Bool {

		return lhs.day == rhs.day && lhs.month == rhs.month
	}
}