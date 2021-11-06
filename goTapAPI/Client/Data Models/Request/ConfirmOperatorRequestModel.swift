//
//  ConfirmOperatorRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/10/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model for confirm operator request.
internal class ConfirmOperatorRequestModel: RequestModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Operator.
	internal private(set) var mobileOperator: ItemID = ItemID()
	
	internal override var serializedModel: AnyObject? {
		
		return mobileOperator.serializedModel
	}
	
	//MARK: Methods
	
	/**
	 Initializes data model with operator.
	 
	 - parameter mobileOperator: Operator.
	 
	 - returns: TPAPIConfirmOperatorRequestModel
	 */
	internal init(mobileOperator: ItemID) {
		
		super.init()
		self.mobileOperator = mobileOperator
	}
	
	public required init() { super.init() }
}
