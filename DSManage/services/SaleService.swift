//
//  SaleService.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 17/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class SaleService {
    
    func getSales()->[Sale]{
        
       let client =  Client(id: "1", name: "R2D2", email: "", phone: "", address: "", photoURL: "user_r2d2")
        
        
        var products = [Product(id:"1", product:"Brush", price:11.10, category:"beaulty", desc:"", photoURL:"product_brush"),
                        Product(id:"2", product:"Lipstick", price:12.30, category:"beaulty", desc:"", photoURL:"product_lip_colour")
                    ]
        
        products[0].quantity = "2"
        products[1].quantity = "3"

        

        return [ Sale(id: "1", date: "23 oct, 2017", rep: Rep(), client: client, products: products)
            ]
    }
}
