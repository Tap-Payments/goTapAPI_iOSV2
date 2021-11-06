//
//  PhoneVerificationRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model for phone verification request.
internal class PhoneVerificationRequestModel: RequestModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Phone verification model.
	internal private(set) var mobileVerify: MobileVerify = MobileVerify()
	
	internal override var serializedModel: AnyObject? {
		
		guard var result = super.serializedModel as? [String: Any] else { return nil }
		
		result[Constants.Key.MobileVerify] = mobileVerify.serializedModel ?? NSNull()

		return result as AnyObject
	}
	
	//MARK: Methods
	
	/**
	 Initializes data model with mobile verify.
	 
	 - parameter mobileVerify: Mobile verify.
	 
	 - returns: TPAPIVerifyPhoneRequestModel
	 */
	internal init(mobileVerify: MobileVerify!) {
		
		super.init()
		self.mobileVerify = mobileVerify
	}
	
	public required init() { super.init() }
}
