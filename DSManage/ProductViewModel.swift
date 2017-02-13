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

class ProductViewModel {
    
    private var product: ProductModel
    var fetchImageDelegate:FetchImageDelegate?
    
    var productText: String {
        return "\(product.product)"
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
    
    var photoURL: URL? {
        return URL(string:product.photoURL)
    }

    
    init(product: ProductModel) {
        self.product = product
    }
    
    
    func productHasBeenInteracted(){
        ShoppingCartService.sharedInstance.productInteracted(product)
    }
    
    func syncImage(){
        
        if let url = photoURL{
            DispatchQueue.global(qos: .userInitiated).async {
                let contentOfURL = NSData(contentsOf: url)
                DispatchQueue.main.async { [weak weakSelf = self] in
                    
                    if let imageData = contentOfURL {
                        weakSelf?.fetchImageDelegate?.fetchImage(data: imageData)
                    }
                }
            }
            
        }

    }
    
    func getSubTotal() -> String{
        
        return String(format:"%.2f",product.price * Double(product.quantity)!)
    }


    
}
