//
//  ShoppingCartViewModel.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 21/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class ShoppingCartViewModel{
    
    private var productsViewModel = [ProductViewModel]()
    private var clientViewModel:ClientViewModel?

    init() {
        
//        clientViewModel = ClientViewModel(ShoppingCartService.sharedInstance.getClient())
        productsViewModel = ShoppingCartService.sharedInstance.getProductsViewModel()
    }
    
    var clientName: String {
        return clientViewModel?.nameText ?? "Select a client"
    }
    
    
    func getCount() -> Int {
        return productsViewModel.count
    }
    

    func getProduct(for row: Int) -> ProductViewModel {
        return productsViewModel[row]
    }
    
    func getProducts() -> [Product] {
        
//        for product in ShoppingCartService.sharedInstance.getProducts() {
//            productsViewModel.append(Product(product: product))
//        }
        
        return ShoppingCartService.sharedInstance.getProducts()
    }
     
//    func getClient() -> ClientViewModel{
//        
//        clientViewModel = ClientViewModel(client:ShoppingCartService.sharedInstance.getClient())
//        
//        return clientViewModel!
//    }
    
}
