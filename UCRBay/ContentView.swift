//  ContentView.swift
//  UCRBay
//
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("UCRBay")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Login") {
                    viewModel.login(email: username, password: password)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                NavigationLink(destination: RegistrationView()) {
                    Text("Create Account")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(10)
                }
                .padding()
                
                NavigationLink(destination: HomeView(), isActive: $viewModel.isAuthenticated) {
                    EmptyView()
                }
                .padding()
                .navigationTitle("Login")
            }
        }
    }
}
