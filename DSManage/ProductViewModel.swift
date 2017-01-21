//
//  ProductViewModel.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 19/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class ProductViewModel {
    
    private var product: Product
    
    var id: String {
        return product.id
    }
    
    var productText: String {
        return product.product
    }
    
    var priceText: String {
        return String(format:"%.2f",product.price)
    }
    
    var descText: String {
        return product.desc
    }
    
    var categoryText: String {
        return product.category
    }
    
    var quantityText: String {
        get{
            return product.quantity
        }
        set{
            product.quantity = newValue
        }
    }
    
    var photoText: String {
        return product.photoURL
    }

    
    init(product: Product) {
        self.product = product
    }
    
    
    func productHasBeenInteracted(){
        ShoppingCartService.sharedInstance.productInteracted(product)
    }

    
}
