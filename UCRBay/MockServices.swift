//
//  MockServices.swift
//  UCRBayTests
//
import Foundation
@testable import UCRBay

class MockAuthenticationService: AuthenticationService {
    var createUserResult: Result<Void, Error>?
    var signInResult: Result<Void, Error>?
    var signOutError: Error?

    func createUser(withEmail email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
            if let result = createUserResult {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }

    func signIn(withEmail email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        if let result = signInResult {
            completion(result)
        }
    }

    func signOut() throws {
        if let error = signOutError {
            throw error
        }
    }
}
