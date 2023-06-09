//
//  UserProvider.swift
//  SwiftArquiteturas
//
//  Created by Hoff Silva on 2023-06-08.
//

import FirebaseAuth

protocol UserProviderProtocol {
	func register(parameters: [AnyHashable: Any], completionHandler: @escaping (Result<UserModel, Error>) -> Void)
	func login(parameters: [AnyHashable: Any], completionHandler: @escaping (Result<UserModel, Error>) -> Void)
}

class UserProviderFirebase: UserProviderProtocol {
	
	lazy var auth = Auth.auth()
	
	func login(parameters: [AnyHashable : Any], completionHandler: @escaping (Result<UserModel, Error>) -> Void) {
		let body: NSDictionary = parameters[Constants.ParametersKeys.body.rawValue] as! NSDictionary
		let userModel = body[Constants.ParametersKeys.userModel] as! UserModel
		
		self.auth.signIn(withEmail: userModel.email, password: userModel.password) { _, error in
			if let error = error {
				completionHandler(.failure(error))
			} else {
				completionHandler(.success(userModel))
			}
		}
		
	}
	
	func register(parameters: [AnyHashable : Any], completionHandler: @escaping (Result<UserModel, Error>) -> Void) {
		let body: NSDictionary = parameters[Constants.ParametersKeys.body.rawValue] as! NSDictionary
		let userModel = body[Constants.ParametersKeys.userModel] as! UserModel
		
		self.auth.createUser(withEmail: userModel.email, password: userModel.password) { _, error in
			if let error = error {
				completionHandler(.failure(error))
			} else {
				completionHandler(.success(userModel))
			}
		}
	}

}
