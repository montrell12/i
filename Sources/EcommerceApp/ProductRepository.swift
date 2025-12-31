import Foundation

/// Manages product data and provides sample products
public class ProductRepository: ObservableObject {
    @Published public var products: [Product] = []
    
    public init() {
        loadSampleProducts()
    }
    
    /// Loads sample products for demonstration
    private func loadSampleProducts() {
        products = [
            Product(
                name: "Wireless Headphones",
                description: "High-quality wireless headphones with noise cancellation and 30-hour battery life.",
                price: 199.99,
                imageURL: "headphones",
                category: "Electronics",
                inStock: true
            ),
            Product(
                name: "Smart Watch",
                description: "Fitness tracking smartwatch with heart rate monitor and GPS.",
                price: 299.99,
                imageURL: "watch",
                category: "Electronics",
                inStock: true
            ),
            Product(
                name: "Laptop Backpack",
                description: "Durable laptop backpack with multiple compartments and USB charging port.",
                price: 59.99,
                imageURL: "backpack",
                category: "Accessories",
                inStock: true
            ),
            Product(
                name: "Portable Charger",
                description: "20000mAh portable power bank with fast charging support.",
                price: 39.99,
                imageURL: "charger",
                category: "Electronics",
                inStock: true
            ),
            Product(
                name: "Bluetooth Speaker",
                description: "Waterproof portable speaker with 12-hour battery life.",
                price: 79.99,
                imageURL: "speaker",
                category: "Electronics",
                inStock: true
            ),
            Product(
                name: "Phone Case",
                description: "Protective phone case with reinforced corners and wireless charging support.",
                price: 24.99,
                imageURL: "phonecase",
                category: "Accessories",
                inStock: true
            ),
            Product(
                name: "USB-C Cable",
                description: "Braided USB-C cable with fast charging and data transfer.",
                price: 14.99,
                imageURL: "cable",
                category: "Accessories",
                inStock: true
            ),
            Product(
                name: "Wireless Mouse",
                description: "Ergonomic wireless mouse with precision tracking.",
                price: 34.99,
                imageURL: "mouse",
                category: "Electronics",
                inStock: true
            )
        ]
    }
    
    /// Gets a product by ID
    public func getProduct(by id: UUID) -> Product? {
        return products.first { $0.id == id }
    }
    
    /// Filters products by category
    public func filterByCategory(_ category: String) -> [Product] {
        return products.filter { $0.category == category }
    }
    
    /// Searches products by name or description
    public func search(_ query: String) -> [Product] {
        let lowercaseQuery = query.lowercased()
        return products.filter { 
            $0.name.lowercased().contains(lowercaseQuery) || 
            $0.description.lowercased().contains(lowercaseQuery)
        }
    }
}
