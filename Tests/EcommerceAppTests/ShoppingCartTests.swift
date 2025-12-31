import XCTest
@testable import EcommerceApp

final class ShoppingCartTests: XCTestCase {
    var cart: ShoppingCart!
    var sampleProduct: Product!
    
    override func setUp() {
        super.setUp()
        cart = ShoppingCart()
        sampleProduct = Product(
            name: "Test Product",
            description: "Test Description",
            price: 100.00,
            imageURL: "test.jpg",
            category: "Test"
        )
    }
    
    override func tearDown() {
        cart = nil
        sampleProduct = nil
        super.tearDown()
    }
    
    func testAddItemToCart() {
        cart.addItem(sampleProduct)
        
        XCTAssertEqual(cart.items.count, 1)
        XCTAssertEqual(cart.items.first?.product.id, sampleProduct.id)
        XCTAssertEqual(cart.items.first?.quantity, 1)
    }
    
    func testAddSameItemIncreasesQuantity() {
        cart.addItem(sampleProduct)
        cart.addItem(sampleProduct)
        
        XCTAssertEqual(cart.items.count, 1)
        XCTAssertEqual(cart.items.first?.quantity, 2)
    }
    
    func testAddItemWithCustomQuantity() {
        cart.addItem(sampleProduct, quantity: 5)
        
        XCTAssertEqual(cart.items.count, 1)
        XCTAssertEqual(cart.items.first?.quantity, 5)
    }
    
    func testRemoveItem() {
        cart.addItem(sampleProduct)
        let item = cart.items.first!
        
        cart.removeItem(item)
        
        XCTAssertTrue(cart.items.isEmpty)
    }
    
    func testUpdateQuantity() {
        cart.addItem(sampleProduct)
        let item = cart.items.first!
        
        cart.updateQuantity(for: item, quantity: 3)
        
        XCTAssertEqual(cart.items.first?.quantity, 3)
    }
    
    func testUpdateQuantityToZeroRemovesItem() {
        cart.addItem(sampleProduct)
        let item = cart.items.first!
        
        cart.updateQuantity(for: item, quantity: 0)
        
        XCTAssertTrue(cart.items.isEmpty)
    }
    
    func testClearCart() {
        cart.addItem(sampleProduct)
        cart.addItem(Product(
            name: "Another Product",
            description: "Description",
            price: 50.00,
            imageURL: "test2.jpg",
            category: "Test"
        ))
        
        cart.clear()
        
        XCTAssertTrue(cart.items.isEmpty)
    }
    
    func testTotalPrice() {
        let product1 = Product(
            name: "Product 1",
            description: "Desc",
            price: 100.00,
            imageURL: "img",
            category: "Cat"
        )
        let product2 = Product(
            name: "Product 2",
            description: "Desc",
            price: 50.00,
            imageURL: "img",
            category: "Cat"
        )
        
        cart.addItem(product1, quantity: 2)  // 200.00
        cart.addItem(product2, quantity: 3)  // 150.00
        
        XCTAssertEqual(cart.totalPrice, 350.00)
    }
    
    func testItemCount() {
        cart.addItem(sampleProduct, quantity: 2)
        cart.addItem(Product(
            name: "Another Product",
            description: "Description",
            price: 50.00,
            imageURL: "test2.jpg",
            category: "Test"
        ), quantity: 3)
        
        XCTAssertEqual(cart.itemCount, 5)
    }
    
    func testAddItemWithZeroQuantityIsIgnored() {
        cart.addItem(sampleProduct, quantity: 0)
        
        XCTAssertTrue(cart.items.isEmpty)
    }
    
    func testAddItemWithNegativeQuantityIsIgnored() {
        cart.addItem(sampleProduct, quantity: -5)
        
        XCTAssertTrue(cart.items.isEmpty)
    }
    
    func testUpdateQuantityWithNegativeRemovesItem() {
        cart.addItem(sampleProduct)
        let item = cart.items.first!
        
        cart.updateQuantity(for: item, quantity: -1)
        
        XCTAssertTrue(cart.items.isEmpty)
    }
}
