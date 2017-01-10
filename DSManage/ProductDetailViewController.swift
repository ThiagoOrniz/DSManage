//
//  ProductDetailViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 09/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit
import Social


class ProductDetailViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    private var product = Product();

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()


        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        populateView()
    }
    
    private func setupNavigationController(){
        
        let shareButtomItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action,target: self,action: #selector(shareButtonTouched))
        
        self.navigationItem.setRightBarButton(shareButtomItem, animated: true)
    }

    public func setProduct(product:Product){
        self.product = product
        
    }
    
    private func populateView(){
        self.productNameLabel.text = self.product.product
        self.productPriceLabel.text = String(format:"%.2f",self.product.price)
        self.productDescriptionLabel.text = self.product.desc
    }
    
    func shareButtonTouched(){
        let alert = UIAlertController(title: "Share This Product", message: "Sharing your products can help improve your sales!", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Facebook", style: .default) { action in
            self.shareWithFacebook()
        })
                
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        self.present(alert,animated: true,completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sellButtonTouched(_ sender: UIButton) {
    }
    
    private func shareWithFacebook(){
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText(self.product.description)
            self.present(facebookSheet, animated: true, completion: nil)
        } else {
            self.showOkAlertMessage(withTitle: "Couldn't Post it", andBody: "Please login to a Facebook account to share.")
        }
    }

}
