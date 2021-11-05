//
//  StatusCodesHelper.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/12/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

import CFNetwork

import TapNetworkManagerV2

internal class StatusCodesHelper {
    
    //MARK: - Public -
    //MARK: Methods
    
    internal static func needToHandle(HTTPStatusCode statusCode: Int) -> Bool {
        
        return !self.actionFor(HTTPStatusCode: statusCode).contains(bit: goTapAPI.TPAction.None)
    }
    
    internal static func needToHandle(serverStatusCode statusCode: Int) -> Bool {
        
        return !self.actionFor(serverStatusCode: statusCode).contains(bit: goTapAPI.TPAction.None)
    }
    
    internal static func needToHandle(URLConnectionStatusCode statusCode: Int) -> Bool {
        
        return !actionFor(URLConnectionStatusCode: statusCode).contains(bit: goTapAPI.TPAction.None)
    }
    
    internal static func handle(HTTPStatusCode statusCode: Int, error: NSError, url: URL, inOperation operation: RequestOperation) {
        
        let action = self.actionFor(HTTPStatusCode: statusCode)
        self.handle(systemStatusCode: statusCode, error: error, inOperation: operation, action: action)
    }
    
    internal static func handle(URLConnectionStatusCode statusCode: Int, error: NSError, url: URL, inOperation operation: RequestOperation) {
        
        let action = self.actionFor(URLConnectionStatusCode: statusCode)
        self.handle(systemStatusCode: statusCode, error: error, inOperation: operation, action: action)
    }
    
    internal static func handle(serverStatusCode statusCode: Int, error: NSError, inOperation operation: RequestOperation, responseHeaders: [AnyHashable: Any]) {
        
        var userInfo = error.userInfo
        userInfo[goTapAPI.Constants.Error.UserInfoKey.URL] = URL(string: operation.requestPath, relativeTo: RequestOperationsHandler.baseURL)!.absoluteString
        userInfo[goTapAPI.Constants.Error.UserInfoKey.RequestHeaders] = operation.requestHeaders
        userInfo[goTapAPI.Constants.Error.UserInfoKey.ResponseHeaders] = responseHeaders
        userInfo[NSURLErrorDomain] = error.domain
        
        if let requestParameters = operation.bodyModel?.serializedModel {
            
            userInfo[goTapAPI.Constants.Error.UserInfoKey.RequestParameters] = requestParameters
        }
        
        if let completeResponse = operation.responseObject {
            
            userInfo[goTapAPI.Constants.Error.UserInfoKey.ResponseParameters] = completeResponse
        }
        
        let nonnullResponseModel = operation.responseObjectType.dataModelWith(serializedObject: operation.responseObject)
        let response = nonnullResponseModel?.response ?? Response(code: Int64(statusCode))
        
        let errorToBeSent = goTapAPI.APIError(code: Int64(error.code), userInfo: userInfo)
        errorToBeSent.responseID = response.responseID
        
        let action = Client.sharedInstance.dataSource?.errorDescription(for: Int64(statusCode))?.action ?? self.actionFor(serverStatusCode: statusCode)
        
        goTapAPI.Client.sharedInstance.delegate?.handleAction(action, responseData: response, error: errorToBeSent)
    }
    
    internal static func handle(networkReachabilityStatus status: TapNetworkReachabilityStatus) {
        
        let action: goTapAPI.TPAction = status == .unreachable ? goTapAPI.TPAction.TopAlert | goTapAPI.TPAction.BlockUI : goTapAPI.TPAction.HideTopAlert
        let responseData = goTapAPI.Response(code: Int64(ServerStatusCode.noInternetConnection.rawValue))
        
        goTapAPI.Client.sharedInstance.delegate?.handleAction(action, responseData: responseData, error: nil)
    }
    
    //MARK: - Private -
    //MARK: Methods
    
    private static func handle(systemStatusCode statusCode: Int, error: NSError, inOperation operation: RequestOperation, action: goTapAPI.TPAction) {
        
        var userInfo = error.userInfo
        userInfo[goTapAPI.Constants.Error.UserInfoKey.URL] = URL(string: operation.requestPath, relativeTo: RequestOperationsHandler.baseURL)!.absoluteString
        userInfo[goTapAPI.Constants.Error.UserInfoKey.RequestHeaders] = operation.requestHeaders
        
        if let requestParameters = operation.bodyModel?.serializedModel {
            
            userInfo[goTapAPI.Constants.Error.UserInfoKey.RequestParameters] = requestParameters
        }
        
        if let completeResponse = operation.responseObject {
            
            userInfo[goTapAPI.Constants.Error.UserInfoKey.ResponseParameters] = completeResponse
        }
        
        userInfo[NSURLErrorDomain] = error.domain
        
        let errorToBeSent = goTapAPI.APIError(code: Int64(error.code), userInfo: userInfo)
        
        let responseData = operation.responseModel?.response ?? Response(code: Int64(statusCode))
        
        goTapAPI.Client.sharedInstance.delegate?.handleAction(action, responseData: responseData, error: errorToBeSent)
    }
    
