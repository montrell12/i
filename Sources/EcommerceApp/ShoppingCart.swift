import Foundation

/// Manages the shopping cart functionality
public class ShoppingCart: ObservableObject {
    @Published public var items: [CartItem] = []
    
    public init() {}
    
    /// Adds a product to the cart
    public func addItem(_ product: Product, quantity: Int = 1) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += quantity
        } else {
            let item = CartItem(product: product, quantity: quantity)
            items.append(item)
        }
    }
    
    /// Removes an item from the cart
    public func removeItem(_ item: CartItem) {
        items.removeAll { $0.id == item.id }
    }
    
    /// Updates the quantity of an item in the cart
    public func updateQuantity(for item: CartItem, quantity: Int) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            if quantity > 0 {
                items[index].quantity = quantity
            } else {
                items.remove(at: index)
            }
        }
    }
    
    /// Clears all items from the cart
    public func clear() {
        items.removeAll()
    }
    
    /// Calculates the total price of all items in the cart
    public var totalPrice: Decimal {
        return items.reduce(0) { $0 + $1.totalPrice }
    }
    
    /// Returns the total number of items in the cart
    public var itemCount: Int {
        return items.reduce(0) { $0 + $1.quantity }
    }
}
