//  ContentView.swift
//  UCRBay
//
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var showingRegistrationView = false
    @State private var showingLoginError = false
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
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
                .alert("Login Error", isPresented: $showingLoginError) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(viewModel.errorMessage ?? "An unknown error occurred")
                }
                
                Button("Create Account") {
                    showingRegistrationView = true
                }
                
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.black)
                .padding()
                .background(Color.yellow)
                .cornerRadius(10)
                .padding()
            }
            .navigationTitle("Login/Register")
            .navigationDestination(isPresented: $viewModel.isAuthenticated) {
                    HomeView()
            }
            .navigationDestination(isPresented: $showingRegistrationView) {
                    RegistrationView(isPresented: $showingRegistrationView)
                        .environmentObject(viewModel)
            }
            .alert("Login Error", isPresented: $showingLoginError) {
                Button("OK", role: .cancel) {
                    showingLoginError = false // Dismiss the alert
                    viewModel.errorMessage = nil // Reset the error message
                }
            } message: {
                Text(viewModel.errorMessage ?? "An unknown error occurred")
            }

        }
    }
}

