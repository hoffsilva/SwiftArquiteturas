//
//  UserProviderStub.swift
//  SwiftArquiteturasTests
//
//  Created by Hoff Silva on 2023-06-08.
//

import XCTest
import FirebaseAuth
import FirebaseCore
@testable import SwiftArquiteturas

final class UserProviderFirebaseStub: UserProviderProtocol {
	
	
	func register(parameters: [AnyHashable : Any], completionHandler: @escaping (Result<SwiftArquiteturas.UserModel, Error>) -> Void) {
		<#code#>
	}
	
	func login(parameters: [AnyHashable : Any], completionHandler: @escaping (Result<SwiftArquiteturas.UserModel, Error>) -> Void) {
		<#code#>
	}

}
