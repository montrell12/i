import SwiftUI

/// View displaying detailed information about a product
public struct ProductDetailView: View {
    let product: Product
    @EnvironmentObject var cart: ShoppingCart
    @State private var quantity: Int = 1
    @State private var showingAddedAlert = false
    
    public init(product: Product) {
        self.product = product
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Product Image Placeholder
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.2))
                        .aspectRatio(1, contentMode: .fit)
                    
                    Image(systemName: "photo")
                        .font(.system(size: 80))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 12) {
                    // Product Name
                    Text(product.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    // Category
                    Text(product.category)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                    
                    // Price
                    Text("$\(product.price as NSDecimalNumber, formatter: priceFormatter)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                    
                    // Stock Status
                    HStack {
                        Image(systemName: product.inStock ? "checkmark.circle.fill" : "xmark.circle.fill")
                        Text(product.inStock ? "In Stock" : "Out of Stock")
                    }
                    .font(.subheadline)
                    .foregroundColor(product.inStock ? .green : .red)
                    
                    Divider()
                        .padding(.vertical, 8)
                    
                    // Description
                    Text("Description")
                        .font(.headline)
                    
                    Text(product.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Divider()
                        .padding(.vertical, 8)
                    
                    // Quantity Selector
                    HStack {
                        Text("Quantity:")
                            .font(.headline)
                        
                        Spacer()
                        
                        HStack(spacing: 16) {
                            Button(action: {
                                if quantity > 1 {
                                    quantity -= 1
                                }
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .font(.title2)
                            }
                            .disabled(quantity <= 1)
                            
                            Text("\(quantity)")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .frame(minWidth: 40)
                            
                            Button(action: {
                                quantity += 1
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                            }
                        }
                    }
                    
                    // Total Price
                    HStack {
                        Text("Total:")
                            .font(.headline)
                        Spacer()
                        Text("$\((product.price * Decimal(quantity)) as NSDecimalNumber, formatter: priceFormatter)")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 8)
                    
                    // Add to Cart Button
                    Button(action: {
                        cart.addItem(product, quantity: quantity)
                        showingAddedAlert = true
                        quantity = 1
                    }) {
                        Label("Add to Cart", systemImage: "cart.badge.plus")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(product.inStock ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .disabled(!product.inStock)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert("Added to Cart", isPresented: $showingAddedAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("\(quantity) x \(product.name) added to your cart")
        }
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
    NavigationView {
        ProductDetailView(product: Product(
            name: "Wireless Headphones",
            description: "High-quality wireless headphones with noise cancellation.",
            price: 199.99,
            imageURL: "headphones",
            category: "Electronics"
        ))
        .environmentObject(ShoppingCart())
    }
}
