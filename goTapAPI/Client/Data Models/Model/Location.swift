public class Location: NSObject {

	//MARK: - Public -
	//MARK: Properties
	
	public private(set) var latitude: Double = 0.0
	public private(set) var longitude: Double = 0.0
	
	//MARK: Methods
	
	public init(latitude: Double, longitude: Double) {
		
		self.latitude = latitude
		self.longitude = longitude
	}
}