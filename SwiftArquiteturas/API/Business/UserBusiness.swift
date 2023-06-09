//
//  UserBusiness.swift
//  SwiftArquiteturas
//
//  Created by Hoff Silva on 2023-06-08.
//

import Foundation

protocol UserBusinessProtocol {
	var provider: UserProviderProtocol? { get set }
	var manager: UserManagerProtocol? { get set }
	func login(email: String, password: String, completionHandler: @escaping((Result<UserModel, Error>) -> Void))
	func register(email: String, password: String, completionHandler: @escaping((Result<UserModel, Error>) -> Void))
}

class UserBusiness: UserBusinessProtocol {
	
	var manager: UserManagerProtocol?
	var provider: UserProviderProtocol?
	
	func login(email: String, password: String, completionHandler: @escaping ((Result<UserModel, Error>) -> Void)) {
		provider?.login(parameters: getParams(email: email, password: password), completionHandler: { result in
			switch result {
			case .success(let userModel):
				completionHandler(.success(userModel))
			case .failure(let failure):
				completionHandler(.failure(failure))
			}
		})
	}
	
	func register(email: String, password: String, completionHandler: @escaping ((Result<UserModel, Error>) -> Void)) {
		provider?.register(parameters: getParams(email: email, password: password), completionHandler: { result in
			switch result {
			case .success(let userModel):
				completionHandler(.success(userModel))
			case .failure(let failure):
				completionHandler(.failure(failure))
			}
		})
	}
	
	private func getParams(email: String, password: String) -> [AnyHashable: Any] {
		let userModel = UserModel(email: email, password: password)
		let params: [AnyHashable: Any] = [Constants.ParametersKeys.body.rawValue: [Constants.ParametersKeys.userModel.rawValue: userModel]]
		return params
	}
	
}
