//
//  Product.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 31/12/16.
//  Copyright © 2016 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class Product : NSObject {
    
    var id: String = ""
    var product: String = ""
    var price: Double = 0.0
    var desc: String = ""
    var photoURL: String = ""
    
    override init(){
        super.init()
    }
    
    init(id:String, product:String, price:Double, desc:String, photoURL:String){
        super.init()
        self.id = id
        self.product = product
        self.price = price
        self.desc = desc
        self.photoURL = photoURL
        
    }
    
}


