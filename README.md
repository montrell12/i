# Ecommerce App - Swift iOS Application

A modern, SwiftUI-based ecommerce application for iOS with full shopping cart functionality.

## Features

- 📱 **Product Browsing**: Browse a catalog of products with search functionality
- 🔍 **Product Search**: Search products by name or description
- 📦 **Product Details**: View detailed information about each product
- 🛒 **Shopping Cart**: Add products to cart with quantity management
- 💰 **Price Calculation**: Automatic total price calculation
- ✅ **Checkout Process**: Complete checkout flow with order confirmation
- 🎨 **Modern UI**: Clean, native iOS design using SwiftUI

## Architecture

The application follows a clean architecture pattern with:

- **Models**: `Product`, `CartItem` - Core data structures
- **ViewModels**: `ShoppingCart`, `ProductRepository` - Business logic and state management
- **Views**: SwiftUI views for product listing, details, cart, and checkout

## Project Structure

```
Sources/EcommerceApp/
├── Product.swift              # Product model
├── CartItem.swift             # Cart item model
├── ShoppingCart.swift         # Shopping cart state management
├── ProductRepository.swift    # Product data management
├── EcommerceAppView.swift     # Main app view with tab navigation
├── ProductListView.swift      # Product catalog grid view
├── ProductDetailView.swift    # Individual product details
├── CartView.swift            # Shopping cart view
└── CheckoutView.swift        # Checkout form and order placement

Tests/EcommerceAppTests/
├── ProductTests.swift
├── ShoppingCartTests.swift
└── ProductRepositoryTests.swift
```

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.9+

## Installation

### Using Swift Package Manager

1. In Xcode, select File > Add Packages
2. Enter the repository URL
3. Select the version you want to use

Or add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/montrell12/i.git", from: "1.0.0")
]
```

### Manual Integration

1. Clone this repository
2. Copy the `Sources/EcommerceApp` folder into your project
3. Import and use the views in your app

## Usage

### Basic Setup

```swift
import SwiftUI
import EcommerceApp

@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            EcommerceAppView()
        }
    }
}
```

### Using Individual Components

You can also use individual components:

```swift
import SwiftUI
import EcommerceApp

struct ContentView: View {
    @StateObject private var cart = ShoppingCart()
    @StateObject private var repository = ProductRepository()
    
    var body: some View {
        ProductListView()
            .environmentObject(cart)
            .environmentObject(repository)
    }
}
```

## Core Components

### Product Model

```swift
struct Product: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let description: String
    let price: Decimal
    let imageURL: String
    let category: String
    let inStock: Bool
}
```

### Shopping Cart

```swift
class ShoppingCart: ObservableObject {
    @Published var items: [CartItem]
    
    func addItem(_ product: Product, quantity: Int = 1)
    func removeItem(_ item: CartItem)
    func updateQuantity(for item: CartItem, quantity: Int)
    func clear()
    
    var totalPrice: Decimal
    var itemCount: Int
}
```

### Product Repository

```swift
class ProductRepository: ObservableObject {
    @Published var products: [Product]
    
    func getProduct(by id: UUID) -> Product?
    func filterByCategory(_ category: String) -> [Product]
    func search(_ query: String) -> [Product]
}
```

## Testing

Run tests using Swift Package Manager:

```bash
swift test
```

Or in Xcode:
- Press `⌘ + U` to run all tests

## Sample Products

The app comes with 8 sample products across different categories:
- Electronics (headphones, smart watch, speakers, etc.)
- Accessories (backpack, phone case, cables, etc.)

## Customization

### Adding Your Own Products

Modify the `ProductRepository.swift` file to add your own products:

```swift
products = [
    Product(
        name: "Your Product",
        description: "Product description",
        price: 99.99,
        imageURL: "image_name",
        category: "Category",
        inStock: true
    )
]
```

### Styling

The app uses native SwiftUI components and follows iOS design guidelines. You can customize colors, fonts, and layouts by modifying the individual view files.

## Features in Detail

### Product Listing
- Grid layout with adaptive columns
- Product cards with image placeholder, name, and price
- Search bar for filtering products
- Add to cart button on each card

### Product Details
- Large product image
- Full description
- Category badge
- Stock status indicator
- Quantity selector
- Add to cart with quantity

### Shopping Cart
- List of cart items with images
- Quantity adjustment (+ / -)
- Individual item removal
- Item count and total price
- Proceed to checkout button
- Empty cart state

### Checkout
- Contact information form
- Shipping address fields
- Payment information
- Order summary
- Form validation
- Order confirmation alert

## License

This project is available under the MIT License.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

For issues, questions, or contributions, please open an issue on GitHub.