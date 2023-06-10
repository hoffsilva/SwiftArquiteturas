//
//  UserManagerProtocol.swift
//  SwiftArquiteturas
//
//  Created by Hoff Silva on 2023-06-08.
//

import Foundation

protocol UserManagerProtocol {
	var userBusiness: UserBusinessProtocol? { get set }
	func login(
		email: String,
		password: String,
		successHandler: @escaping((UserModel) -> Void),
		failureHandler: @escaping((Error?) -> Void)
	)
	func register(
		email: String,
		password: String,
		successHandler: @escaping((UserModel) -> Void),
		failureHandler: @escaping((Error?) -> Void)
	)
}

class UserManager: UserManagerProtocol {
	
	var userBusiness: UserBusinessProtocol?
	
	init(userBusiness: UserBusinessProtocol? = nil) {
		self.userBusiness = userBusiness
	}
	
	func login(email: String, password: String, successHandler: @escaping ((UserModel) -> Void), failureHandler: @escaping ((Error?) -> Void)) {
		userBusiness?.login(email: email, password: password, completionHandler: { result in
			switch result {
			case .success(let userModel):
				successHandler(userModel)
			case .failure(let failure):
				failureHandler(failure)
			}
		}
		)
	}
	
	func register(email: String, password: String, successHandler: @escaping ((UserModel) -> Void), failureHandler: @escaping ((Error?) -> Void)) {
		userBusiness?.register(email: email, password: password, completionHandler: { result in
			switch result {
			case .success(let userModel):
				successHandler(userModel)
			case .failure(let failure):
				failureHandler(failure)
			}
		}
		)
	}
	
	
}
