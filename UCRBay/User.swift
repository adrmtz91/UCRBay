//
//  User.swift
//  UCRBay
//

import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseFirestore

class User {
    var firstName: String
    var lastName: String
    var userID: String
    var username: String
    var email: String
    var password: String
    var phoneNumber: String
    var address: String

    init(firstName: String, lastName: String, userID: String, username: String, email: String, password: String, phoneNumber: String, address: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.userID = userID
        self.username = username
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.address = address
    }

    func register(completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                // Optionally, handle additional user data like username, phone number, etc.
                completion(.success(true))
            }
        }
    }
 
    func login(completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: self.email, password: self.password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }

    func logout(completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(true))
        } catch let signOutError as NSError {
            completion(.failure(signOutError))
        }
    }

    func updateProfile(completion: @escaping (Result<Bool, Error>) -> Void) {
        // This method can be more complex depending on what you want to update.
        // For example, updating the email or password.
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = self.username
        // Add other updates here
        changeRequest?.commitChanges { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }

    func deleteAccount(completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().currentUser?.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
            completion(.success(true))
            }
        }
    }


    func storeUserInfo(completion: @escaping (Result<Bool, Error>) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").document(self.userID).setData([
            "firstName": self.firstName,
            "lastName": self.lastName,
            "username": self.username,
            "email": self.email,
            "phoneNumber": self.phoneNumber,
            "address": self.address
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }

}

