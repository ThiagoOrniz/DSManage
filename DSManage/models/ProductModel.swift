//
//  Product.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 31/12/16.
//  Copyright © 2016 Thiago Orniz Martin. All rights reserved.
//

import Foundation

struct ProductModel : Equatable{
    
    var id: String = ""
    var product: String = ""
    var price: Double = 0.0
    var desc: String = ""
    var photoURL: String = ""
    var category: String = ""
    var quantity: String = ""

    init(){
    }
    
    init(id:String, product:String, price:Double, category:String, desc:String, photoURL:String){
        
        self.id = id
        self.product = product
        self.price = price
        self.desc = desc
        self.photoURL = photoURL
        self.category = category
        self.quantity = "0"
        
    }
    
    var description: String {
        return "Product \(product)\nPrice \(price)\ndescription \(desc)"
    }
    
    static func == (lhs: ProductModel, rhs: ProductModel) -> Bool {
        return
            lhs.id == rhs.id &&
                lhs.product == rhs.product &&
                lhs.category == rhs.category &&
                lhs.price == rhs.price
    }
    
    
}


