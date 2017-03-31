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
    
    private var products = [ProductViewModel]()
    private var client: ClientViewModel?
    
    func updateClient(client:ClientViewModel){
        self.client = client
    }
    
    func getClient() -> ClientViewModel? {
        return client
    }
    
    func add(product:ProductViewModel) {
        if products.index(where: { $0.productText == product.productText }) != nil{
            return
        }
        products.append(product)
    }
    
    func update(product:ProductViewModel){
        if let i = products.index(where: { $0.productText == product.productText }){
            products[i] = product
        }
    }
    
    func remove(product: ProductViewModel){
        
        if let i = products.index(where: { $0.productText == product.productText }){
            products.remove(at: i)
        }
    }
    
    func getProducts() -> [ProductViewModel] {
        return products
    }
    
    func clearAll(){
        products = []
        client = nil
    }
    
    func productInteracted(_ product:ProductViewModel){
        
        if let i = products.index(where: { $0.productText == product.productText }){
            products.remove(at: i)
        } else {
            products.append(product)
        }
    }
    
    func isShoppingCartEmpty() -> Bool{
        return products.isEmpty
    }
    
}
