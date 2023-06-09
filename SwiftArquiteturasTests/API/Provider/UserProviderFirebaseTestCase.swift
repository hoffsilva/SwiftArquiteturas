//
//  UserProviderFirebaseTestCase.swift
//  SwiftArquiteturasTests
//
//  Created by Hoff Silva on 2023-06-08.
//

import XCTest
@testable import SwiftArquiteturas

final class UserProviderFirebaseTestCase: XCTestCase {
	
	let provider = UserProviderFirebase()
	
	func test_register_when_the_email_is_not_valid_should_return_an_invalidEmailError() throws {
		let userModel = UserModel(email: "notValidEmail", password: "as234ds")
		let expectation = self.expectation(description: "Scaling")
		provider.register(parameters: userModel) { result in
			switch result {
			case .success:
				XCTFail("Expected invalid email!")
			case .failure(let emailError):
				XCTAssertEqual(AuthError.invalidEmail, emailError)
			}
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 20)
	}
	
	func test_register_when_the_password_is_not_valid_should_return_an_invalidPasswordError() throws {
		let userModel = UserModel(email: "abc@cde.efg", password: "12")
		let expectation = self.expectation(description: "Scaling")
		provider.register(parameters: userModel) { result in
			switch result {
			case .success:
				XCTFail("Expected invalid password!")
			case .failure(let emailError):
				XCTAssertEqual(AuthError.invalidPassword, emailError)
			}
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 20)
	}
	
}
