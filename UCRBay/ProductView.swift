import SwiftUI

struct ProductView: View {
    var product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            if let imageName = product.imageName {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 2)
            }
            
            Text(product.name)
                .font(.title)
                .padding(.bottom, 2)
            
            Text(product.price)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.bottom, 2)
            
            if let description = product.description {
                Text(description)
                    .font(.body)
                    .padding(.bottom, 2)
            }
            
            if let category = product.category {
                Text("Category: \(category.name)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        let electronicsCategory = Category(name: "Electronics")
        
        return ProductView(product: Product(name: "Laptop", price: "$999", description: "A high-performance laptop with a sleek design.", category: electronicsCategory, imageName: "laptop"))
    }
}
