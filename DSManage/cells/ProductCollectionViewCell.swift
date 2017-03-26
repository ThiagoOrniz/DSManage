//
//  ProductCollectionViewCell.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 14/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var addProductButton: UIButton!

    private var productViewModel: ProductViewModel?
    
    func populateView(with product: ProductViewModel) {
        self.productViewModel = product
        setItems()
        wrapperView.setBorderShadow(shadowOpacity: 0.3)
    }
    
    private func setItems(){
        productLabel.text = productViewModel?.productText
        priceLabel.text = productViewModel?.priceText
        productImageView.image = UIImage(data: productViewModel?.imageData as! Data)
    }
    
    @IBAction func addProductButtonTouched() {
        print("add to shopping cart touched")
    }

}
