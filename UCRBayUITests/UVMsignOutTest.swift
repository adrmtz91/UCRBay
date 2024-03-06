//
//  UVMtestLogout.swift
//  UCRBayTests
//

import XCTest
@testable import UCRBay

class UVMtsignOutTest: XCTestCase {
    var viewModel: UserViewModelRefactored!
    var mockAuthService: MockAuthenticationService!
    
    override func setUpWithError() throws {
        mockAuthService = MockAuthenticationService()
        viewModel = UserViewModelRefactored(authService: mockAuthService)
    }
    
    func testLogout() {
        mockAuthService.signOutError = nil
        viewModel.logout()
        
        XCTAssertFalse(viewModel.isAuthenticated, "User should be logged out")
    }

    func testLogoutFailure() {
        let error = NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Logout failed"])
        mockAuthService.signOutError = error
        viewModel.logout()
        
        XCTAssertNotNil(viewModel.errorMessage, "Error message should be set")
        XCTAssertEqual(viewModel.errorMessage, "Logout failed", "Error message should match the simulated error")
    }
    
     func testLogoutWhenAlreadyLoggedOut() {
        viewModel.isAuthenticated = false
        viewModel.logout()
        
        XCTAssertFalse(viewModel.isAuthenticated, "Logout should have no effect when the user is already logged out")
    }
}
