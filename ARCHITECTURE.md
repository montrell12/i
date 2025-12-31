# EcommerceApp Architecture

## Project Overview

This document provides a technical overview of the EcommerceApp architecture and design patterns.

## Architecture Pattern

The app follows the **MVVM (Model-View-ViewModel)** architecture pattern with SwiftUI:

```
┌─────────────────────────────────────────────┐
│              Views (SwiftUI)                │
│  ┌─────────────────────────────────────┐   │
│  │ EcommerceAppView (Main Container)   │   │
│  │  ├─ ProductListView                 │   │
│  │  │   └─ ProductCardView             │   │
│  │  ├─ ProductDetailView                │   │
│  │  ├─ CartView                         │   │
│  │  │   └─ CartItemRow                  │   │
│  │  └─ CheckoutView                     │   │
│  └─────────────────────────────────────┘   │
└───────────────┬─────────────────────────────┘
                │ @EnvironmentObject
┌───────────────┴─────────────────────────────┐
│         ViewModels (Observable)             │
│  ┌─────────────────────────────────────┐   │
│  │ ShoppingCart (State Management)     │   │
│  │  - @Published items: [CartItem]     │   │
│  │  - addItem()                         │   │
│  │  - removeItem()                      │   │
│  │  - updateQuantity()                  │   │
│  │  - clear()                           │   │
│  │  - totalPrice computed property      │   │
│  │  - itemCount computed property       │   │
│  └─────────────────────────────────────┘   │
│                                             │
│  ┌─────────────────────────────────────┐   │
│  │ ProductRepository (Data Source)     │   │
│  │  - @Published products: [Product]   │   │
│  │  - getProduct(by:)                   │   │
│  │  - filterByCategory()                │   │
│  │  - search()                          │   │
│  └─────────────────────────────────────┘   │
└───────────────┬─────────────────────────────┘
                │ Uses
┌───────────────┴─────────────────────────────┐
│              Models (Data)                  │
│  ┌─────────────────────────────────────┐   │
│  │ Product                              │   │
│  │  - id: UUID                          │   │
│  │  - name: String                      │   │
│  │  - description: String               │   │
│  │  - price: Decimal                    │   │
│  │  - imageURL: String                  │   │
│  │  - category: String                  │   │
│  │  - inStock: Bool                     │   │
│  └─────────────────────────────────────┘   │
│                                             │
│  ┌─────────────────────────────────────┐   │
│  │ CartItem                             │   │
│  │  - id: UUID                          │   │
│  │  - product: Product                  │   │
│  │  - quantity: Int                     │   │
│  │  - totalPrice computed property      │   │
│  └─────────────────────────────────────┘   │
└─────────────────────────────────────────────┘
```

## Data Flow

### 1. Product Browsing Flow
```
ProductRepository loads sample data
        ↓
ProductListView displays products
        ↓
User searches/browses
        ↓
Filtered products displayed
        ↓
User taps product
        ↓
ProductDetailView shows details
```

### 2. Add to Cart Flow
```
User selects quantity
        ↓
Taps "Add to Cart"
        ↓
ShoppingCart.addItem() called
        ↓
@Published items array updated
        ↓
All views observing cart refresh
        ↓
Cart badge updates
        ↓
Confirmation alert shown
```

### 3. Checkout Flow
```
User opens CartView
        ↓
Reviews items
        ↓
Taps "Proceed to Checkout"
        ↓
CheckoutView presented as sheet
        ↓
User fills form
        ↓
Validation checks pass
        ↓
"Place Order" enabled
        ↓
Order confirmed
        ↓
Cart cleared
        ↓
Success alert shown
```

## State Management

### Environment Objects
The app uses SwiftUI's `@EnvironmentObject` property wrapper to share state across views:

```swift
// Injected at root level
@StateObject private var cart = ShoppingCart()
@StateObject private var productRepository = ProductRepository()

// Accessible in any child view
@EnvironmentObject var cart: ShoppingCart
@EnvironmentObject var productRepository: ProductRepository
```

### Observable Objects
Two main observable objects manage app state:

1. **ShoppingCart**
   - Manages cart items
   - Publishes changes to `items` array
   - Provides computed properties for totals

