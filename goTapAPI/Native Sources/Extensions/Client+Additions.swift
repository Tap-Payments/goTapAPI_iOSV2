//
//  Client+Additions.swift
//  Pods
//
//  Created by Dennis Pashkov on 10/4/16.
//
//

import SDWebImage
import TapSwiftFixesV2

private var lastModifiedDateFormatterAssociationKey: UInt8 = 0
private var imageLoadingQueueAssociationKey: UInt8 = 0


/// Useful extension to Client.
public extension goTapAPI.Client {
    
    //MARK: - Public -
    //MARK: Methods
    
    public func loadYoutubeVideoDetails(with youtubeURL: URL, completion: ((goTapAPI.YoutubeVideo?, goTapAPI.APIError?) -> Void)?) {
        
        let emptyString = ""
        
        self.loadYoutubeVideoDetails(from: [emptyString: youtubeURL]) { (response, error) in
            
            if error == nil {
                
                completion?(response?[emptyString], nil)
            }
            else {
                
                completion?(nil, error)
            }
        }
    }
    
    public func loadYoutubeVideoDetails(from youtubeURLs: [String: URL], completion: (([String: goTapAPI.YoutubeVideo]?, goTapAPI.APIError?) -> Void)?) {
        
        guard youtubeURLs.keys.count > 0 else {
            
            DispatchQueue.main.async {
                
                completion?([:], nil)
            }
            
            return
        }
        
        DispatchQueue.global().async {
            
            var response: [String: goTapAPI.YoutubeVideo] = [:]
            var processedURLsCount: Int = 0
            var stop: Bool = false
            
            for (key, url) in youtubeURLs {
                
                if stop {
                    
                    return
                }
                
                RequestOperationsHandler.shared.increaseNetworkActivityCounter()
                
                HCYoutubeParser.h264videos(withYoutubeURL: url, complete: { (videoDictionary, error: Swift.Error?) in
                    
                    RequestOperationsHandler.shared.decreaseNetworkActivityCounter()
                    
                    if stop {
                        
                        return
                    }
                    
                    if error != nil {
                        
                        let nsError = error! as NSError
                        
                        DispatchQueue.main.async {
                            
                            completion?(nil, goTapAPI.APIError(code: Int64(nsError.code), userInfo: nsError.userInfo))
                        }
                        
                        stop = true
                        return
                    }
                    
                    let youtubeVideo = goTapAPI.YoutubeVideo().dataModelWith(serializedObject: videoDictionary)
                    response[key] = youtubeVideo
                    
                    processedURLsCount += 1
                    
                    if processedURLsCount == youtubeURLs.count {
                        
                        DispatchQueue.main.async {
                            
                            completion?(response, nil)
                        }
                        
                        stop = true
                    }
                })
            }
        }
    }
    
    public func downloadImage(from url: URL, completion: ((UIImage?, goTapAPI.APIError?) -> Void)?) {
        
        downloadImage(from: url, progress: nil, completion: completion)
    }
    
    public func downloadImage(from url: URL, progress: ((CGFloat) -> Void)?, completion: ((UIImage?, goTapAPI.APIError?) -> Void)?) {
        
        let progressClosure: (URL, CGFloat) -> Void = { (url, theProgress) in
            
            progress?(theProgress)
        }
        
        let completionClosure: (URL, UIImage?, APIError?) -> Void = { (request, image, error) in
            
            completion?(image, error)
        }
        
        downloadImage(from: url, loadCacheSynchronously: false, loadImageSynchronously: false, progress: progressClosure, completion: completionClosure)
    }
    
    public func downloadImage(from url: URL, loadCacheSynchronously: Bool, loadImageSynchronously: Bool, completion: ((UIImage?, goTapAPI.APIError?) -> Void)?) {
        
        let completionClosure: (URL, UIImage?, APIError?) -> Void = { (url, image, error) in
            
            completion?(image, error)
        }
        
        downloadImage(from: url, loadCacheSynchronously: loadCacheSynchronously, loadImageSynchronously: loadImageSynchronously, progress: nil, completion: completionClosure)
    }
    
    public func downloadImages(from urls: [URL], loadCacheSynchronously: Bool, completion: (([UIImage]?, goTapAPI.APIError?) -> Void)?) {
        
        downloadImages(from: urls, loadCacheSynchronously: loadCacheSynchronously, loadImagesSynchronously: false, completion: completion)
    }
    
    public func fileUpdateDate(at url: URL) -> Date? {
        
        if url.isFileURL { return nil }
        
        var request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: goTapAPI.Constants.Default.TimeoutInterval)
        request.httpMethod = goTapAPI.HttpMethod.Head.stringRepresentation
        
