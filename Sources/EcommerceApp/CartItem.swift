import Foundation

/// Represents an item in the shopping cart
public struct CartItem: Identifiable, Equatable {
    public let id: UUID
    public let product: Product
    public var quantity: Int
    
    public init(id: UUID = UUID(), product: Product, quantity: Int = 1) {
        self.id = id
        self.product = product
        self.quantity = quantity
    }
    
    public var totalPrice: Decimal {
        return product.price * Decimal(quantity)
    }
}
