import SwiftUI

/// View displaying a list of products
public struct ProductListView: View {
    @EnvironmentObject var productRepository: ProductRepository
    @EnvironmentObject var cart: ShoppingCart
    @State private var searchText = ""
    
    public init() {}
    
    private var filteredProducts: [Product] {
        if searchText.isEmpty {
            return productRepository.products
        } else {
            return productRepository.search(searchText)
        }
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 16) {
                    ForEach(filteredProducts) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            ProductCardView(product: product)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationTitle("Products")
            .searchable(text: $searchText, prompt: "Search products")
        }
    }
}

/// Card view for displaying a product in the grid
struct ProductCardView: View {
    let product: Product
    @EnvironmentObject var cart: ShoppingCart
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Placeholder image
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .aspectRatio(1, contentMode: .fit)
                
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.headline)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                Text("$\(product.price as NSDecimalNumber, formatter: priceFormatter)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                
                if !product.inStock {
                    Text("Out of Stock")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            
            Button(action: {
                cart.addItem(product)
            }) {
                Label("Add to Cart", systemImage: "cart.badge.plus")
                    .font(.caption)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!product.inStock)
        }
        .padding(12)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

private let priceFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
}()

#Preview {
    ProductListView()
        .environmentObject(ShoppingCart())
        .environmentObject(ProductRepository())
}
