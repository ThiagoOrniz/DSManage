//
//  ShoppingCartViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 15/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

protocol ShoppingCartViewControllerDelegate: class {
    func didClearShoppingCart()
}


class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,ClientsTableViewControllerDelegate {

    
    @IBOutlet weak var clientImageView: UIImageView!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var productsTableView: UITableView!
    
    @IBOutlet weak var clientView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    weak var clearShoppingCartDelegate:ShoppingCartViewControllerDelegate?

    
    var products:[Product] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        productsTableView.register(UINib(nibName: "ProductSaleTableViewCell", bundle: nil), forCellReuseIdentifier: "ShoppingCartTableViewCell")

        
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.trash,target: self,action: #selector(clear))
        
        self.navigationItem.rightBarButtonItems = [addButtonItem]
        
        self.clientImageView.layer.cornerRadius = self.clientImageView.frame.size.width / 2;
        self.clientImageView.clipsToBounds = true;
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.chooseClientTapped))
        self.clientView.addGestureRecognizer(tapRecognizer)

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        products = ShoppingCartService.getProducts()
        
        let client = ShoppingCartService.getClient()
        
        if client.id.characters.count > 0 {
            clientNameLabel.text = client.name
            clientImageView.image = UIImage(named: client.photoURL)
        }
        
        
        calculateTotal()
        
    }
    
    func chooseClientTapped(){
    
        let storyBoard : UIStoryboard = UIStoryboard(name: "Client", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ClientsTableViewController") as! ClientsTableViewController
        
        nextViewController.clientsTableViewControllerDelegate = self
        nextViewController.isSelectableClient = true
        self.navigationController?.pushViewController(nextViewController, animated: true)

    }
    
    func calculateTotal(){
        
        var total:Double = 0.0
        
        for i in 0..<products.count{
            total += products[i].price * Double(products[i].quantity)!
        }
        
        totalLabel.text = String(format: "%.2f", total)
        
    }
    
    func clear(){
        
        self.alertClearShoppingCart()
        

    }
    
    func alertClearShoppingCart() {
        
        let alert = UIAlertController(title: "Would you like to clear the shopping cart?", message: "This action can't be undone", preferredStyle: UIAlertControllerStyle.alert)
       
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Clear it", style: .default) { action in
            ShoppingCartService.clearAll()
            self.clearShoppingCartDelegate?.didClearShoppingCart()
            
            _ = self.navigationController?.popViewController(animated: true)
        })
        
        self.present(alert, animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    
    // Override to support conditional editing of the table view.
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            products.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if products.count == 0 {
                clear()
                return
                
            }

            calculateTotal()

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    @IBAction func confirmButtonTouched(_ sender: UIButton) {
        
        if ShoppingCartService.getClient().id.characters.count == 0 {
            self.showOkAlertMessage(withTitle: "There's no client selected!", andBody: "Select a client!")
            
            return
        }
        
        if products.count == 0{
            self.showOkAlertMessage(withTitle: "There's no products in the cart list!", andBody: "Select at least one product!")
            
            return
        }
    
        self.showOkAlertMessage(withTitle: "Done", andBody: "")

    }
    
    func didSelectClient(_ client:Client){
        
        clientNameLabel.text = client.name
        ShoppingCartService.updateClient(client: client)
    }
}
