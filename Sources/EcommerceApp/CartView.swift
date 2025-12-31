import SwiftUI

/// View displaying the shopping cart contents
public struct CartView: View {
    @EnvironmentObject var cart: ShoppingCart
    @State private var showingCheckout = false
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            Group {
                if cart.items.isEmpty {
                    emptyCartView
                } else {
                    cartContentView
                }
            }
            .navigationTitle("Shopping Cart")
            .toolbar {
                if !cart.items.isEmpty {
                    Button("Clear") {
                        cart.clear()
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
    
    private var emptyCartView: some View {
        VStack(spacing: 20) {
            Image(systemName: "cart")
                .font(.system(size: 80))
                .foregroundColor(.gray)
            
            Text("Your cart is empty")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Add some products to get started")
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
    
    private var cartContentView: some View {
        VStack(spacing: 0) {
            List {
                ForEach(cart.items) { item in
                    CartItemRow(item: item)
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        cart.removeItem(cart.items[index])
                    }
                }
            }
            
            // Summary Section
            VStack(spacing: 16) {
                Divider()
                
                HStack {
                    Text("Subtotal (\(cart.itemCount) items)")
                        .font(.headline)
                    Spacer()
                    Text("$\(cart.totalPrice as NSDecimalNumber, formatter: priceFormatter)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .padding(.horizontal)
                
                Button(action: {
                    showingCheckout = true
                }) {
                    Text("Proceed to Checkout")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
            .background(Color(.systemBackground))
        }
        .sheet(isPresented: $showingCheckout) {
            CheckoutView()
        }
    }
}

/// Row view for a cart item
struct CartItemRow: View {
    let item: CartItem
    @EnvironmentObject var cart: ShoppingCart
    
    var body: some View {
        HStack(spacing: 16) {
            // Product Image Placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 80, height: 80)
                
                Image(systemName: "photo")
                    .font(.title)
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.product.name)
                    .font(.headline)
                    .lineLimit(2)
                
                Text("$\(item.product.price as NSDecimalNumber, formatter: priceFormatter)")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                
                HStack(spacing: 12) {
                    Button(action: {
                        cart.updateQuantity(for: item, quantity: item.quantity - 1)
                    }) {
                        Image(systemName: "minus.circle")
                            .font(.title3)
                    }
                    .disabled(item.quantity <= 1)
                    
                    Text("\(item.quantity)")
                        .font(.body)
                        .fontWeight(.semibold)
                        .frame(minWidth: 30)
                    
                    Button(action: {
                        cart.updateQuantity(for: item, quantity: item.quantity + 1)
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title3)
                    }
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
                Text("$\(item.totalPrice as NSDecimalNumber, formatter: priceFormatter)")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Button(action: {
                    cart.removeItem(item)
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.vertical, 8)
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
    CartView()
        .environmentObject({
            let cart = ShoppingCart()
            cart.addItem(Product(
                name: "Wireless Headphones",
                description: "High-quality headphones",
                price: 199.99,
                imageURL: "headphones",
                category: "Electronics"
            ), quantity: 2)
            return cart
        }())
}
