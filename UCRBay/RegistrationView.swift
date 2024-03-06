//
//  RegistrationView.swift
//  UCRBay
//
//  Created by Adrian Mtz on 2/15/24.
//
import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14))
            .padding(.vertical, 11)
            .padding(.horizontal)
            .background(Color.white.opacity(0.5))
            .foregroundColor(.black)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.blue, lineWidth: 1)
            )
            .frame(height: 40)
    }
}
struct FormErrorView: View {
    let errorMessage: String

    var body: some View {
        Text(errorMessage)
            .foregroundColor(.red)
            .padding(.horizontal)
            .padding(.top, 2)
    }
}
extension View {
    func formTextFieldStyle() -> some View {
        self.modifier(TextFieldModifier())
    }
}


struct RegistrationView: View {
    @EnvironmentObject var viewModel: UserViewModel
    @Binding var isPresented: Bool
    
    @State private var formError: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var phoneNumber: String = ""
    @State private var address: String = ""
    @State private var isEmailValidFlag = true
    @State private var isPasswordStrongFlag = true
    
    private var allFieldsFilled: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !username.isEmpty &&
        !email.isEmpty && !password.isEmpty
    }
    
    private var isPasswordStrong: Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[!@#$&*]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    private var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    private var isPhoneNumberValid: Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phoneNumber)
    }
    
    private var isFormValid: Bool {
        allFieldsFilled && isPasswordStrong && isEmailValid
    }
    
    var body: some View {
        ZStack {
            Image("v4")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                
            VStack(spacing: 5){
                Spacer(minLength: 2)
                NavigationView {
                    VStack(spacing: 0) {
                    Form {
                        Section(header: Text("User Information").foregroundColor(.yellow)) {
                                TextField("First Name", text: $firstName).formTextFieldStyle()
                                TextField("Last Name", text: $lastName).formTextFieldStyle()
                                TextField("Username", text: $username).formTextFieldStyle()
                                TextField("Email", text: $email)
                                    .formTextFieldStyle()
                                    .onChange(of: email) {
                                        isEmailValidFlag = isEmailValid
                                    }
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(isEmailValidFlag ? Color.blue : Color.red, lineWidth: 1)
                                    )
                                if !isEmailValidFlag && !email.isEmpty {
                                    Text("Invalid email format.")
                                        .foregroundColor(.red)
                                        .padding(.leading)
                                }
                                SecureField("Password", text: $password)
                                    .formTextFieldStyle()
                                    .onChange(of: password) {
                                        isPasswordStrongFlag = isPasswordStrong
                                    }
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(isPasswordStrongFlag ? Color.blue : Color.red, lineWidth: 1)
                                    )
                                if !isPasswordStrongFlag && !password.isEmpty {
                                    Text("Password must be at least 8 characters including a number, a symbol, and an uppercase letter.")
                                        .foregroundColor(.red)
                                        .padding(.leading)
                                }
                                TextField("Phone Number (Optional)", text: $phoneNumber).formTextFieldStyle()
                            }
                            .listRowBackground(Color.blue.opacity(0.1))
                            
                            if !formError.isEmpty {
                                FormErrorView(errorMessage: formError)
                                    .listRowBackground(Color.blue.opacity(0.1))
                            }
                            
                            Button("Register") {
                                formError = ""
                                
                                if isFormValid {
                                    viewModel.register(firstName: firstName, lastName: lastName, email: email, password: password, username: username, phoneNumber: phoneNumber, address: address) {
                                        isPresented = false
                                    }
                                }
                            }
                            .disabled(!isFormValid)
                            .listRowBackground(Color.yellow.opacity(0.8))
                        }
                        .navigationTitle("Register")
                        .navigationBarTitleDisplayMode(.inline)
                        .background(Color.yellow)
                        .alert(isPresented: $viewModel.shouldShowAlert) {
                            Alert(title: Text("Registration Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
                        }
                        .background(Color.clear.edgesIgnoringSafeArea(.all))
                    }
                }
                .background(Color.clear.edgesIgnoringSafeArea(.all))
                    
                Spacer(minLength: 1)
                    
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 88)
                    .padding(.bottom, 1)
                    .padding(.trailing, 20)
            }
            .padding(.vertical, 1)
        }
        .background(Color.clear.edgesIgnoringSafeArea(.all))
    }
}
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(isPresented: .constant(true))
            .environmentObject(UserViewModel()) // Assuming you have this object
    }
}
