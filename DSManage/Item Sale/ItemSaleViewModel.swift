//
//  ItemSaleViewModel.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 02/04/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class ItemSaleViewModel {
    
    private var itemSale: ItemSale?
    
    init(item: ItemSale) {
        itemSale = item
    }
    
    var subTotal: String {
        
        let qtt = itemSale?.quantity ?? 0
        let price = itemSale?.product?.price ?? 0
        
        return String(format: "%.2f", Double(qtt) * price)
    }
    
    var quantity: String {
        get {
           return "\(itemSale?.quantity)"
        }
        set {
            
            if let qtt = Int16(newValue) {
                itemSale?.quantity = qtt
            } else {
                itemSale?.quantity = 1
            }
        }
    }
    
}
