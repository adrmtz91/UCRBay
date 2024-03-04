import SwiftUI

class Category: Identifiable, ObservableObject {
    let id: UUID
    var name: String
    var products: [Product]

    init(name: String, products: [Product] = []) {
        self.id = UUID()
        self.name = name
        self.products = products
    }

    func addProduct(_ product: Product) {
        products.append(product)
        product.category = self
    }
}
