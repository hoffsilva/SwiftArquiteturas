//
//  UserProvider.swift
//  SwiftArquiteturas
//
//  Created by Hoff Silva on 2023-06-08.
//

import FirebaseAuth

protocol UserProviderProtocol {
	func register(parameters: UserModel, completionHandler: @escaping (Result<UserModel, AuthError>) -> Void)
	func login(parameters: UserModel, completionHandler: @escaping (Result<UserModel, AuthError>) -> Void)
}

class UserProviderFirebase: UserProviderProtocol {
	
	lazy var auth = Auth.auth()
	
	func login(parameters: UserModel, completionHandler: @escaping (Result<UserModel, AuthError>) -> Void) {
		
		self.auth.signIn(withEmail: parameters.email, password: parameters.password) { _, error in
			if let error = error {
				completionHandler(.failure(AuthError(rawValue: error._code)))
			} else {
				completionHandler(.success(parameters))
			}
		}
		
	}
	
	func register(parameters: UserModel, completionHandler: @escaping (Result<UserModel, AuthError>) -> Void) {
		
		self.auth.createUser(withEmail: parameters.email, password: parameters.password) { _, error in
			if let error = error {
				completionHandler(.failure(AuthError(rawValue: error._code)))
			} else {
				completionHandler(.success(parameters))
			}
		}
	}

}
