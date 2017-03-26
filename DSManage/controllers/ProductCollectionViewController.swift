//
//  ProductCollectionViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 14/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ProductCollectionViewCell"

class ProductCollectionViewController: UICollectionViewController  {
    
    private var productsCollectionViewModel = ProductsCollectionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {

        let productDetailViewController = segue.destination as! ProductDetailViewController
        
        if let selectedIndexPath = self.collectionView?.indexPathsForSelectedItems?.first
        {
            productDetailViewController.setProduct(productsCollectionViewModel.get(index: selectedIndexPath.row))
        } else {
            print ("couldnt get selected item")
        }

    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return productsCollectionViewModel.count()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        
        let productViewModel = productsCollectionViewModel.get(index: indexPath.row)
        cell.populateView(with: productViewModel)
        
        return cell
    }
 

}




//    func didUpdateQuantity(sender: UIStepper){
//        let point = sender.convert(CGPoint.zero, to: self.collectionView)
//        let indexPath = self.collectionView?.indexPathForItem(at: point)!
//
//        let product = products[(indexPath?.row)!]
//        product.quantity = Int16(sender.value)
//
//        products[(indexPath?.row)!] = product
//
//        ShoppingCartService.sharedInstance.productInteracted(product)
//
//        updateShoppingCartBarButtonItem()
//    }
//
//    func didClearShoppingCart(){
//
//       products = products.map { (product) -> Product in
//            product.quantity  = 0
//            return product
//        }
//
//        self.collectionView?.reloadData()
//    }


//    func updateShoppingCartBarButtonItem(){
//
//        let button: UIButton = UIButton(type: .custom)
//
//        var image: UIImage = UIImage(named: "ic_shopping_cart")!
//
//        if !ShoppingCartService.sharedInstance.isShoppingCartEmpty(){
//            image = UIImage(named: "ic_shopping_cart_full")!
//        }
//
//        button.tintColor = .white
//        button.setImage(image, for: UIControlState.normal)
//        button.addTarget(self, action: #selector(openCart), for: UIControlEvents.touchUpInside)
//        button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
//
//        let barButton = UIBarButtonItem(customView: button)
//        //assign button to navigationbar
//        self.navigationItem.rightBarButtonItem = barButton
//    }
//
//    func openCart(){
//
//        if ShoppingCartService.sharedInstance.isShoppingCartEmpty(){
//
//            self.showOkAlertMessage(withTitle: "The products list is empty", andBody: "Select at least one product!")
//        }
//        else{
//
//            let storyBoard : UIStoryboard = UIStoryboard(name: "ShoppingCart", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "shoppingCart") as! ShoppingCartViewController
//
//            nextViewController.clearShoppingCartDelegate = self
//            self.navigationController?.pushViewController(nextViewController, animated: true)
//        }
//    }
//
