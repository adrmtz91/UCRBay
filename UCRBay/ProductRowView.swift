import SwiftUI

struct ProductRow: View {
    let product: Product

    var body: some View {
        HStack {
            Text(product.name)
            Spacer()
            Text(product.price)
        }
    }
}
