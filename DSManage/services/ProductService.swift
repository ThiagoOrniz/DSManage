//
//  ProductService.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 08/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class ProductService {
    
    func getProducts()->[Product]{
        
        return [Product(id:"1",product: "A",price: 10.0,desc: "aa",photoURL: ""),
                Product(id:"2",product: "B",price: 12.50,desc: "bb",photoURL: ""),
                Product(id:"3",product: "C",price: 13.40,desc: "cc",photoURL: ""),
                Product(id:"4",product: "D",price: 22.10,desc: "dd",photoURL: "")
              ]
    }
    
}
