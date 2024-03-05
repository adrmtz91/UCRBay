import SwiftUI

struct CategoryView: View {
    var category: Category

    var body: some View {
        VStack {
            Text("Category: \(category.name)")
                .font(.title)
                .padding()

            ProductListView(products: category.products)
        }
        .navigationTitle(category.name)
    }
}


