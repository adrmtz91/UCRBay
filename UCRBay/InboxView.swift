import SwiftUI

struct Message: Identifiable {
    var id = UUID()
    var sender: String
    var content: String
}

struct InboxView: View {
    @State private var messages: [Message] = []

    var body: some View {
        NavigationView {
            List(messages) { message in
                VStack(alignment: .leading) {
                    Text(message.sender)
                        .font(.headline)
                    Text(message.content)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Inbox")
            .onAppear {
                // Simulate receiving messages
                receiveMessages()
            }
        }
    }

    func receiveMessages() {
        // Simulate receiving messages
        let newMessages = [
            Message(sender: "John", content: "Hi there!"),
            Message(sender: "Alice", content: "How are you?"),
            Message(sender: "Bob", content: "What's up?")
        ]
        messages.append(contentsOf: newMessages)
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView()
    }
}
