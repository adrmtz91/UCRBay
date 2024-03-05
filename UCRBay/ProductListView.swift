import SwiftUI

struct ProductListView: View {
    let products: [Product]

    var body: some View {
        List(products) { product in
            NavigationLink(destination: ProductDetailView(product: product)) {
                ProductRow(product: product) 
            }
        }
    }
}
