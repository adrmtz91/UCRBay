import SwiftUI

struct AppTabView: View {
    @Binding var selectedTab: Int
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)

            InboxView()
                .tabItem {
                    Label("Inbox", systemImage: "envelope")
                }
                .tag(1)

            PostView()
                .tabItem {
                    Label("Post", systemImage: "plus.circle")
                }
                .tag(2)

            MyItemsView()
                .tabItem {
                    Label("My Items", systemImage: "bag")
                }
                .tag(3)

            UserView()
                .tabItem {
                    Label("User", systemImage: "person")
                }
                .tag(4)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TabView_Previews: PreviewProvider {
    @State static private var selectedPreviewTab = 0
    
    static var previews: some View {
        AppTabView(selectedTab: $selectedPreviewTab)
    }
}
