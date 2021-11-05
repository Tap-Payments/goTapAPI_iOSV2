//
//  StatusCodes.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/13/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

public enum HTTPStatusCode: Int {
    
    case ok            = 200
    case badRequest    = 400
    case unatherised   = 401
    case notFound      = 404
    case internalError = 500
    case other
}

public enum ServerStatusCode: Int {
    
    case success                            =    0
    case pending                            =    1
    
    case noInternetConnection               =   10
    
    case invalidPhoneNumber                 =  100
    case countryUnavailable                 =  101
    case confirmationCodeInvalid            =  103
    case confirmationCodeExpired            =  104
    case confirmationCodeRetryLimitExceeded =  105
    case prioritizeSuccessful               =  106
    case unavailableAddressFormat           =  107
    
    case invalidPhoneNumber_400             =  400
    case invalidPhoneNumber_401             =  401
    case invalidSession                     =  402
    case sessionExpired                     =  403
    case fileNotFound                       =  404
    case invalidLicense                     =  405
    case changedSIM                         =  406
    case invalidHSCode                      =  407
    case invalidPhoneNumber_408             =  408
    
    case internalServerError                =  500
    case maximumMobileLimit                 =  501
    
    case invalidTransaction                 =  601
    case invalidRequestFormat               =  602
    case noAccountsFound                    =  605
    case itemExists                         =  606
    case connectionFailed                   =  607
    
    case enterAmount                        =  700
    case amountTooSmall                     =  701
    case amountTooBig                       =  702
    case payWithAnInteger                   =  704
    case refresh                            =  707
    case reload                             =  708
    case billCancelled                      =  709
    case billExpired                        =  710
    case billAlreadyPaid                    =  711
    
    case thankYouForPayment                 =  998
    case unknownError                       =  999
    
    case paymentDeclined_1001               = 1001
    case paymentFailed_1002                 = 1002
    case paymentDeclined_1003               = 1003
    case paymentFailed_1004                 = 1004
    case paymentDeclined_1005               = 1005
    case paymentDeclined_1006               = 1006
    case paymentFailed_1007                 = 1007
    case paymentFailed_1008                 = 1008
    case paymentFailed_1009                 = 1009
    case paymentDeclined_1010               = 1010
    case paymentCancelled_1011              = 1011
    case paymentDeclined_1012               = 1012
    case paymentCancelled_1013              = 1013
    case paymentFailed_1014                 = 1014
    case paymentFailed_1015                 = 1015
    case paymentDeclined_1016               = 1016
    case paymentDeclined_1017               = 1017
    case paymentDeclined_1018               = 1018
    case paymentFailed_1019                 = 1019
    case paymentFailed_1020                 = 1020
    case paymentDeclined_1021               = 1021
    case paymentFailed_1022                 = 1022
    case paymentDeclined_1023               = 1023
    case paymentDeclined_1024               = 1024
    case paymentDeclined_1025               = 1025
    case paymentFailed_1026                 = 1026
    
    case other
}
