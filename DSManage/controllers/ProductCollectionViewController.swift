//
//  ProductCollectionViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 14/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ProductCollectionViewCell"


class ProductCollectionViewController: UICollectionViewController,ProductCollectionViewCellDelegate, ShoppingCartViewControllerDelegate {

    var productViewModels:[ProductViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateShoppingCartBarButtonItem()
        
        productViewModels = ProductService().getProducts()
        
    
    }
    
    func updateShoppingCartBarButtonItem(){
        
        let button: UIButton = UIButton(type: .custom)
        
        var image: UIImage = UIImage(named: "ic_shopping_cart")!
        
        if !ShoppingCartService.getProducts().isEmpty {
             image = UIImage(named: "ic_shopping_cart_full")!
        }
        
        button.tintColor = .white
        //set image for button
        button.setImage(image, for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(openCart), for: UIControlEvents.touchUpInside)
        //set frame
        
        button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        
        

    }
    
    func openCart(){
        
        if ShoppingCartService.getProducts().count>0{
            let storyBoard : UIStoryboard = UIStoryboard(name: "ShoppingCart", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "shoppingCart") as! ShoppingCartViewController
            
            nextViewController.clearShoppingCartDelegate = self
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        else{
            self.showOkAlertMessage(withTitle: "The products list is empty", andBody: "Select at least one product!")
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let productDetailViewController = segue.destination as! ProductDetailViewController
        var selectedIndexPath = self.collectionView?.indexPathsForSelectedItems?.first
        productDetailViewController.setProductViewModel(productViewModel: productViewModels[(selectedIndexPath?.row)!])
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productViewModels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        
        
        let productViewModel:ProductViewModel = productViewModels[indexPath.row]
        
        cell.populateView(with: productViewModel)
        cell.delegate = self
        self.setBorderShadow(forView: cell.wrapperView, shadowOpacity: 0.3)
        return cell
    }
    
    private func setBorderShadow(forView view:UIView, shadowOpacity:Float ){
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 1.5
        
    }
    
    func didUpdateQuantity(sender: UIStepper){
        
        let point = sender.convert(CGPoint.zero, to: self.collectionView)
        
        let indexPath = self.collectionView?.indexPathForItem(at: point)!
        
        let productViewModel = productViewModels[(indexPath?.row)!]
        productViewModel.quantityText = String(format: "%.f", sender.value)
        
        productViewModels[(indexPath?.row)!] = productViewModel
        
//        ShoppingCartService.productInteracted(productViewModel)
        
    
        // if you need to update the cell
        
        updateShoppingCartBarButtonItem()
        
    }
    
    func didClearShoppingCart(){
//        for i in 0..<productViewModels.count{
//            products[i].quantity = "0"
//        }
//        self.collectionView?.reloadData()
    }

}
