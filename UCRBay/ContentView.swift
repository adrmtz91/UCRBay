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
    @State private var showingForgotPasswordView = false
    @State private var selectedTab = 0

    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("v4") // Assuming you've added a logo image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Image("logo")
                    .resizable()
                    .scaledToFit()
                
                    Text(" Login")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                
                    TextField("  Username", text: $username)
                        .padding(.vertical, 6)
                        .background(Color.white)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.yellow, lineWidth: 2)
                            )
                        .padding(.horizontal, 55)
                        .overlay(
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundColor(.yellow)
                                    .padding(.leading, 25)
                                Spacer()
                            }
                        )
                    .padding(.bottom, 8)
                    
                    if showPassword {
                        TextField("  Password", text: $password) //Visible password
                            .padding(.vertical, 6)
                            .background(Color.white)
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.yellow, lineWidth: 1)
                                )
                            .padding(.horizontal, 55)
                            .overlay(
                                HStack {
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(.yellow)
                                        .padding(.leading, 25)
                                        Spacer()
                                        Button(action: {
                                            self.showPassword.toggle()
                                        }) {
                                            Image(systemName: "eye.slash.fill")
                                                .foregroundColor(.blue)
                                                .padding(.trailing, 65)
                                            }
                                        }
                                    )
                                    .padding(.bottom, 8)
                            } else {
                                SecureField("  Password", text: $password) // Hidden password
                                    .padding(.vertical, 6)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.yellow, lineWidth: 2)
                                    )
                                    .padding(.horizontal, 55)
                                    .overlay(
                                        HStack {
                                            Image(systemName: "lock.fill")
                                                .foregroundColor(.yellow)
                                                .padding(.leading, 25)
                                            Spacer()
                                            Button(action: {
                                                self.showPassword.toggle()
                                            }) {
                                            Image(systemName: "eye.fill")
                                                .foregroundColor(.blue)
                                                .padding(.trailing, 65)
                                            }
                                        }
                                    )
                                    .padding(.bottom, 8)
                            }
                            Button("Login") {
                                viewModel.login(email: username, password: password)
                            }
                            .padding(.vertical, 10)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.horizontal, 70)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(1)]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(10)
                            .shadow(radius: 6)
                            .padding(.bottom, 5)
                    
                            Button("Forgot Password") {
                                showingForgotPasswordView = true
                            }
                            .foregroundColor(.red)
                            .font(.system(size: 18))
                            .padding(.vertical, 3)
                            .cornerRadius(10)
                            .padding(.horizontal, 10)
                            .fontWeight(.semibold)
                    
                            Text("Don't have an account yet?")
                                .foregroundColor(.black)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
        
                            Button(action: {
                                showingRegistrationView = true
                            }) {
                            Text("Sign Up")
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(1), Color.yellow.opacity(1)]), startPoint: .top, endPoint: .bottom))
                                .cornerRadius(10)
                                .shadow(radius: 6)
                                .padding(.bottom, 20)
                                
                            }
                            .foregroundColor(.white)
                            .padding(.top, 5)
                            
                        }
                        .navigationTitle("Welcome!")
                        .navigationDestination(isPresented: $viewModel.isAuthenticated){
                            AppTabView(selectedTab: $selectedTab)
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
                .sheet(isPresented: $showingForgotPasswordView) {
                    ForgotPassView()
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
