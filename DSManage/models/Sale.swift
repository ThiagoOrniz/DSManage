//
//  Sale.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 31/12/16.
//  Copyright © 2016 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class Sale {
    
     var id: String = ""
     var date: String = ""
     var rep: Rep = Rep()
     var client: Client = Client()
     var products: [Product] = []
    
    init(){
        
    }
    
    init(id:String, date:String, rep:Rep, client:Client, products:[Product]){
        
        self.id = id
        self.date = date
        self.rep = rep
        self.client = client
        self.products = products
    }
    
    func getTotal() -> Double{
        
        print(self.products.reduce(0) { $0 + ($1.price * Double($1.quantity)!)})
        return self.products.reduce(0) { $0 + ($1.price * Double($1.quantity)!)}
    }
    
    
}