        RequestOperationsHandler.shared.increaseNetworkActivityCounter()
        
        let response = URLSession.tap_synchronousDataTask(with: request).response
        
        RequestOperationsHandler.shared.decreaseNetworkActivityCounter()
        
        guard response != nil else {
            
            return nil
        }
        
        guard let lastModifiedString = (response as? HTTPURLResponse)?.allHeaderFields[goTapAPI.Constants.Key.Last_Modified] as? String else {
            
            return nil
        }
        
        if let date = self.lastModifiedDateFormatter.date(from: lastModifiedString) {
            
            return date
        }
        
        return nil
    }
    
    public func shouldDownloadFile(from url: URL, withExistingFilePath existingFilePath: String?) -> Bool {
        
        return shouldDownloadFile(from: url, withExistingFilePath: existingFilePath, remoteFileModificationDate: nil)
    }
    
    public func shouldDownloadFile(from url: URL, withExistingFilePath existingFilePath: String?, remoteFileModificationDate: AutoreleasingUnsafeMutablePointer<NSDate?>?) -> Bool {
        
        if existingFilePath == nil { return true }
        
        guard let serverFileDate = fileUpdateDate(at: url) else {
         
            return false
        }
        
        remoteFileModificationDate?.pointee = serverFileDate as NSDate?
        
        guard let localFileAttributes = try? FileManager.default.attributesOfItem(atPath: existingFilePath!) else {
            
            return true
        }
        
        guard let localFileDate = localFileAttributes[FileAttributeKey.modificationDate] as? Date else { return true }
        
        let shouldDownload = localFileDate.compare(serverFileDate) == .orderedAscending
        return shouldDownload
    }
    
    //MARK: - Private -
    //MARK: Properties
    
    private var lastModifiedDateFormatter: DateFormatter {
        
        get {
            
            return synchronized(self) {
                
                if let formatter = objc_getAssociatedObject(self, &lastModifiedDateFormatterAssociationKey) as? DateFormatter {
                    
                    return formatter
                }
                
                let dateFormatter = DateFormatter.dateFormatterWith(localeIdentifier: goTapAPI.Constants.Default.LocaleIdentifier,
                                                                    dateFormat: goTapAPI.Constants.DateFormat.Format4)
                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                
                self.lastModifiedDateFormatter = dateFormatter
                return dateFormatter
            }
        }
        set {
            
            synchronized(self) {
                
                objc_setAssociatedObject(self, &lastModifiedDateFormatterAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    private var imageLoadingQueue: OperationQueue {
        
        get {
            
            return synchronized(self) {
                
                if let queue = objc_getAssociatedObject(self, &imageLoadingQueueAssociationKey) as? OperationQueue {
                    
                    return queue
                }
                
                let queue = OperationQueue()
                queue.name = "company.tap.goTap.API.image_cache_loading_queue"
                queue.qualityOfService = .utility
                queue.maxConcurrentOperationCount = 10
                
                self.imageLoadingQueue = queue
                
                return queue
            }
        }
        set {
            
            synchronized(self) {
                
                objc_setAssociatedObject(self, &imageLoadingQueueAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    //MARK: Methods
    
    private func downloadImages(from urls: [URL], loadCacheSynchronously: Bool, loadImagesSynchronously: Bool, completion: (([UIImage]?, goTapAPI.APIError?) -> Void)?) {
        
        autoreleasepool {
            
            var completionToBeCalled = completion
            
            let _urls = NSArray(array: urls) as! [URL]
            var images: NSMutableArray? = NSMutableArray(capacity: urls.count)
            
            while images!.count < _urls.count {
                
                images!.add(NSNull())
            }
            
            var numberOfLoadedImages = 0
            var downloadFailed = false
            
            let imageCompletionClosure: (URL, UIImage?, goTapAPI.APIError?) -> Void = { (url, image, error) in
             
                if downloadFailed { return }
                
                if error != nil || image == nil {
                    
                    downloadFailed = true
                    
                    DispatchQueue.main.async {
                        
                        completionToBeCalled?(nil, error)
                        completionToBeCalled = nil
                    }
                    
                    return
                }
                
                let nonnullImage = image!
                images![_urls.index(of: url)!] = nonnullImage
                numberOfLoadedImages += 1
                
                if numberOfLoadedImages == images!.count {
                    
                    if loadImagesSynchronously {
                        
                        completionToBeCalled?(images!.asArrayOf(UIImage.self), nil)
                        completionToBeCalled = nil
                        
                        images = nil
                    }
                    else {
                        
                        DispatchQueue.main.async {
                            
                            completionToBeCalled?(images!.asArrayOf(UIImage.self), nil)
                            completionToBeCalled = nil
                            
                            images = nil
                        }
                    }
                }
            }
            
            for url in _urls {
                
                self.downloadImage(from: url,
                                   loadCacheSynchronously: loadCacheSynchronously,
                                   loadImageSynchronously: loadImagesSynchronously,
                                   progress: nil,
                                   completion: imageCompletionClosure)
            }
        }
    }
    
    private func downloadImage(from url: URL, loadCacheSynchronously: Bool, loadImageSynchronously: Bool, progress: ((URL, CGFloat) -> Void)?, completion: ((URL, UIImage?, goTapAPI.APIError?) -> Void)?) {
        
        self.loadImageFromCache(with: url, synchronously: loadCacheSynchronously) { (image) in
            
            if image != nil {
                
                if loadCacheSynchronously {
                    
                    completion?(url, image, nil)
                }
                else {
                    
                    DispatchQueue.main.async {
                        
                        completion?(url, image, nil)
                    }
                }
                return
            }
            
            let progressClosure: (Int, Int, URL?) -> Void = { (bytesLoaded, bytesExpectedToLoad, _) in
                
                let cgfloatProgress = CGFloat(bytesLoaded) / CGFloat(bytesExpectedToLoad)
                
                if loadImageSynchronously {
                    
                    progress?(url, cgfloatProgress)
                }
                else {
                    
                    DispatchQueue.main.async {
                        
                        progress?(url, cgfloatProgress)
                    }
                }
            }
            
            let completionClosure: (UIImage?, Data?, Swift.Error?, Bool) -> Void = { (image, imageData, error, finished) in
                
                RequestOperationsHandler.shared.decreaseNetworkActivityCounter()
                
                if image != nil {
                    
                    self.save(image!, toCacheWith: url)
                }
                
                var tapError: goTapAPI.APIError? = nil
                if let nsError = error as NSError? {
                    
                    tapError = goTapAPI.APIError(code: Int64(nsError.code), userInfo: nsError.userInfo)
                }
                
                if loadImageSynchronously {
                    
                    completion?(url, image, tapError)
                }
                else {
                    
                    DispatchQueue.main.async {
                        
                        completion?(url, image, tapError)
                    }
                }
            }
            
            RequestOperationsHandler.shared.increaseNetworkActivityCounter()
            
            let imageDownloader = SDWebImageDownloader.shared()
            imageDownloader.downloadTimeout = Constants.Default.TimeoutInterval
            imageDownloader.maxConcurrentDownloads = 10
            
            _ = imageDownloader.downloadImage(with: url, options: SDWebImageDownloaderOptions.useNSURLCache, progress: progressClosure, completed: completionClosure)
        }
    }
    
    private func save(_ image: UIImage, toCacheWith url: URL) {
        
        let key = SDWebImageManager.shared().cacheKey(for: url)
        
        SDImageCache.shared().store(image, forKey: key)
        
        guard let imagePath = SDImageCache.shared().defaultCachePath(forKey: key) else {
            
            return
        }
        
        
        guard let modificationDate = fileUpdateDate(at: url) else {
            
            return
        }
        
        let attributes = [FileAttributeKey.modificationDate: modificationDate]
        
        do {
            
            try FileManager.default.setAttributes(attributes, ofItemAtPath: imagePath)
        }
        catch let error as NSError {
            
            print(error.localizedDescription)
        }
    }
    
    private func loadImageFromCache(with url: URL) -> UIImage? {
        
        let key = SDWebImageManager.shared().cacheKey(for: url)
        let sharedCache = SDImageCache.shared()

        var shouldLoadFromCache = false
        
        if sharedCache.diskImageDataExists(withKey: key) {
            
            shouldLoadFromCache = !self.shouldDownloadFile(from: url, withExistingFilePath: sharedCache.defaultCachePath(forKey: key))
        }
        
        return shouldLoadFromCache ? sharedCache.imageFromDiskCache(forKey: key) : nil
    }
    
    private func loadImageFromCache(with url: URL, synchronously: Bool, completion: @escaping (UIImage?) -> Void) {
        
        if synchronously {
            
            completion(self.loadImageFromCache(with: url))
        }
        else {

            self.imageLoadingQueue.addOperation {
                
                completion(self.loadImageFromCache(with: url))
            }
        }
    }
}
