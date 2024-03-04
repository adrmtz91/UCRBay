import SwiftUI

struct ForgotPassView: View {
    @State private var email: String = ""
    @State private var isEmailValid: Bool = true
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        VStack {
            Text("Forgot Password")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            TextField("Email", text: $email)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8.0)
                .padding(.horizontal)

            if !isEmailValid {
                Text("Please enter a valid email address.")
                    .foregroundColor(.red)
                    .padding(.horizontal)
            }

            Button(action: resetPassword) {
                Text("Reset Password")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8.0)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Password Reset"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func resetPassword() {
        // Perform password reset logic here
        if isValidEmail(email) {
            // If the email is valid, you can proceed with sending a reset link
            alertMessage = "Password reset link sent to \(email)."
        } else {
            // If the email is invalid, show an error message
            isEmailValid = false
            alertMessage = "Please enter a valid email address."
        }
        showingAlert = true
    }

    func isValidEmail(_ email: String) -> Bool {
        // A simple email validation method, you might want to use a more comprehensive one
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPassView()
    }
}
