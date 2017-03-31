//
//  ShoppingCartTableViewCell.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 15/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

class ShoppingCartTableViewCell: UITableViewCell, FetchImageDelegate {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    
    var productViewModel:ProductViewModel?

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateView(with productViewModel:ProductViewModel){
        self.productViewModel = productViewModel
//        productViewModel.fetchImageDelegate = self
        
        
        setItems()
        
    }
    
    private func setItems(){
        
//        productLabel.text = productViewModel?.productText
//        priceLabel.text = productViewModel?.priceText
//        
//        quantityLabel.text = (productViewModel?.quantityText)! + " item(s)"
//        subtotalLabel.text = productViewModel?.getSubTotal()
//        
//        productViewModel?.syncImage()
        
    }
    
    func fetchImage(data: NSData) {
        productImageView.image = UIImage(data: data as Data)
    }


}
