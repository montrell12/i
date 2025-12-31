# App Features and Screenshots

## Overview

EcommerceApp is a fully functional iOS ecommerce application built with SwiftUI. This document describes the features and user interface of the app.

## Main Features

### 1. Tab-Based Navigation

The app uses a tab bar interface with two main sections:
- **Shop**: Browse and search products
- **Cart**: View and manage shopping cart

The Cart tab displays a badge showing the number of items in the cart.

### 2. Product Catalog

**Features:**
- Grid layout displaying products in a 2-column adaptive layout
- Each product card shows:
  - Product image placeholder
  - Product name
  - Price
  - Stock status
  - Quick "Add to Cart" button
- Search bar at the top to filter products by name or description
- Smooth scrolling with LazyVGrid for performance

**Sample Products:**
The app includes 8 sample products:
1. Wireless Headphones - $199.99
2. Smart Watch - $299.99
3. Laptop Backpack - $59.99
4. Portable Charger - $39.99
5. Bluetooth Speaker - $79.99
6. Phone Case - $24.99
7. USB-C Cable - $14.99
8. Wireless Mouse - $34.99

### 3. Product Details Page

When tapping on a product, users see:
- Large product image
- Product name and category badge
- Current price
- Stock availability indicator
- Detailed product description
- Quantity selector with +/- buttons
- Calculated total price for selected quantity
- "Add to Cart" button

**Key Interactions:**
- Adjust quantity before adding to cart
- See total price update in real-time
- Receive confirmation alert when item is added
- Cannot add out-of-stock items

### 4. Shopping Cart

**Empty State:**
- Icon and message when cart is empty
- Helpful text to guide users

**With Items:**
- List of all cart items with:
  - Product image thumbnail
  - Product name and individual price
  - Quantity controls (+/- buttons)
  - Item total price
  - Delete button
- Swipe-to-delete functionality
- Cart summary showing:
  - Total number of items
  - Subtotal amount
- "Clear" button in navigation bar to empty cart
- "Proceed to Checkout" button

**Cart Management:**
- Increase/decrease quantity directly in cart
- Remove individual items
- Real-time price updates
- Minimum quantity of 1 (decreasing below removes item)

### 5. Checkout Process

**Form Fields:**
- Contact Information:
  - Full Name
  - Email Address
- Shipping Address:
  - Street Address
  - City
  - ZIP Code
- Payment Information:
  - Card Number

**Features:**
- Form validation (all fields required)
- Order summary showing:
  - Each item with quantity and price
  - Total order amount
- "Cancel" button to return to cart
- "Place Order" button (disabled until form is valid)
- Order confirmation alert
- Cart automatically clears on successful order

### 6. Search Functionality

- Real-time search as you type
- Case-insensitive matching
- Searches both product names and descriptions
- Shows filtered results instantly
- Clear search to see all products

## Technical Features

### State Management
- Uses SwiftUI's `@StateObject` and `@EnvironmentObject` for reactive state
- Shopping cart persists across views
- Product catalog managed centrally

### Data Models
- **Product**: Identifiable, Codable, Equatable
- **CartItem**: Tracks product and quantity
- **ShoppingCart**: ObservableObject managing cart state
- **ProductRepository**: ObservableObject managing products

### UI Components
- Native SwiftUI views and modifiers
- System images (SF Symbols)
- Responsive layout adapting to different screen sizes
- Smooth animations and transitions
- Native iOS design patterns

### Price Formatting
- Consistent decimal formatting with 2 decimal places
- Uses NumberFormatter for proper currency display
- Decimal type for precise calculations

## User Flow

1. **Browse Products**
   - Open app to see product grid
   - Optionally search for specific products
   - Tap product card to see details

2. **Add to Cart**
   - From product list: tap "Add to Cart" (adds 1 item)
   - From product details: adjust quantity, then add to cart
   - Receive confirmation alert

3. **Review Cart**
   - Switch to Cart tab
   - See badge indicating item count
   - Review all items and adjust quantities
   - Remove unwanted items

4. **Checkout**
   - Tap "Proceed to Checkout"
   - Fill in all required information
   - Review order summary
   - Place order
   - See confirmation message

5. **Continue Shopping**
   - Cart clears after order
   - Return to Shop tab to browse more products

## Design Principles

- **Native iOS Feel**: Uses system fonts, colors, and components
- **Clarity**: Clear visual hierarchy and readable text
- **Efficiency**: Quick access to common actions
- **Feedback**: Alerts and visual cues for user actions
- **Consistency**: Uniform styling throughout the app
- **Accessibility**: Uses standard iOS components for better accessibility

## Testing

The app includes comprehensive unit tests for:
- Product model creation and equality
- Shopping cart operations (add, remove, update, clear)
- Cart calculations (total price, item count)
- Product repository (search, filter, fetch)

## Future Enhancement Ideas

- User authentication and profiles
- Order history
- Product reviews and ratings
- Wishlist functionality
- Multiple payment methods
- Shipping options
- Product categories filter
- Real product images
- Discount codes and promotions
- Push notifications
- Dark mode customization
- iPad optimization