    private static func actionFor(HTTPStatusCode statusCode: Int) -> goTapAPI.TPAction {
        
        switch HTTPStatusCode(rawValue: statusCode) ?? .other {
            
        case .ok:
            
            return goTapAPI.TPAction.None
            
        case .badRequest:
            
            return goTapAPI.TPAction.Logout | goTapAPI.TPAction.PopupWithReportButton
            
        case .unatherised:
            
            return goTapAPI.TPAction.Logout | goTapAPI.TPAction.PopupWithReportButton
            
        case .notFound:
            
            return goTapAPI.TPAction.PopupWithReportButton
            
        case .internalError:
            
            return goTapAPI.TPAction.PopupWithReportButton
            
        default:
            
            return goTapAPI.TPAction.PopupWithReportButton
        }
    }
    
    private static func actionFor(serverStatusCode statusCode: Int) -> goTapAPI.TPAction {
        
        let serverStatusCode = ServerStatusCode(rawValue: statusCode) ?? .other
        
        switch serverStatusCode {
            
        case .success,
             .pending,
             .prioritizeSuccessful,
             .unavailableAddressFormat,
             .thankYouForPayment,
             .paymentDeclined_1001,
             .paymentFailed_1002,
             .paymentDeclined_1003,
             .paymentFailed_1004,
             .paymentDeclined_1005,
             .paymentDeclined_1006,
             .paymentFailed_1007,
             .paymentFailed_1008,
             .paymentFailed_1009,
             .paymentDeclined_1010,
             .paymentCancelled_1011,
             .paymentDeclined_1012,
             .paymentCancelled_1013,
             .paymentFailed_1014,
             .paymentFailed_1015,
             .paymentDeclined_1016,
             .paymentDeclined_1017,
             .paymentDeclined_1018,
             .paymentFailed_1019,
             .paymentFailed_1020,
             .paymentDeclined_1021,
             .paymentFailed_1022,
             .paymentDeclined_1023,
             .paymentDeclined_1024,
             .paymentDeclined_1025,
             .paymentFailed_1026:
            
            return .None
            
        case .invalidPhoneNumber,
             .confirmationCodeInvalid,
             .confirmationCodeExpired,
             .confirmationCodeRetryLimitExceeded,
             .maximumMobileLimit,
             .noAccountsFound,
             .itemExists,
             .connectionFailed,
             .enterAmount,
             .amountTooSmall,
             .amountTooBig,
             .payWithAnInteger,
             .refresh,
             .reload,
             .billCancelled,
             .billExpired,
             .billAlreadyPaid:
            
            return .Popup
            
        case .fileNotFound,
             .internalServerError,
             .invalidTransaction,
             .invalidRequestFormat,
             .unknownError:
            
            return .PopupWithReportButton
            
        case .invalidPhoneNumber_400,
             .invalidPhoneNumber_401,
             .invalidSession,
             .sessionExpired,
             .invalidLicense,
             .changedSIM,
             .invalidHSCode,
             .invalidPhoneNumber_408:
            
            return .PopupWithReportButton | .Logout
            
        case .countryUnavailable:
            
            return .OpenCountryUnavailableScreen
            
        default:
            
            return .None
        }
    }
    
