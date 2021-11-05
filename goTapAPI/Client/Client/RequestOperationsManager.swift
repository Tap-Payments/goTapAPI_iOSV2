public protocol RequestOperationsManager {

	func performRequest<T>(operation op: goTapAPI.RequestOperation, completion: (goTapAPI.RequestCompletionClosure<T>)?) where T: goTapAPI.ResponseHolder
}