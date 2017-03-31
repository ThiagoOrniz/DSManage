//
//  ProductViewModel.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 25/03/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class ProductViewModel {
    
    private var product: Product
    
    var hasSelected: Bool = false
    
    init(product: Product) {
        self.product = product
    }
    
    var productText: String {
        return product.name ?? "Product"
    }

    var priceText: String {
        return String(format:"%.2f",product.price)
    }

    var descText: String {
        return product.desc ?? ""
    }

    var quantityText: String {
        get{
            return "\(product.quantity)"
        }
        set{
            product.quantity = Int16(newValue)!
        }
    }
    
    var imageData: NSData {
        return product.image ?? NSData()
    }
    
    func addToShoppingCart() {
        
        if hasSelected {
            ShoppingCartService.sharedInstance.remove(product: self)
        } else {
            ShoppingCartService.sharedInstance.add(product: self)
        }
        
        hasSelected = !hasSelected
        
    }

    
}
