//
//  UserProviderFirebaseTestCase.swift
//  SwiftArquiteturasTests
//
//  Created by Hoff Silva on 2023-06-08.
//

import XCTest
@testable import SwiftArquiteturasAPI

final class UserProviderFirebaseTestCase: XCTestCase {
	
	private let sut = UserProviderFirebase()
	
	override func setUp() {
		super.setUp()
		FirebaseConfig.configureFirebase()
	}
	
	func test_register_when_the_email_is_not_valid_should_return_an_invalidEmailError() throws {
		let userModel = UserModel(email: "notValidEmail", password: "as234ds")
		let expectation = self.expectation(description: "Scaling")
		sut.register(parameters: userModel) { result in
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
	
	func test_register_when_the_password_is_does_not_have_at_least_6_characters_should_return_an_invalidPasswordError() throws {
		let userModel = UserModel(email: "abc@cde.efg", password: "12")
		let expectation = self.expectation(description: "Scaling")
		sut.register(parameters: userModel) { result in
			switch result {
			case .success:
				XCTFail("Expected invalid password!")
			case .failure(let passwordError):
				XCTAssertEqual(AuthError.invalidPassword, passwordError)
			}
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 20)
	}
	
	func test_register_when_the_email_is_already_in_use_should_return_an_emailAlreadyInUseError() throws {
		let userModel = UserModel(email: "abc@cde.efg", password: "121231")
		let expectation = self.expectation(description: "Scaling")
		sut.register(parameters: userModel) { result in
			switch result {
			case .success:
				XCTFail("Expected an email already in use!")
			case .failure(let emailError):
				XCTAssertEqual(AuthError.emailAlreadyInUse, emailError)
			}
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 20)
	}
	
}
