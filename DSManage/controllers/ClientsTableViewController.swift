//
//  ClientsTableViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 08/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ClientTableViewCell"


protocol ClientsTableViewControllerDelegate: class {
    func didSelectClient(_ client:ClientViewModel)
}

class ClientsTableViewController: UITableViewController {

    private var clientsViewModel:[ClientViewModel] = []
    
    weak var clientsTableViewControllerDelegate:ClientsTableViewControllerDelegate?

    var isSelectableClient:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add,target: self,action: #selector(add))
        
        self.navigationItem.rightBarButtonItems = [addButtonItem,self.editButtonItem]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        clientsViewModel =  ClientViewModel.getClients()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientsViewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ClientTableViewCell

        cell.populateView(with: clientsViewModel[indexPath.row])
        
        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            clientsViewModel.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func add(){
        self.performSegue(withIdentifier: "pushNewClient", sender:self)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let clientViewModel = clientsViewModel[indexPath.row]

        if isSelectableClient{
            clientViewModel.updateShoppingCart()
            clientsTableViewControllerDelegate?.didSelectClient(clientViewModel)
          _ = self.navigationController?.popViewController(animated: true)
        }
        else{
            
            let clientDetailViewController = self.storyboard!.instantiateViewController(withIdentifier: "ClientDetailViewController") as! ClientDetailViewController
            
            clientDetailViewController.setClient(client: clientViewModel,isEditingClient: true)
            self.navigationController?.pushViewController(clientDetailViewController, animated: true)

        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
