import SwiftUI

struct HomeView: View {
    let electronicsCategory = Category(name: "Electronics")
    let booksCategory = Category(name: "Books")
    let clothingCategory = Category(name: "Clothing")

    let products: [Product]

    init() {
        products = [
            Product(name: "Laptop", price: "$999", description: "A high-performance laptop with a sleek design.", category: electronicsCategory, imageName: "laptop"),
            Product(name: "Book", price: "$19", description: "An interesting novel.", category: booksCategory, imageName: "book"),
            Product(name: "T-Shirt", price: "$25", description: "A comfortable cotton T-shirt.", category: clothingCategory, imageName: "tshirt")
        ]
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Categories
                Text("Categories")
                    .font(.headline)
                    .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach([electronicsCategory, booksCategory, clothingCategory], id: \.id) { category in
                            NavigationLink(destination: CategoryView(category: category)) {
                                CategoryBoxView(category: category)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // Products
                Text("Featured Products")
                    .font(.headline)
                    .padding(.horizontal)

                ProductListView(products: products)
            }
        }
        .navigationTitle("Home")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}

