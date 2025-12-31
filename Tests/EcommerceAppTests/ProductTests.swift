import XCTest
@testable import EcommerceApp

final class ProductTests: XCTestCase {
    
    func testProductInitialization() {
        let product = Product(
            name: "Test Product",
            description: "Test Description",
            price: 99.99,
            imageURL: "test.jpg",
            category: "Test"
        )
        
        XCTAssertEqual(product.name, "Test Product")
        XCTAssertEqual(product.description, "Test Description")
        XCTAssertEqual(product.price, 99.99)
        XCTAssertEqual(product.imageURL, "test.jpg")
        XCTAssertEqual(product.category, "Test")
        XCTAssertTrue(product.inStock)
    }
    
    func testProductEquality() {
        let id = UUID()
        let product1 = Product(
            id: id,
            name: "Test",
            description: "Desc",
            price: 10,
            imageURL: "img",
            category: "Cat"
        )
        let product2 = Product(
            id: id,
            name: "Test",
            description: "Desc",
            price: 10,
            imageURL: "img",
            category: "Cat"
        )
        
        XCTAssertEqual(product1, product2)
    }
}
