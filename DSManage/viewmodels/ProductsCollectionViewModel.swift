//
//  ProductViewModel.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 19/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation

protocol FetchImageDelegate {
    func fetchImage(data: NSData)
}

class ProductsCollectionViewModel {
    
    private var products = [Product]()
    
    var fetchImageDelegate:FetchImageDelegate?
    
    init() {
        products = ProductService().getProducts()
    }
    
    func count() -> Int {
        return products.count
    }
    
    func get(index: Int) -> ProductViewModel {
        return ProductViewModel(product: products[index])
    }
    
    func search(for content: String){
        
        if content == "" {
            products = ProductService().getProducts()
        } else {
            products =  products.filter {
                ($0.name?.contains(content))!
            }
        }
        
    }

    
}
