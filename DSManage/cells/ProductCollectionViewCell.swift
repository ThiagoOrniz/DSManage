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
    
    var product:Product?
    weak var delegate:ProductCollectionViewCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    func populateView(with product:Product){
        self.product = product
        
        setItems()
    
        wrapperView.setBorderShadow(shadowOpacity: 0.3)
    }
    
    private func setItems(){
        quantityLabel.text = String(format:"%d",product?.quantity ?? 0)
        productLabel.text = product?.name ?? ""
        priceLabel.text = String(format:"%.2f", product?.price ?? 0.00)
        
        //this can go to a protocol
        quantityStepper.value =  Double(product?.quantity ?? 0 )
    }
 
    @IBAction func stepperTouched(_ sender: UIStepper) {
        
        print("touched: \(sender.value)")
        quantityLabel.text = String(format:"%.0f",sender.value)
        product?.quantity =  Int16(sender.value)
        delegate?.didUpdateQuantity(sender: sender)
    
    }

  }
