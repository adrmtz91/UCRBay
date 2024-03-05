import SwiftUI

struct AppTabView: View {
    @Binding var selectedTab: Int
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView{HomeView()}
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)

            NavigationView{InboxView()}
                .tabItem {
                    Label("Inbox", systemImage: "envelope")
                }
                .tag(1)

            NavigationView{PostView()}
                .tabItem {
                    Label("Post", systemImage: "plus.circle")
                }
                .tag(2)

            NavigationView{MyItemsView()}
                .tabItem {
                    Label("My Items", systemImage: "bag")
                }
                .tag(3)

            NavigationView{UserView()}
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
