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

    var shoppingCarViewModel = ShoppingCartViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        self.clientImageView.layer.cornerRadius = self.clientImageView.frame.size.width / 2
        self.clientImageView.clipsToBounds = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.chooseClientTapped))
        self.clientView.addGestureRecognizer(tapRecognizer)

    }
    
    
    func chooseClientTapped(){
    
        let storyBoard : UIStoryboard = UIStoryboard(name: "Client", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ClientsTableViewController") as! ClientsTableViewController
        
        nextViewController.clientsTableViewControllerDelegate = self
        nextViewController.isSelectableClient = true
        self.navigationController?.pushViewController(nextViewController, animated: true)

    }
    

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingCarViewModel.getCount()
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartProductTableViewCell", for: indexPath) as! ShoppingCartProductTableViewCell
        
        cell.populateView(shoppingCarViewModel.getProduct(for: indexPath.row))
        return cell
    }
    
    
    @IBAction func confirmButtonTouched(_ sender: UIButton) {
        
        // Save sell
        
    }
    
    func didSelectClient(_ client:Client){
        clientNameLabel.text = client.name
        
    }
}
