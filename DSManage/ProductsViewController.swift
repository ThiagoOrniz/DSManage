//
//  ProductsViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 09/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var productsTableView: UITableView!
    
    var products:[Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        products = ProductService().getProducts()

        let selectedIndexPath = self.productsTableView.indexPathForSelectedRow
        if(selectedIndexPath != nil){
            self.productsTableView.deselectRow(at: selectedIndexPath!, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as! ProductTableViewCell
        
        cell.productNameLabel.text = products[indexPath.row].product
        cell.productPriceLabel.text = String(format:"%.2f",products[indexPath.row].price)
        cell.productCategoryLabel.text = products[indexPath.row].category
        
        
        return cell
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        let productDetailViewController = segue.destination as! ProductDetailViewController
        var selectedIndexPath = self.productsTableView.indexPathForSelectedRow
        productDetailViewController.setProduct(product: products[(selectedIndexPath?.row)!])
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
