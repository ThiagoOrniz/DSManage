//
//  ItemSaleViewModelTests.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 02/04/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import XCTest
@testable import DSManage

class ItemSaleViewModelTests: XCTestCase {
    
    var item: ItemSale?
    var product: Product?
    var isvm: ItemSaleViewModel?

    
    override func setUp() {
        super.setUp()
        
        product = Product(context: CoreDataStack.getContext())
        item = ItemSale(context: CoreDataStack.getContext())
        item?.product = product
        
        isvm = ItemSaleViewModel(item: item!)


    }
    
    func testSubTotal() {
        
        item?.quantity = 3
        product?.price = 9.00
        
        XCTAssertTrue(isvm!.subTotal == "27.00")
    
    }
    
    func testQuantity() {
        
        isvm?.quantity = "0" //setup to 0
        isvm?.quantity = "2"
        
        XCTAssertTrue(isvm!.quantity == "\(item?.quantity)")
        
    }
    
}
