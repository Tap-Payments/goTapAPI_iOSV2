
/// API client delegate.
public protocol ClientDelegate {

	func handleAction(_ action: goTapAPI.TPAction, responseData: goTapAPI.Response, error: goTapAPI.APIError?)
}

