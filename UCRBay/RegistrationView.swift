//
//  RegistrationView.swift
//  UCRBay
//
//  Created by Adrian Mtz on 2/15/24.
//
import SwiftUI

// Define a custom text field style modifier
struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
    }
}

// Define a view for displaying form errors
struct FormErrorView: View {
    let errorMessage: String

    var body: some View {
        Text(errorMessage)
            .foregroundColor(.red)
            .padding(.horizontal)
            .padding(.top, 2)
    }
}

// Extend the View protocol to include the custom modifier
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

    private var allFieldsFilled: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !username.isEmpty &&
        !email.isEmpty && !password.isEmpty && !phoneNumber.isEmpty && !address.isEmpty
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
        allFieldsFilled && isPasswordStrong && isEmailValid && isPhoneNumberValid
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Information")) {
                    TextField("First Name", text: $firstName)
                        .formTextFieldStyle()
                    
                    TextField("Last Name", text: $lastName)
                        .formTextFieldStyle()
                    
                    TextField("Username", text: $username)
                        .formTextFieldStyle()
                    
                    TextField("Email", text: $email)
                        .formTextFieldStyle()
                    
                    SecureField("Password", text: $password)
                        .formTextFieldStyle()
                    
                    TextField("Phone Number", text: $phoneNumber)
                        .formTextFieldStyle()
                    
                    TextField("Address", text: $address)
                        .formTextFieldStyle()
                }
                
                if !formError.isEmpty {
                    FormErrorView(errorMessage: formError)
                }
                
                Button("Register") {
                    // Reset form error
                    formError = ""
                    // Perform validation checks here before attempting to register
                    if !isEmailValid {
                        formError = "Invalid email format."
                    } else if !isPasswordStrong {
                        formError = "Password must be at least 8 characters including a number, a symbol, and an uppercase letter."
                    } else if !isPhoneNumberValid {
                        formError = "Invalid phone number."
                    }
                    
                    // Only proceed if form is valid
                    if isFormValid {
                        viewModel.register(firstName: firstName, lastName: lastName, email: email, password: password, username: username, phoneNumber: phoneNumber, address: address) {
                            isPresented = false
                        }
                    }
                }
                .disabled(!isFormValid)
            }
            .navigationTitle("Register")
            .alert(isPresented: $viewModel.shouldShowAlert) {
                Alert(title: Text("Registration Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
            }
        }
    }
}
