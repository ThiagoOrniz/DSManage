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
    
    // compares if model is equivalent with its view model
    func testValidateProduct() {
        
        let product = Product(context: CoreDataStack.getContext())
        product.name = "name"
        product.price = 18.4
        product.id = "1"
        
        let pvm = ProductViewModel(product: product)
        
        XCTAssertTrue(pvm.priceText == "18.40")
        
    }
    
}
