import SwiftUI

struct ProductDetailView: View {
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
            
            Text("Category: (product.category)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .navigationTitle(product.name)
    }
}
