import Foundation

/// Represents a product in the ecommerce store
public struct Product: Identifiable, Codable, Equatable {
    public let id: UUID
    public let name: String
    public let description: String
    public let price: Decimal
    public let imageURL: String
    public let category: String
    public let inStock: Bool
    
    public init(
        id: UUID = UUID(),
        name: String,
        description: String,
        price: Decimal,
        imageURL: String,
        category: String,
        inStock: Bool = true
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.imageURL = imageURL
        self.category = category
        self.inStock = inStock
    }
}
