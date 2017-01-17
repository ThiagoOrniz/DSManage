//
//  ProductCollectionViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 14/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ProductCollectionViewCell"


var products:[Product] = []

class ProductCollectionViewController: UICollectionViewController,ProductCollectionViewCellDelegate, ShoppingCartViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let addButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done,target: self,action: #selector(openCart))

        self.navigationItem.rightBarButtonItems = [addButtonItem]
        
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        products = ProductService().getProducts()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let productDetailViewController = segue.destination as! ProductDetailViewController
        var selectedIndexPath = self.collectionView?.indexPathsForSelectedItems?.first
        productDetailViewController.setProduct(product: products[(selectedIndexPath?.row)!])
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        
        
        let product:Product = products[indexPath.row]
        
        cell.populateView(withProduct: product)
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
        print(sender)
        
        let point = sender.convert(CGPoint.zero, to: self.collectionView)
        
        let indexPath = self.collectionView?.indexPathForItem(at: point)!
        
        let product = products[(indexPath?.row)!] // or whatever your datasource
        product.quantity = String(format: "%.f", sender.value)
        products[(indexPath?.row)!] = product
        
        ShoppingCartService.productInteracted(product)
        
        // if you need to update the cell
        
    }
    
    func didClearShoppingCart(){
        for i in 0..<products.count{
            products[i].quantity = "0"
        }
        self.collectionView?.reloadData()
    }

}
