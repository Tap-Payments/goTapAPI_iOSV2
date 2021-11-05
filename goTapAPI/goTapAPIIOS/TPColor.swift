import Foundation
import UIKit

public  class TPColor : UIKit.UIColor {

	
	
	public static func colorWith(_ hexString: String?) -> TPColor {
		
		let processedHexString = goTapAPI.ColorHelper.argbHexStringFrom(RGB_RGBAHexString: hexString) as Foundation.NSString
		
		var scanLocation = 1
		var componentIndex = 0
		var components: [CGFloat] = [0.0, 0.0, 0.0, 0.0]
		
		while scanLocation < processedHexString.length {
		 
			let componentScanString = (processedHexString as Foundation.NSString).substring(with: NSMakeRange(scanLocation, 2))
			var component: UInt64 = 0
			let scanner = Scanner(string:componentScanString)
			scanner.scanHexInt64(&component)
			components[componentIndex] = CGFloat(component) / 255.0
			
			scanLocation += 2
			componentIndex += 1
		}
		
		return TPColor(red: components[1], green: components[2], blue: components[3], alpha: components[0])
	}
}