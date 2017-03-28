//
//  ShoppingCartProductTableViewCell.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 26/03/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

class ShoppingCartProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var quantityLabel: UILabel!

    private var productViewModel: ProductViewModel?
    
    
    func populateView(_ product:ProductViewModel) {
        productViewModel = product
        
        productNameLabel.text = productViewModel?.productText
        productPriceLabel.text = productViewModel?.priceText
        productImageView.image = UIImage(data: productViewModel?.imageData as! Data)
        quantityLabel.text = productViewModel?.quantityText
        quantityStepper.value = Double(productViewModel!.quantityText)!

    }
    
    @IBAction func stepperTouched(_ sender: UIStepper) {
        quantityLabel.text = "\(sender.value)"
        productViewModel?.quantityText = "\(sender.value)"
        
    }
}
