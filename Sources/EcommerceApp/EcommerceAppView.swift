import SwiftUI

/// Main app view that sets up the navigation structure
public struct EcommerceAppView: View {
    @StateObject private var cart = ShoppingCart()
    @StateObject private var productRepository = ProductRepository()
    
    public init() {}
    
    public var body: some View {
        TabView {
            ProductListView()
                .tabItem {
                    Label("Shop", systemImage: "bag")
                }
            
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .badge(cart.itemCount > 0 ? cart.itemCount : nil)
        }
        .environmentObject(cart)
        .environmentObject(productRepository)
    }
}

#Preview {
    EcommerceAppView()
}
