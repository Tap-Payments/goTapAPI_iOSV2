public protocol RequestOperationsManager {

	func performRequest<T>(operation op: RequestOperation, completion: (RequestCompletionClosure<T>)?) where T: ResponseHolder
}
