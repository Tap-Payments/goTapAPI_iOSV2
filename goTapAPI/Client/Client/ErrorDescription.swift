

/// Error Description Interface.
public protocol ErrorDescription {
	
	//MARK: - Public -
	//MARK: Properties
	
	/// Error title.
	var title: String { get }
	
	/// Error message.
	var message: String { get }
	
	/// Defines if code should be shown.
	var showCode: Bool { get }
	
	/// Error action.
	var action: TPAction { get }
	
	/// Error code.
	var code: Int64 { get }
}

