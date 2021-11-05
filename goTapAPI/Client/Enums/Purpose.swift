//
//  Purpose.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/28/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 Request purpose.

 - Share: Share purpose.
 - Video: Video purpose.
 */
public class Purpose: goTapAPI.Enum {

	public static let Share = goTapAPI.Purpose(rawValue: 0)
	public static let Video = goTapAPI.Purpose(rawValue: 1)

	/// Returns string representation of the receiver.
	internal var stringRepresentation: String {

			if self == Purpose.Share {

			return goTapAPI.Constants.Value.Share
		}
		else  if self == Purpose.Video {

			return goTapAPI.Constants.Value.Video
		}

		return String.tap_empty
	}

	/**
	 Initializes enum value from its string representation.

	 - parameter string: String representation.

	 - returns: TPAPIPurpose
	 */
	internal static func with(stringValue: String?) -> goTapAPI.Purpose {

		guard let string = stringValue else {

			return goTapAPI.Purpose.Video
		}

		switch string {

		case goTapAPI.Constants.Value.Video:

			return goTapAPI.Purpose.Video

		case goTapAPI.Constants.Value.Share:

			return goTapAPI.Purpose.Share

		default:

			return goTapAPI.Purpose.Video
		}
	}
}
