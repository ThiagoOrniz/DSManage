//
//  SaleDetailViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 17/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

class SaleDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var clientLabel: UILabel!
    @IBOutlet weak var clientImageView: UIImageView!
    
    var products:[Product] = []
    var sale:Sale = Sale()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productsTableView.register(UINib(nibName: "ProductSaleTableViewCell", bundle: nil), forCellReuseIdentifier: "ShoppingCartTableViewCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        populateView()
    }
    
    
    private func populateView(){
        self.clientLabel.text = self.sale.client.name
        self.clientImageView.image = UIImage(named: self.sale.client.photoURL)
        self.products = self.sale.products
        self.totalLabel.text = String(format:"%.2f",sale.getTotal())
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartTableViewCell", for: indexPath) as! ShoppingCartTableViewCell
        
        
        let product:Product = products[indexPath.row]
        
        cell.productLabel.text = product.product
        cell.priceLabel.text = String(format:"%.2f",product.price)
        cell.quantityLabel.text = product.quantity + " item(s)"
        cell.subtotalLabel.text = product.getSubTotal()
        cell.productImageView.image = UIImage(named: product.photoURL)
        
        return cell
    }

    public func setSale(sale:Sale){
        self.sale = sale
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
