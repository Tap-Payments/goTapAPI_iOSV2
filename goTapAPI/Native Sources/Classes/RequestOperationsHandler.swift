//
//  RequestOperationsHandler.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 9/30/16.
//  Copyright © 2016 Dennis Pashkov. All rights reserved.
//

import TapAdditionsKitV2
import TapNetworkManagerV2
import TapSwiftFixesV2

internal class RequestOperationsHandler: RequestOperationsManager {
    
    //MARK: - Internal -
    //MARK: Properties
    internal static let shared = RequestOperationsHandler()
    
    internal static var baseURL: URL {
        
        guard let dataSource = Client.sharedInstance.dataSource else {
            
            return URL(string: Constants.ServerURL.Test)!
        }
        
        if dataSource.shouldUseProductionServer() {
            
            return URL(string: Constants.ServerURL.Production)!
        }
        else {
            
            return URL(string: Constants.ServerURL.Test)!
        }
    }
    
    //MARK: Methods
    
    func performRequest<T>(operation op: RequestOperation, completion: ((T?, APIError?) -> Void)?) where T : ResponseHolder {
        
        DispatchQueue.global().async {
            
            self.executeOperation(op, completion: completion)
        }
    }
    
    func increaseNetworkActivityCounter() {
        
        synchronized(self) {
            
            self.networkActivityCounter += 1
            self.updateNetworkActivityIndicatorStatus()
        }
    }
    
    func decreaseNetworkActivityCounter() {
        
        synchronized(self) {
            
            self.networkActivityCounter -= 1
            self.networkActivityCounter = max(networkActivityCounter, 0)
            self.updateNetworkActivityIndicatorStatus()
        }
    }
    
    //MARK: - Private -
    //MARK: Properties
    
    private var networkActivityCounter: Int = 0
    
    private lazy var networkManager = TapNetworkManager(baseURL: RequestOperationsHandler.baseURL, configuration: RequestOperationsHandler.sessionConfiguration)
    
    lazy private var responseProcessingQueue: DispatchQueue = DispatchQueue(label: "company.tap.goTap.API.response_processing_queue")
    
    private lazy var reachabilityManager: TapReachabilityManager? = TapReachabilityManager(host: "www.tap.company")
    
    private static let sessionConfiguration: URLSessionConfiguration = {
        
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.timeoutIntervalForRequest = Constants.Default.TimeoutInterval
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        return configuration
    }()
    
    //MARK: Methods
    
    private init() {
        
        self.monitorReachability()
    }
    
    private func monitorReachability() {
        
        _ = self.reachabilityManager?.addListener({ (status) in
            
            StatusCodesHelper.handle(networkReachabilityStatus: status)
        })
    }
    
    private func executeOperation<T>(_ operation: RequestOperation, completion: ((T?, APIError?) -> Void)?) where T : ResponseHolder {
        
        var method: TapHTTPMethod
        switch operation.httpMethod {
            
        case .Get:
            
            method = .GET
            
        case .Post:
            
            method = .POST
            
        default:
            
            method = .GET
        }
        
        var bodyModel: TapBodyModel?
        if let nonnullBody = operation.bodyModel?.serializedModel as? [String: Any] {
            
            bodyModel = TapBodyModel(body: nonnullBody)
        }
        
        var urlModel: TapURLModel? = nil
        if let dict = operation.urlModel?.serializedModel as? [String: Any] {
            
            urlModel = .dictionary(parameters: dict)
        }
        
        let networkOperation = TapNetworkRequestOperation(path: operation.requestPath, method: method, headers: operation.requestHeaders, urlModel: urlModel, bodyModel: bodyModel, responseType: .json)
        
        var backgroundTaskID = UIBackgroundTaskInvalid
        
        let backgroundTaskInvalidationClosure: TypeAlias.ArgumentlessClosure = {
            
            if backgroundTaskID != UIBackgroundTaskInvalid {
                
                UIApplication.shared.endBackgroundTask(backgroundTaskID)
                backgroundTaskID = UIBackgroundTaskInvalid
            }
        }
        
        backgroundTaskID = UIApplication.shared.beginBackgroundTask(expirationHandler: backgroundTaskInvalidationClosure)
        
        let commonCompletionClosure = { [weak self] in
            
            self?.decreaseNetworkActivityCounter()
            backgroundTaskInvalidationClosure()
        }
        
        let successClosure: (URLSessionDataTask, Any?) -> Void = { [weak self] (dataTask, responseObject) in
            
            defer {
                
                commonCompletionClosure()
            }
            
            self?.responseProcessingQueue.async {
                
                if dataTask.state == .canceling {
                    
                    return
                }
                
                let processedResponseObject = self?.processResponseObject(responseObject)
                self?.handle(responseObject: processedResponseObject, inOperation: operation, dataTask: dataTask, error: nil, completion: completion)
            }
        }
        
        let failureClosure: (URLSessionDataTask?, Swift.Error) -> Void = { [weak self] (dataTask, error) in
            
            defer {
                
                commonCompletionClosure()
            }
            
            self?.responseProcessingQueue.async {
                
                if dataTask?.state == .canceling {
                    
                    return
                }
                
                self?.handle(responseObject: nil, inOperation: operation, dataTask: dataTask, error: error, completion: completion)
            }
        }
        
        self.increaseNetworkActivityCounter()
        
        self.networkManager.performRequest(networkOperation) { (task, response, error) in
            
            defer {
                
                commonCompletionClosure()
            }
            
            if let nonnullTask = task, let nonnullResponse = response {
                
                successClosure(nonnullTask, nonnullResponse)
            }
            else if let nonnullError = error {
                
                failureClosure(task, nonnullError)
            }
        }
    }
    
