import SwiftUI

struct PostView: View {
    @State private var postContent: String = ""
    @State private var submittedPost: String? 
    @State private var isShowingAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var alertTitle: String = ""

    var body: some View {
        VStack {
            Text("Create a new post")
                .font(.title)
                .padding()

            TextEditor(text: $postContent)
                .frame(height: 150)
                .padding()

            HStack {
                Button(action: createNewPost) {
                    Text("Create New Post")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8.0)
                        .padding(.horizontal)
                }
                .alert(isPresented: $isShowingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                
                Button(action: submitPost) {
                    Text("Submit Post")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8.0)
                        .padding(.horizontal)
                }
            }

            if let submittedPost = submittedPost {
                Text("Submitted Post:")
                Text(submittedPost)
                    .padding()
            }
        }
    }

    func submitPost() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard !postContent.isEmpty else {
                alertTitle = "Error"
                alertMessage = "Post content cannot be empty."
                isShowingAlert = true
                return
            }
            
            let success = Bool.random()
            if success {
                alertTitle = "Success"
                alertMessage = "Your post has been submitted successfully!"
                isShowingAlert = true
                
                submittedPost = postContent
            } else {
                alertTitle = "Error"
                alertMessage = "Failed to submit the post. Please try again later."
                isShowingAlert = true
            }
        }
    }
    
    func createNewPost() {
        postContent = ""
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
