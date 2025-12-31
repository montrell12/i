import Foundation

/// Manages the shopping cart functionality
public class ShoppingCart: ObservableObject {
    @Published public var items: [CartItem] = []
    
    public init() {}
    
    /// Adds a product to the cart
    /// - Parameters:
    ///   - product: The product to add
    ///   - quantity: The quantity to add (must be positive, defaults to 1)
    public func addItem(_ product: Product, quantity: Int = 1) {
        guard quantity > 0 else { return }
        
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
    /// - Parameters:
    ///   - item: The cart item to update
    ///   - quantity: The new quantity (item is removed if quantity is 0 or negative)
    public func updateQuantity(for item: CartItem, quantity: Int) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        
        if quantity > 0 {
            items[index].quantity = quantity
        } else {
            items.remove(at: index)
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
