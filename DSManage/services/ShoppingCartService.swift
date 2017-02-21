//
//  ShoppingCartService.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 15/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class ShoppingCartService{
    
    static let sharedInstance = ShoppingCartService()
    
    private var products:[Product] = []
    private var client:Client?
    
    func updateClient(client:Client){
        self.client = client
    }
    
    func getClient() -> Client? {
        return client
    }
    
    func add(product:Product) {
        products.append(product)
    }
    
    func update(product:Product){
        if let i = products.index(where: { $0.name == product.name }){
            products[i] = product
        }
    }
    
    func remove(product:Product){
        
        print(products.contains(product))
        products = arrayRemovingObject(object: product, fromArray:products )
        
        print(products)
    }
    
    func getProducts()->[Product]{
        return products
    }
    
    func clearAll(){
        products = []
        client = nil
    }
    
    func productInteracted(_ product:Product){
        
        if products.contains(where: { $0.name == product.name }) {
            if product.quantity > 0 {
                update(product:product)
            } else{
                remove(product: product)
            }
        } else {
            add(product:product)
        }
    }
    
    func isShoppingCartEmpty() -> Bool{
        return products.isEmpty
    }
    
    private  func arrayRemovingObject<U: Equatable>(object: U, fromArray:[U]) -> [U] {
        return fromArray.filter { return $0 != object }
    }
    
    private  func hasProductQuantity(_ product:ProductModel) ->Bool{
        let qtt:Double = Double(product.quantity)!
        return qtt > 0
    }
}
