import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

// Model for Message

// Manager to handle messages (Firestore interactions)



// View to display message field for sending new messages

// Main InboxView
struct InboxView: View {
    @StateObject var messagesManager = MessagesManager()
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(messagesManager.messages) { message in
                    MessageView(message: message)
                }
            }
            .padding(.top, 10)
            .background(Color.white)
            .cornerRadius(30)
                
            MessageField()
                .environmentObject(messagesManager)
        }
        .background(Color("Peach"))
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView()
    }
}