    private func processResponseObject(_ responseObject: Any?) -> Any? {
        
        guard let nonnullResponseObject = responseObject else { return nil }
        
        if let stringResponseObject = nonnullResponseObject as? String {
            
            let objectData = stringResponseObject.data(using: String.Encoding.utf8)
            let objectDataLength = objectData?.count ?? 0
            if objectDataLength > 0 {
                
                return try? JSONSerialization.jsonObject(with: objectData!, options: JSONSerialization.ReadingOptions.allowFragments)
            }
        }
        
        return nonnullResponseObject
    }
    
    private func handle<T>(responseObject: Any?, inOperation operation: RequestOperation, dataTask: URLSessionDataTask?, error: Swift.Error?, completion: ((T?, APIError?) -> Void)?) where T : ResponseHolder {
        
        operation.parse(responseObject: responseObject)
        
        let httpResponse = dataTask?.response as? HTTPURLResponse
        let httpStatusCode = httpResponse?.statusCode ?? HTTPStatusCode.ok.rawValue
        if httpResponse != nil && StatusCodesHelper.needToHandle(HTTPStatusCode: httpStatusCode) {
            
            self.handle(systemStatusCode: httpStatusCode, inOperation: operation, httpError: nil, isHTTPCode: true, completion: completion)
        }
        else if responseObject != nil {
            
            if let serverError = operation.responseError {
                
                self.handle(serverError: serverError, inOperation: operation, responseHeaders: httpResponse?.allHeaderFields ?? [:], completion: completion)
            }
            else {
                
                let serverResponse = operation.responseModel?.response
                let serverResponseCode = Int(serverResponse?.code ?? Int64(ServerStatusCode.success.rawValue))
                if serverResponse != nil && StatusCodesHelper.needToHandle(serverStatusCode: serverResponseCode) {
                    
                    let serverError = APIError(response: serverResponse!)
                    self.handle(serverError: serverError, inOperation: operation, responseHeaders: httpResponse?.allHeaderFields ?? [:], completion: completion)
                }
                else if error != nil {
                    
                    self.handle(error: error, responseObject: responseObject, inOperation: operation, completion: completion)
                }
                else {
                    
                    DispatchQueue.main.async {
                        
                        let outError = operation.responseModel == nil ? operation.responseError : nil
                        completion?(operation.responseModel as? T, outError)
                    }
                }
            }
        }
        else {
            
            self.handle(error: error, responseObject: responseObject, inOperation: operation, completion: completion)
        }
    }
    
    private func handle<T>(systemStatusCode: Int, inOperation operation: RequestOperation, httpError: Swift.Error?, isHTTPCode: Bool, completion: ((T?, APIError?) -> Void)?) where T : ResponseHolder {
        
        let url = URL(string: operation.requestPath, relativeTo: type(of: self).baseURL)!
        
        var error: NSError
        if httpError == nil {
            
            error = NSError(domain: NSURLErrorDomain, code: systemStatusCode, userInfo: [NSLocalizedDescriptionKey: Client.sharedInstance.dataSource!.localizedString(forKey: "Please report this problem to enhance the experience of the app.")])
        }
        else {
            
            error = httpError! as NSError
        }
        
        DispatchQueue.main.async {
            
            if isHTTPCode {
                
                StatusCodesHelper.handle(HTTPStatusCode: systemStatusCode, error: error, url: url, inOperation: operation)
            }
            else {
                
                StatusCodesHelper.handle(URLConnectionStatusCode: systemStatusCode, error: error, url: url, inOperation: operation)
            }
        }
        
        callCompletion(completion, withError: error)
    }
    
    private func handle<T>(serverError: APIError, inOperation operation: RequestOperation, responseHeaders: [AnyHashable: Any], completion: ((T?, APIError?) -> Void)?) where T : ResponseHolder {
        
        let error = NSError(domain: Constants.Error.domain, code: Int(serverError.code), userInfo: serverError.userInfo)
        
        DispatchQueue.main.async {
            
            StatusCodesHelper.handle(serverStatusCode: Int(serverError.code), error: error, inOperation: operation, responseHeaders: responseHeaders)
        }
        
        callCompletion(completion, withError: error)
    }
    
    private func handle<T>(error: Swift.Error?, responseObject: Any?, inOperation operation: RequestOperation, completion: ((T?, APIError?) -> Void)?) where T : ResponseHolder {
        
        guard let nsError = error as NSError? else {
            
            callCompletion(completion, withError: error)
            return
        }
        
        guard nsError.domain == NSURLErrorDomain || nsError.domain == (kCFErrorDomainCFNetwork as String) else {
            
            callCompletion(completion, withError: error)
            return
        }
        
        if StatusCodesHelper.needToHandle(URLConnectionStatusCode: nsError.code) {
            
            handle(systemStatusCode: nsError.code, inOperation: operation, httpError: error, isHTTPCode: false, completion: completion)
        }
        else {
            
            callCompletion(completion, withError: error)
        }
    }
    
    private func callCompletion<T>(_ completion: ((T?, APIError?) -> Void)?, withError error: Swift.Error?) where T: ResponseHolder {
        
        var goTapError: APIError? = nil
        if let nsError = error as NSError? {
            
            goTapError = APIError(code: Int64(nsError.code), userInfo: nsError.userInfo)
        }
        
        DispatchQueue.main.async {
            
            completion?(nil, goTapError)
        }
    }
    
    private func updateNetworkActivityIndicatorStatus() {
        
        performOnMainThread {
            
            let wasVisible = UIApplication.shared.isNetworkActivityIndicatorVisible
            let shouldBeVisible = self.networkActivityCounter > 0
            
            if wasVisible != shouldBeVisible {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = shouldBeVisible
            }
        }
    }
}
