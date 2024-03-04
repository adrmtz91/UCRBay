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
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    // Categories
                    Text("Categories")
                        .font(.headline)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach([electronicsCategory, booksCategory, clothingCategory], id: \.id) { category in
                                Text(category.name)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Products
                    Text("Featured Products")
                        .font(.headline)
                        .padding(.horizontal)

                    ForEach(products) { product in
                        ProductView(product: product)
                    }
                }
            }
            .navigationTitle("Home")
        }

        TabView {
            InboxView()
                .tabItem {
                    Label("Inbox", systemImage: "envelope")
                }

            PostView()
                .tabItem {
                    Label("Post", systemImage: "plus.circle")
                }

            MyItemsView()
                .tabItem {
                    Label("My Items", systemImage: "bag")
                }

            UserView()
                .tabItem {
                    Label("User", systemImage: "person")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
