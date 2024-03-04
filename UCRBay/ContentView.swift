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
    @State private var showPassword = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logoImage") // Assuming you've added a logo image
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 20)
                Text(" Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                TextField("Username", text: $username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    
                    .padding(.horizontal, 10)
                    .overlay(
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                                .padding(.leading, 15)
                            Spacer()
                        }
                    )
                
                if showPassword {
                    TextField("Password", text: $password) // Use TextField for visible password
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal, 10)
                        .overlay(
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 15)
                                Spacer()
                                Button(action: {
                                    self.showPassword.toggle()
                                }) {
                                    Image(systemName: "eye.slash.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 15)
                                }
                            }
                        )
                } else {
                    SecureField("Password", text: $password) // SecureField for hidden password
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 4)
                        )
                        .padding(.horizontal, 10)
                        .overlay(
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 15)
                                Spacer()
                                Button(action: {
                                    self.showPassword.toggle()
                                }) {
                                    Image(systemName: "eye.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 15)
                                }
                            }
                        )
                }
                HStack {
                        VStack { Divider() }
                        Text("or")
                        VStack { Divider() }
                      }
                Button("Login") {
                    viewModel.login(email: username, password: password)
                }
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(10)
                .shadow(radius: 5)
                
                Button("Sign Up") {
                    showingRegistrationView = true
                }
                .foregroundColor(.blue)
                .padding()
                .cornerRadius(10)
                .padding()
            }
            .navigationTitle("Welcome!")
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
