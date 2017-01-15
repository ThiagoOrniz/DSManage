//
//  ShoppingCartService.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 15/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class ShoppingCartService{
    
    private static var products:[Product] = []
    
    static func add(product:Product){
        products.append(product)
    }
    
    static func update(product:Product){
       let i =  products.index(of: product)
        products[i!] = product
    }

    static func remove(product:Product){
        
        print(products.contains(product))
        products = arrayRemovingObject(object: product, fromArray:products )
        
        print(products)
    }
    
    static func getProducts()->[Product]{
        return products
    }
    
    static func clearAll(){
        products = []
    }
    
    static func productInteracted(_ product:Product){
        
        if products.contains(product) {
            
            if hasProductQuantity(product) {
                update(product:product)
            }
            else{
                remove(product: product)
            }
        }
        else{
            add(product:product)
        }
    }
    
    private static func arrayRemovingObject<U: Equatable>(object: U, fromArray:[U]) -> [U] {
        return fromArray.filter { return $0 != object }
    }
    
    private static func hasProductQuantity(_ product:Product) ->Bool{
        let qtt:Double = Double(product.quantity)!
        return qtt > 0
    }
}
