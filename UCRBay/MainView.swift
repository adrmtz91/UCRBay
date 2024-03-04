import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0

    var body: some View {
        VStack(spacing: 0) {
            switch selectedTab {
            case 0:
                HomeView()
            case 1:
                InboxView()
            case 2:
                PostView()
            case 3:
                MyItemsView()
            case 4:
                UserView()
            default:
                HomeView()
            }
            Spacer()
            AppTabView(selectedTab: $selectedTab)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
