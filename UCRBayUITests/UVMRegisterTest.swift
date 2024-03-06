//
//  UVMRegisterTest.swift
//  UCRBayTests
//

import XCTest
@testable import UCRBay

class UVMRegisterTests: XCTestCase {
    var viewModel: UserViewModelRefactored!
    var mockAuthService: MockAuthenticationService!

    override func setUpWithError() throws {
        mockAuthService = MockAuthenticationService()
        viewModel = UserViewModelRefactored(authService: mockAuthService)
    }

    func testRegisterSuccess() {
        mockAuthService.createUserResult = .success(())
        let expectation = self.expectation(description: "Successful registration")
        viewModel.register(firstName: "Test", lastName: "User", email: "test@example.com", password: "password", username: "testUser", phoneNumber: "1234567890", address: "123 Test St") {
            XCTAssertTrue(self.viewModel.isAuthenticated, "The user should be authenticated after a successful registration.")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testRegisterWithInvalidEmail() {
        mockAuthService.createUserResult = .failure(CustomError.invalidEmailFormat)
        let expectation = self.expectation(description: "Registration should fail due to invalid email format")
        viewModel.register(firstName: "Test", lastName: "User", email: "bademail", password: "password", username: "testUser", phoneNumber: "1234567890", address: "123 Test St") {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertFalse(viewModel.isAuthenticated)
        XCTAssertNotNil(viewModel.errorMessage)
    }

    func testRegisterWithWeakPassword() {
        mockAuthService.createUserResult = .failure(CustomError.weakPassword)
        let expectation = self.expectation(description: "Registration should fail due to weak password")
        viewModel.register(firstName: "Test", lastName: "User", email: "test@example.com", password: "123", username: "testUser", phoneNumber: "1234567890", address: "123 Test St") {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertFalse(viewModel.isAuthenticated)
        XCTAssertNotNil(viewModel.errorMessage)
    }

    func testRegisterWithDuplicateUsername() {
        mockAuthService.createUserResult = .failure(CustomError.usernameAlreadyExists)
        let expectation = self.expectation(description: "Registration should fail due to duplicate username")
        viewModel.register(firstName: "Test", lastName: "User", email: "test@example.com", password: "password", username: "existingUser", phoneNumber: "1234567890", address: "123 Test St") {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertFalse(viewModel.isAuthenticated)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    func testRegisterWithMissingFields() {
        mockAuthService.createUserResult = .failure(CustomError.missingRequiredFields)
        let expectation = self.expectation(description: "Registration should fail due to missing required fields")
        viewModel.register(firstName: "", lastName: "", email: "", password: "", username: "", phoneNumber: "", address: "") {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertFalse(viewModel.isAuthenticated)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    func testRegisterWithInvalidPhoneNumber() {
        mockAuthService.createUserResult = .failure(CustomError.invalidPhoneNumberFormat)
        let expectation = self.expectation(description: "Registration should fail due to invalid phone number format")
        viewModel.register(firstName: "Test", lastName: "User", email: "test@example.com", password: "password", username: "testUser", phoneNumber: "notaphonenumber", address: "123 Test St") {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertFalse(viewModel.isAuthenticated)
        XCTAssertNotNil(viewModel.errorMessage)
    }


}
