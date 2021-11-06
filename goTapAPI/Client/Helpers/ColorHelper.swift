class ColorHelper {

	private static let hexSymbol: String = "#"
	private static let clearHexString: String = ColorHelper.hexSymbol + "00000000"

	static func argbHexStringFrom(RGB_RGBAHexString rgbaHexString: String?) -> String {
	
		guard var rgbaString = rgbaHexString else {
		 
			return clearHexString
		}
		
		if rgbaString.StartsWith(ColorHelper.hexSymbol) {
			
			rgbaString = rgbaString.Substring(Int64(ColorHelper.hexSymbol.Length))
		}
		
		let stringLength = rgbaString.Length
		
		switch stringLength {
			
			case 3, 4, 6, 8:
				
				break
				
			default:
					
				return clearHexString
		}
		
		let hasAlpha = (stringLength == 4 || stringLength == 8) ? true : false
		let componentLength: Int64 = (stringLength > 4 ) ? 2 : 1
		
		var r = rgbaString.Substring(loc: componentLength * 0, len: componentLength)
		var g = rgbaString.Substring(loc: componentLength * 1, len: componentLength)
		var b = rgbaString.Substring(loc: componentLength * 2, len: componentLength)
		var a = hasAlpha ? rgbaString.Substring(loc: componentLength * 3, len: componentLength) : componentLength == 2 ? "FF" : "F"
		
		if componentLength == 1 {
		 
			a += a
			r += r
			g += g
			b += b
		}
		
		return "\(ColorHelper.hexSymbol)\(a)\(r)\(g)\(b)"
	}
}
