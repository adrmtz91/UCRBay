import SwiftUI

struct AppTabView: View {
    @Binding var selectedTab: Int
    
    init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.black//  background color
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.systemGray4 // Unselected icon color
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGray4]
        
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemBlue// Selected icon color
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView{HomeView()
                    .background(Image("backdrop")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all))
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            .tag(0)
            
            NavigationView{InboxView()

        }
        .tabItem {
            Label("Inbox", systemImage: "envelope")
        }
        .tag(1)
        
        NavigationView{PostView()
                .background(Image("v4")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all))
        }
        .tabItem {
            Label("Post", systemImage: "plus.circle")
        }
        .tag(2)
        
        NavigationView{MyItemsView()
                .background(Image("v4")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all))
        }
        .tabItem {
            Label("My Items", systemImage: "bag")
        }
        .tag(3)
        
        NavigationView{UserView()
                .background(Image("v4")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all))
        }
        .tabItem {
            Label("User", systemImage: "person")
        }
        .tag(4)
    
    }
        .accentColor(.blue)
        .edgesIgnoringSafeArea(.bottom)
 }
}

struct TabView_Previews: PreviewProvider {
    @State static private var selectedPreviewTab = 0
    
    static var previews: some View {
        AppTabView(selectedTab: $selectedPreviewTab)
    }
}
