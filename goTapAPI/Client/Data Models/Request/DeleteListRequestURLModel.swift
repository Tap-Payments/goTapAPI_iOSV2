//
//  DeleteListRequestURLModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/10/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request URL model for delete list request.
internal class DeleteListRequestURLModel: goTapAPI.RequestModel {

	//MARK: - Internal -
	//MARK: Properties
	
	/// Defines if list should be deleted permanently. true - permanently, false - current month.
	internal private(set) var deletePermanently: Swift.Bool = false
	
	internal override var serializedModel: AnyObject? {
		
		let result: [String: Any] = [
			
			goTapAPI.Constants.Key.Option: self.deletePermanently ? goTapAPI.Constants.Value.DP : goTapAPI.Constants.Value.D
		]
		
		return result as AnyObject
	}
	
	//MARK: Methods
	
	/**
	 Initializes data model with delete permanently value.
	 
	 - parameter deletePermanently: Defines if list should be deleted permanently. true - permanently, false - current month.
	 
	 - returns: DeleteListRequestURLModel
	 */
	internal init(deletePermanently: Swift.Bool) {
		
		super.init()
		self.deletePermanently = deletePermanently
	}
	
	public required init() { super.init() }
}