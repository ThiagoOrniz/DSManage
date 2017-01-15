//
//  ProductCollectionViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 14/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ProductCollectionViewCell"
private let sectionInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
private let itemsPerRow: CGFloat = 2


var products:[Product] = []

class ProductCollectionViewController: UICollectionViewController,ProductCollectionViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false


        // Do any additional setup after loading the view.
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

//        cell.productLabel.text = product.product
//        cell.priceLabel.text = String(format:"%.2f",product.price)
//        setBorderShadow(forView: cell.wrapperView, shadowOpacity: 0.3)
        
        

        return cell
    }
    
    
    private func setBorderShadow(forView view:UIView, shadowOpacity:Float ){
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 1.5
        
    }

}

extension ProductCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 240 )
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func didUpdateQuantity(sender: UIStepper){
        print("inside protocol")
        print(sender)
        
        let point = sender.convert(CGPoint.zero, to: self.collectionView)
        
        let indexPath = self.collectionView?.indexPathForItem(at: point)!
        
        let myData = products[(indexPath?.row)!] // or whatever your datasource
        myData.quantity = String(format: "%.f", sender.value)
        products[(indexPath?.row)!] = myData
        
        // if you need to update the cell
        
    }
}
