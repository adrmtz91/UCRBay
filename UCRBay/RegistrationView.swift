//
//  RegistrationView.swift
//  UCRBay
//
//  Created by Adrian Mtz on 2/15/24.
//
import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var viewModel: UserViewModel
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var phoneNumber: String = ""
    @State private var address: String = ""

    var body: some View {
        Form {
            Section(header: Text("User Information")) {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                TextField("Phone Number", text: $phoneNumber)
                TextField("Address", text: $address)
            }

            Button("Register") {
                viewModel.register(email: email, password: password, username: username, phoneNumber: Int(phoneNumber) ?? 0, address: address)
            }
        }
        .navigationTitle("Register")
    }
}

