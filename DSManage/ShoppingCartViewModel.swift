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
        
    }
    
    func getProducts() -> [ProductViewModel] {
        
        for product in ShoppingCartService.sharedInstance.getProducts() {
            productsViewModel.append(ProductViewModel(product: product))
        }
        
        return productsViewModel
    }
     
//    func getClient() -> ClientViewModel{
//        
//        clientViewModel = ClientViewModel(client:ShoppingCartService.sharedInstance.getClient())
//        
//        return clientViewModel!
//    }
    
}
