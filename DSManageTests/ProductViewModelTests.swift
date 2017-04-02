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
    
    // compares if model is equivalent with its view model
    func testValidateProduct() {
        
        let product = Product(context: CoreDataStack.getContext())
        product.name = "name"
        product.price = 18.00
        
    }
    
}
