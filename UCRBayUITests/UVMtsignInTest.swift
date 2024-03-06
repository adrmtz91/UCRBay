//
//  testLoginFailure.swift
//  UCRBayTests
//

import XCTest
@testable import UCRBay

class UVMsignInTest: XCTestCase {
    var viewModel: UserViewModelRefactored!
    var mockAuthService: MockAuthenticationService!
    
    override func setUpWithError() throws {
        mockAuthService = MockAuthenticationService()
        viewModel = UserViewModelRefactored(authService: mockAuthService)
    }
    
    func testLoginSuccess() {
        mockAuthService.signInResult = .success(Void())
        let expectation = self.expectation(description: "Login should succeed")
        viewModel.login(email: "valid@example.com", password: "correctPassword") {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertTrue(viewModel.isAuthenticated, "User should be authenticated on login success")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil on login success")
    }

    func testLoginFailure() {
        let expectedError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Login failed"])
        mockAuthService.signInResult = .failure(expectedError)
        let expectation = self.expectation(description: "Login should fail")
        viewModel.login(email: "wrong@example.com", password: "password") {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertFalse(viewModel.isAuthenticated, "User should not be authenticated on login failure")
        XCTAssertNotNil(viewModel.errorMessage, "Error message should be set on login failure")
        XCTAssertEqual(viewModel.errorMessage, expectedError.localizedDescription, "Error message should match the simulated error")
    }
    
    func testLoginWithIncorrectPassword() {
        let incorrectPasswordError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "The password is incorrect."])
        mockAuthService.signInResult = .failure(incorrectPasswordError)
        let expectation = self.expectation(description: "Login should fail with incorrect password")
        viewModel.login(email: "correct@example.com", password: "wrongPassword") {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertFalse(viewModel.isAuthenticated, "User should not be authenticated with incorrect password")
        XCTAssertNotNil(viewModel.errorMessage, "Error message should be set for incorrect password")
        XCTAssertEqual(viewModel.errorMessage, incorrectPasswordError.localizedDescription, "Error message should match the incorrect password error")
    }
    
    func testLoginWithUnregisteredEmail() {
        let userNotFoundError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found."])
        mockAuthService.signInResult = .failure(userNotFoundError)
        let expectation = self.expectation(description: "Login should fail with unregistered email")
        viewModel.login(email: "unregistered@example.com", password: "password") {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertFalse(viewModel.isAuthenticated, "User should not be authenticated with unregistered email")
        XCTAssertNotNil(viewModel.errorMessage, "Error message should be set for unregistered email")
        XCTAssertEqual(viewModel.errorMessage, userNotFoundError.localizedDescription, "Error message should match the user not found error")
    }
    
    func testLoginWithAccountLocked() {
        let accountLockedError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Your account has been locked due to too many failed login attempts. Please contact support to unlock your account."])
        mockAuthService.signInResult = .failure(accountLockedError)
        let expectation = self.expectation(description: "Login should fail because the account is locked")
        viewModel.login(email: "locked@example.com", password: "password") {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)

        XCTAssertFalse(viewModel.isAuthenticated, "User should not be authenticated when the account is locked")
        XCTAssertNotNil(viewModel.errorMessage, "Error message should be set for an account lock")
        XCTAssertEqual(viewModel.errorMessage, accountLockedError.localizedDescription, "Error message should match the account locked error")
    }

}
