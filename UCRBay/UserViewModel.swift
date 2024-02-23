//
//  UserViewModel.swift
//  UCRBay
//
//  Created by Adrian Mtz on 2/15/24.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

class UserViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    
    private var user: User
    
    init() {
        // Initialize the User object
        self.user = User(userID: "", username: "", email: "", password: "", phoneNumber: 0, address: "")
    }
    
    // Register a new user
    func register(email: String, password: String, username: String, phoneNumber: Int, address: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }
                
                // Update user model
                self?.user = User(userID: authResult?.user.uid ?? "", username: username, email: email, password: password, phoneNumber: phoneNumber, address: address)
                
                // Store additional user info in Firestore
                self?.storeUserInfo()
                self?.isAuthenticated = true
            }
        }
        
    }
    // Login an existing user
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }
                self?.isAuthenticated = true
            }
        }
    }
    
    // Logout the current user
    func logout() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
        } catch let signOutError as NSError {
            errorMessage = signOutError.localizedDescription
        }
    }

    // Update user profile
    func updateProfile(username: String, phoneNumber: Int, address: String) {
        let db = Firestore.firestore()

        // Update local user model
        self.user.username = username
        self.user.phoneNumber = phoneNumber
        self.user.address = address

        // Update Firestore data
        db.collection("users").document(self.user.userID).updateData([
            "username": username,
            "phoneNumber": phoneNumber,
            "address": address
        ]) { [weak self] error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                // Successfully updated user info
            }
        }
    }
    
    // Delete user account
    func deleteAccount() {
        let db = Firestore.firestore()
        guard let user = Auth.auth().currentUser else { return }
        
        // Delete the user's data from Firestore
        db.collection("users").document(user.uid).delete { [weak self] error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                // Successfully deleted user data from Firestore
                // Now delete the user's account from Firebase Auth
                user.delete { error in
                    if let error = error {
                        self?.errorMessage = error.localizedDescription
                    } else {
                        // Successfully deleted user account
                        self?.isAuthenticated = false
                    }
                }
            }
        }
    }

    // Store user information to Firestore
    private func storeUserInfo() {
        let db = Firestore.firestore()
        db.collection("users").document(user.userID).setData([
            "username": user.username,
            "email": user.email,
            "phoneNumber": user.phoneNumber,
            "address": user.address
        ]) { [weak self] error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            }
        }
    }
}
