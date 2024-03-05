import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0

    var body: some View {
        VStack(spacing: 0) {
            
            AppTabView(selectedTab: $selectedTab)
        }
    }
    
    private var navigationTitle: String {
        switch selectedTab {
        case 0:
            return "Home"
        case 1:
            return "Inbox"
        case 2:
            return "Post"
        case 3:
            return "My Items"
        case 4:
            return "User"
        default:
            return ""
        }
    }
}
