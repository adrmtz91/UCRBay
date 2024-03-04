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
    @Published var shouldShowAlert = false
    
    private var user: User
    
    var username: String {
        return user.username
    }
    init() {
        // Initialize the User object
        self.user = User(firstName: "", lastName: "", userID: "",  username: "", email: "", password: "", phoneNumber: "", address: "")
    }
    
    // Register a new user
    func register(firstName: String, lastName: String, email: String, password: String, username: String, phoneNumber: String, address: String, completion: (() -> Void)? = nil) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    self?.shouldShowAlert = true // Trigger the alert
                    // If error, do not set isAuthenticated to true.
                } else {
                    // Set isAuthenticated to true only if registration is successful
                    self?.isAuthenticated = true
                    // Call completion handler if provided
                    completion?()
                }
                
                //Login user after successful regustration
                self?.isAuthenticated = true
                
                // Update user model
                self?.user = User(firstName: authResult?.user.uid ?? "", lastName: firstName, userID: lastName, username: username, email: email, password: password, phoneNumber: phoneNumber, address: address)

                
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
    func updateProfile(username: String, phoneNumber: String, address: String) {
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
            "firstName": user.firstName,
            "lastName": user.lastName,
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
