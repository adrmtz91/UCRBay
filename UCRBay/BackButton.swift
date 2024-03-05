import SwiftUI

struct BackButton: View {
    @Binding var selectedTab: Int

    var body: some View {
        Button(action: {
            self.selectedTab = 0
        }) {
            HStack {
                Image(systemName: "chevron.left")
            }
        }
    }
}
