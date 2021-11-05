internal class MappedTPColorExtension {

	internal static func equal(color1: UIColor?, color2: UIColor?) -> Swift.Bool {
	
		guard let nonnullColor1 = color1, let nonnullColor2 = color2 else {
		 
			return color1 == nil && color2 == nil
		}
		
		
		return nonnullColor1.isEqual(nonnullColor2)
		
	}
}