//
//  UserViewModelRefactored.swift
//  UCRBay
//
//
import Foundation
import Combine

public protocol AuthenticationService {
    func createUser(withEmail email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signIn(withEmail email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signOut() throws
}

class UserViewModelRefactored: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    @Published var shouldShowAlert = false
       
    private var authService: AuthenticationService
    
    init(authService: AuthenticationService) {
        self.authService = authService
    }
    
    // Register a new user
    func register(firstName: String, lastName: String, email: String, password: String, username: String, phoneNumber: String, address: String, completion: (() -> Void)? = nil) {
        authService.createUser(withEmail: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self?.isAuthenticated = true
                case .failure(let error as CustomError):
                    self?.errorMessage = error.errorDescription 
                case .failure(let error):
                    self?.errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
                }
                self?.shouldShowAlert = self?.errorMessage != nil
                completion?()
            }
        }
    }
    
    // Login an existing user
    func login(email: String, password: String, completion: (() -> Void)? = nil) {
        authService.signIn(withEmail: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self?.isAuthenticated = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
                completion?()
            }
        }
    }
    
    // Logout the current user
    func logout() {
        do {
            try authService.signOut()
            isAuthenticated = false
        } catch {
            errorMessage = error.localizedDescription
            shouldShowAlert = true
        }
    }
}
