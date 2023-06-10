//
//  UserProviderFirebaseTestCase.swift
//  SwiftArquiteturasTests
//
//  Created by Hoff Silva on 2023-06-08.
//

import XCTest
@testable import SwiftArquiteturas

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
			case .success(let response):
				XCTFail("Expected that \(response.email) was invalid!")
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
			case .success(let response):
				XCTFail("Expected that \(response.password) was invalid - less than 6 characters!")
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
			case .success(let response):
				XCTFail("Expected that \(response.email) was already in use!")
			case .failure(let emailError):
				XCTAssertEqual(AuthError.emailAlreadyInUse, emailError)
			}
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 20)
	}
	
	func test_login_when_the_user_not_found_should_return_an_userNotFoundError() throws {
		let userModel = UserModel(email: "abc@cdef.efg", password: "abc@cde.efg")
		let expectation = self.expectation(description: "Scaling")
		sut.login(parameters: userModel) { result in
			switch result {
			case .success(let response):
				XCTFail("Expected \(response.email) was not registered!")
			case .failure(let userError):
				XCTAssertEqual(AuthError.userNotFound, userError)
			}
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 20)
	}
	
	func test_login_when_the_user_is_disabled_should_return_an_userDisabledError() throws {
		let userModel = UserModel(email: "disabled@disabled.disabled", password: "disabled@disabled.disabled")
		let expectation = self.expectation(description: "Scaling")
		sut.login(parameters: userModel) { result in
			switch result {
			case .success(let response):
				XCTFail("Expected that \(response.email) was disabled!")
			case .failure(let userError):
				XCTAssertEqual(AuthError.userDisabled, userError)
			}
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 20)
	}
	
	func test_login_when_the_password_is_incorrect_should_return_an_wrongPasswordError() throws {
		let password = "abc@cde.ef"
		let userModel = UserModel(email: "abc@cde.efg", password: password)
		let expectation = self.expectation(description: "Scaling")
		sut.login(parameters: userModel) { result in
			switch result {
			case .success(let response):
				XCTFail("Expected that the password \(response.password) was not equal to \(password)!")
			case .failure(let userError):
				XCTAssertEqual(AuthError.wrongPassword, userError)
			}
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 20)
	}
	
	func test_login_when_the_email_is_not_valid_should_return_an_invalidEmailError() throws {
		let userModel = UserModel(email: "notValidEmail", password: "abc@cde.efg")
		let expectation = self.expectation(description: "Scaling")
		sut.login(parameters: userModel) { result in
			switch result {
			case .success(let response):
				XCTFail("Expected that \(response.email) was invalid!")
			case .failure(let emailError):
				XCTAssertEqual(AuthError.invalidEmail, emailError)
			}
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 20)
	}
	
}
