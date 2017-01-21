//
//  ProductViewModelTests.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 21/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import XCTest
@testable import DSManage

class ProductViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidateProduct() {
        let product = Product(id: "01", product: "name", price: 13.3, category: "cat", desc: "desc", photoURL: "photo")
        
        var productVIewModel = ProductViewModel(product: product)
        
        XCTAssert(productVIewModel.productText == product.product)

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
