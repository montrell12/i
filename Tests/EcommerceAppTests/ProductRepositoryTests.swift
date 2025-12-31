import XCTest
@testable import EcommerceApp

final class ProductRepositoryTests: XCTestCase {
    var repository: ProductRepository!
    
    override func setUp() {
        super.setUp()
        repository = ProductRepository()
    }
    
    override func tearDown() {
        repository = nil
        super.tearDown()
    }
    
    func testRepositoryLoadsProducts() {
        XCTAssertFalse(repository.products.isEmpty)
    }
    
    func testGetProductById() {
        let product = repository.products.first!
        let foundProduct = repository.getProduct(by: product.id)
        
        XCTAssertNotNil(foundProduct)
        XCTAssertEqual(foundProduct?.id, product.id)
    }
    
    func testGetProductByIdReturnsNilForInvalidId() {
        let foundProduct = repository.getProduct(by: UUID())
        
        XCTAssertNil(foundProduct)
    }
    
    func testFilterByCategory() {
        let electronics = repository.filterByCategory("Electronics")
        
        XCTAssertFalse(electronics.isEmpty)
        XCTAssertTrue(electronics.allSatisfy { $0.category == "Electronics" })
    }
    
    func testSearchByName() {
        let results = repository.search("headphones")
        
        XCTAssertFalse(results.isEmpty)
        XCTAssertTrue(results.contains { $0.name.lowercased().contains("headphones") })
    }
    
    func testSearchByDescription() {
        let results = repository.search("wireless")
        
        XCTAssertFalse(results.isEmpty)
    }
    
    func testSearchIsCaseInsensitive() {
        let resultsLower = repository.search("headphones")
        let resultsUpper = repository.search("HEADPHONES")
        
        XCTAssertEqual(resultsLower.count, resultsUpper.count)
    }
    
    func testSearchReturnsEmptyForNoMatch() {
        let results = repository.search("nonexistentproduct12345")
        
        XCTAssertTrue(results.isEmpty)
    }
}
