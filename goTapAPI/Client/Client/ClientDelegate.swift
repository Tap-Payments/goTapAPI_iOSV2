
/// API client delegate.
public protocol ClientDelegate {

	func handleAction(_ action: TPAction, responseData: Response, error: APIError?)
}

