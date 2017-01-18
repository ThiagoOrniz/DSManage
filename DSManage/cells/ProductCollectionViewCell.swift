//
//  ProductCollectionViewCell.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 14/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

protocol ProductCollectionViewCellDelegate: class {
    func didUpdateQuantity(sender: UIStepper)
}

class ProductCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    var product:Product = Product()
    weak var delegate:ProductCollectionViewCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    func populateView(withProduct product:Product){
        self.product = product
        quantityLabel.text = product.quantity
        productLabel.text = product.product
        priceLabel.text = String(format:"%.2f",product.price)
        quantityStepper.value = Double(product.quantity)!
        productImageView.image = UIImage(named: product.photoURL)

        
    }
 
    @IBAction func stepperTouched(_ sender: UIStepper) {
        
        print("touched: \(sender.value)")
        quantityLabel.text = String(format:"%.0f",sender.value)
        
        product.quantity = String(format:"%.0f",sender.value)
        
        delegate?.didUpdateQuantity(sender: sender)
        
    
    }
    
  }