    private static func actionFor(URLConnectionStatusCode statusCode: Int) -> goTapAPI.TPAction {
        
        guard let cfError = CFNetworkErrors(rawValue: Int32(statusCode)) else {
            
            return TPAction.PopupWithReportButton
        }
        
        switch  cfError {
            
        case .cfHostErrorHostNotFound:
            return TPAction.PopupWithReportButton
            
        case .cfHostErrorUnknown:
            return TPAction.PopupWithReportButton
            
        case .cfsocksErrorUnknownClientVersion, .cfsocksErrorUnsupportedServerVersion, .cfsocks4ErrorRequestFailed, .cfsocks4ErrorIdentdFailed, .cfsocks4ErrorIdConflict, .cfsocks4ErrorUnknownStatusCode, .cfsocks5ErrorBadState, .cfsocks5ErrorBadResponseAddr, .cfsocks5ErrorBadCredentials, .cfsocks5ErrorUnsupportedNegotiationMethod, .cfsocks5ErrorNoAcceptableMethod:
            return TPAction.PopupWithReportButton
            
        case .cfftpErrorUnexpectedStatusCode:
            return TPAction.PopupWithReportButton
            
        case .cfErrorHTTPAuthenticationTypeUnsupported, .cfErrorHTTPBadCredentials:
            return TPAction.PopupWithReportButton
            
        case .cfErrorHTTPConnectionLost:
            return TPAction.PopupWithReportButton
            
        case .cfErrorHTTPParseFailure:
            return TPAction.PopupWithReportButton
            
        case .cfErrorHTTPRedirectionLoopDetected:
            return TPAction.PopupWithReportButton
            
        case .cfErrorHTTPBadURL:
            return TPAction.PopupWithReportButton
            
        case .cfErrorHTTPProxyConnectionFailure:
            return TPAction.PopupWithReportButton
            
        case .cfErrorHTTPBadProxyCredentials, .cfErrorPACFileError, .cfErrorPACFileAuth:
            return TPAction.PopupWithReportButton
            
        case .cfErrorHTTPSProxyConnectionFailure:
            return TPAction.PopupWithReportButton
            
        case .cfStreamErrorHTTPSProxyFailureUnexpectedResponseToCONNECTMethod:
            return TPAction.PopupWithReportButton
            
        case .cfurlErrorBackgroundSessionInUseByAnotherProcess:
            return TPAction.PopupWithReportButton
            
        case .cfurlErrorBackgroundSessionWasDisconnected:
            return TPAction.PopupWithReportButton
            
        case .cfurlErrorUnknown:
            return TPAction.PopupWithReportButton
            
        case .cfurlErrorCancelled:
            return TPAction.PopupWithReportButton
            
        case .cfurlErrorBadURL:
            return TPAction.PopupWithReportButton
            
        case .cfurlErrorTimedOut:
            return TPAction.Popup
            
        case .cfurlErrorUnsupportedURL:
            return TPAction.PopupWithReportButton
            
        case .cfurlErrorCannotFindHost, .cfurlErrorCannotConnectToHost, .cfurlErrorNetworkConnectionLost, .cfurlErrorDNSLookupFailed:
            return TPAction.PopupWithReportButton
            
        case .cfurlErrorHTTPTooManyRedirects:
            return TPAction.PopupWithReportButton
            
        case .cfurlErrorResourceUnavailable:
            return TPAction.PopupWithReportButton
            
        case .cfurlErrorNotConnectedToInternet:
            return TPAction.None
            
        case .cfurlErrorRedirectToNonExistentLocation:
            return TPAction.PopupWithReportButton
            
        case .cfurlErrorBadServerResponse:
            return TPAction.PopupWithReportButton
            
        case .cfurlErrorUserCancelledAuthentication:
            return TPAction.PopupWithReportButton
            
        case .cfurlErrorUserAuthenticationRequired, .cfurlErrorZeroByteResource, .cfurlErrorCannotDecodeRawData, .cfurlErrorCannotDecodeContentData, .cfurlErrorCannotParseResponse:
            return TPAction.PopupWithReportButton
            
        case .cfurlErrorInternationalRoamingOff, .cfurlErrorCallIsActive:
            return TPAction.None
            
        case .cfurlErrorDataNotAllowed, .cfurlErrorRequestBodyStreamExhausted, .cfurlErrorFileDoesNotExist, .cfurlErrorFileIsDirectory, .cfurlErrorNoPermissionsToReadFile, .cfurlErrorDataLengthExceedsMaximum:
            return TPAction.PopupWithReportButton
            
        case .cfurlErrorSecureConnectionFailed, .cfurlErrorServerCertificateHasBadDate, .cfurlErrorServerCertificateUntrusted, .cfurlErrorServerCertificateHasUnknownRoot, .cfurlErrorServerCertificateNotYetValid, .cfurlErrorClientCertificateRejected, .cfurlErrorClientCertificateRequired, .cfurlErrorCannotLoadFromNetwork:
            return TPAction.PopupWithReportButton
            
        case .cfurlErrorCannotCreateFile, .cfurlErrorCannotOpenFile, .cfurlErrorCannotCloseFile, .cfurlErrorCannotWriteToFile, .cfurlErrorCannotRemoveFile, .cfurlErrorCannotMoveFile, .cfurlErrorDownloadDecodingFailedMidStream, .cfurlErrorDownloadDecodingFailedToComplete:
            return TPAction.PopupWithReportButton
            
        case .cfhttpCookieCannotParseCookieFile:
            return TPAction.PopupWithReportButton
            
        case .cfNetServiceErrorUnknown, .cfNetServiceErrorCollision, .cfNetServiceErrorNotFound, .cfNetServiceErrorInProgress, .cfNetServiceErrorBadArgument:
            return TPAction.PopupWithReportButton
            
        case .cfNetServiceErrorCancel:
            return TPAction.PopupWithReportButton
            
        case .cfNetServiceErrorInvalid:
            return TPAction.PopupWithReportButton
            
        case .cfNetServiceErrorTimeout:
            return TPAction.PopupWithReportButton
            
        case .cfNetServiceErrorDNSServiceFailure:
            return TPAction.PopupWithReportButton
            
        default:
            return TPAction.PopupWithReportButton
        }
    }
    
    @available(*, unavailable) init() {}
}