2. **ProductRepository**
   - Manages product catalog
   - Provides search and filter capabilities
   - Could be extended to fetch from API

## View Hierarchy

```
EcommerceAppView
├── TabView
    ├── ProductListView (Shop Tab)
    │   ├── NavigationView
    │   ├── SearchBar
    │   └── ScrollView
    │       └── LazyVGrid
    │           └── ProductCardView (repeated)
    │               ├── Product Image
    │               ├── Product Info
    │               └── Add to Cart Button
    │
    └── CartView (Cart Tab)
        ├── NavigationView
        ├── EmptyCartView (conditional)
        └── CartContentView
            ├── List
            │   └── CartItemRow (repeated)
            │       ├── Product Image
            │       ├── Product Info
            │       ├── Quantity Controls
            │       └── Delete Button
            └── Summary Section
                ├── Subtotal
                └── Checkout Button
                    └── CheckoutView (sheet)
```

## Key Design Patterns

### 1. Composition
Views are composed of smaller, reusable components:
- `ProductCardView` used in grid
- `CartItemRow` used in list
- Separation of concerns

### 2. Single Source of Truth
- `ShoppingCart` is the single source for cart state
- `ProductRepository` is the single source for products
- No duplicate state management

### 3. Declarative UI
SwiftUI's declarative syntax:
```swift
if cart.items.isEmpty {
    emptyCartView
} else {
    cartContentView
}
```

### 4. Reactive Updates
All views automatically update when observed state changes:
```swift
@Published var items: [CartItem] = []
// Any view observing this updates automatically
```

## Data Models

### Product
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

**Protocols:**
- `Identifiable`: For use in ForEach loops
- `Codable`: For JSON serialization (future API integration)
- `Equatable`: For comparison and testing

### CartItem
```swift
struct CartItem: Identifiable, Equatable {
    let id: UUID
    let product: Product
    var quantity: Int
    
    var totalPrice: Decimal {
        product.price * Decimal(quantity)
    }
}
```

## Testing Strategy

### Unit Tests
Three test suites cover core functionality:

1. **ProductTests**
   - Model initialization
   - Equality checks

2. **ShoppingCartTests**
   - Add items
   - Remove items
   - Update quantity
   - Calculate totals
   - Edge cases

3. **ProductRepositoryTests**
   - Get products
   - Search functionality
   - Filter by category

### Test Coverage
- Models: 100%
- ViewModels: ~90%
- Views: Tested manually (SwiftUI previews)

## Scalability Considerations

### Current Architecture Supports:

1. **API Integration**
   - Replace `ProductRepository` sample data with API calls
   - Add async/await for network requests
   - Implement error handling

2. **Persistence**
   - Add UserDefaults for cart persistence
   - Implement Core Data for order history
   - Add iCloud sync

3. **User Authentication**
   - Add Auth service
   - Protect checkout flow
   - Store user preferences

4. **Additional Features**
   - Wishlist (similar to ShoppingCart)
   - Product reviews (extend Product model)
   - Order tracking (new OrderManager)

## Performance Optimizations

1. **LazyVGrid**: Products loaded lazily as user scrolls
2. **Identifiable**: Efficient list updates
3. **Computed Properties**: Price calculations on-demand
4. **Value Types**: Structs for models (no reference cycles)

## Code Organization

```
EcommerceApp/
├── Models/
│   ├── Product.swift           # Data structure
│   └── CartItem.swift          # Data structure
├── ViewModels/
│   ├── ShoppingCart.swift      # Business logic
│   └── ProductRepository.swift # Data management
└── Views/
    ├── EcommerceAppView.swift  # Root container
    ├── ProductListView.swift   # Product browsing
    ├── ProductDetailView.swift # Product details
    ├── CartView.swift          # Cart management
    └── CheckoutView.swift      # Order placement
```

## Future Enhancements

### Phase 2 Features
- Real image loading from URLs
- Network layer for API calls
- User authentication
- Order history
- Push notifications

### Phase 3 Features
- Payment gateway integration
- Inventory management
- Admin panel
- Analytics tracking
- A/B testing framework

## Dependencies

Currently minimal:
- SwiftUI (iOS 15+)
- Foundation
- XCTest (testing)

No third-party dependencies for maximum simplicity and maintainability.
