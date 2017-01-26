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

class ProductCollectionViewCell: UICollectionViewCell, FetchImageDelegate {
 
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    var productViewModel:ProductViewModel?
    weak var delegate:ProductCollectionViewCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    func populateView(with productViewModel:ProductViewModel){
        self.productViewModel = productViewModel
        
        quantityLabel.text = productViewModel.quantityText
        productLabel.text = productViewModel.productText
        priceLabel.text = productViewModel.priceText
        quantityStepper.value =  Double(productViewModel.quantityText)!
//        productImageView.image = UIImage(named: productViewModel.photoText)
        productViewModel.fetchImageDelegate = self
       
        productViewModel.syncImage()

        
        wrapperView.setBorderShadow(shadowOpacity: 0.3)
    }
 
    @IBAction func stepperTouched(_ sender: UIStepper) {
        
        print("touched: \(sender.value)")
        quantityLabel.text = String(format:"%.0f",sender.value)
        productViewModel?.quantityText = String(format:"%.0f",sender.value)
        delegate?.didUpdateQuantity(sender: sender)
        
    
    }
    
    func fetchImage(data: NSData) {
        productImageView.image = UIImage(data: data as Data)
    }
    
  }
