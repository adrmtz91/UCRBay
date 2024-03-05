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
        if !self.products.contains(where: { $0.id == product.id }) {
            self.products.append(product)
        }
    }
}
