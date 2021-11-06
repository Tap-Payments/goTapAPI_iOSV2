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
public class Purpose: Enum {

	public static let Share = Purpose(rawValue: 0)
	public static let Video = Purpose(rawValue: 1)

	/// Returns string representation of the receiver.
	internal var stringRepresentation: String {

			if self == Purpose.Share {

			return Constants.Value.Share
		}
		else  if self == Purpose.Video {

			return Constants.Value.Video
		}

		return String.tap_empty
	}

	/**
	 Initializes enum value from its string representation.

	 - parameter string: String representation.

	 - returns: TPAPIPurpose
	 */
	internal static func with(stringValue: String?) -> Purpose {

		guard let string = stringValue else {

			return Purpose.Video
		}

		switch string {

		case Constants.Value.Video:

			return Purpose.Video

		case Constants.Value.Share:

			return Purpose.Share

		default:

			return Purpose.Video
		}
	}
}
