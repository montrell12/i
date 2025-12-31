import SwiftUI

/// View for the checkout process
public struct CheckoutView: View {
    @EnvironmentObject var cart: ShoppingCart
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var email = ""
    @State private var address = ""
    @State private var city = ""
    @State private var zipCode = ""
    @State private var cardNumber = ""
    @State private var showingConfirmation = false
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Contact Information")) {
                    TextField("Full Name", text: $name)
                        .textContentType(.name)
                    
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                Section(header: Text("Shipping Address")) {
                    TextField("Street Address", text: $address)
                        .textContentType(.streetAddressLine1)
                    
                    TextField("City", text: $city)
                        .textContentType(.addressCity)
                    
                    TextField("ZIP Code", text: $zipCode)
                        .textContentType(.postalCode)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Payment Information")) {
                    TextField("Card Number", text: $cardNumber)
                        .textContentType(.creditCardNumber)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Order Summary")) {
                    ForEach(cart.items) { item in
                        HStack {
                            Text("\(item.quantity)x \(item.product.name)")
                            Spacer()
                            Text("$\(item.totalPrice as NSDecimalNumber, formatter: priceFormatter)")
                        }
                    }
                    
                    HStack {
                        Text("Total")
                            .fontWeight(.bold)
                        Spacer()
                        Text("$\(cart.totalPrice as NSDecimalNumber, formatter: priceFormatter)")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
                
                Section {
                    Button(action: {
                        showingConfirmation = true
                    }) {
                        Text("Place Order")
                            .frame(maxWidth: .infinity)
                            .fontWeight(.semibold)
                    }
                    .disabled(!isFormValid)
                }
            }
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Order Confirmed!", isPresented: $showingConfirmation) {
                Button("OK") {
                    cart.clear()
                    dismiss()
                }
            } message: {
                Text("Thank you for your order! You will receive a confirmation email shortly.")
            }
        }
    }
    
    private var isFormValid: Bool {
        !name.isEmpty && !email.isEmpty && !address.isEmpty && 
        !city.isEmpty && !zipCode.isEmpty && !cardNumber.isEmpty
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
    CheckoutView()
        .environmentObject({
            let cart = ShoppingCart()
            cart.addItem(Product(
                name: "Wireless Headphones",
                description: "High-quality headphones",
                price: 199.99,
                imageURL: "headphones",
                category: "Electronics"
            ))
            return cart
        }())
}
