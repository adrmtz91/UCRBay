import Foundation

class Product: Identifiable, ObservableObject {
    let id: UUID
    var name: String
    var price: String
    var description: String?
    var category: Category?
    var imageName: String?

    init(name: String, price: String, description: String? = nil, category: Category? = nil, imageName: String? = nil) {
        self.id = UUID()
        self.name = name
        self.price = price
        self.description = description
        self.category = category
        self.imageName = imageName
    }
}
