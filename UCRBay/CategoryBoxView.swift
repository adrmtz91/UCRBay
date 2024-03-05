import SwiftUI

struct CategoryBoxView: View {
    var category: Category

    var body: some View {
        Text(category.name)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
