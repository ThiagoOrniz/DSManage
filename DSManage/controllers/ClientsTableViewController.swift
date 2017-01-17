//
//  ClientsTableViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 08/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

protocol ClientsTableViewControllerDelegate: class {
    func didSelectClient(_ client:Client)
}

class ClientsTableViewController: UITableViewController {

    private var clients:[Client] = []
    weak var clientsTableViewControllerDelegate:ClientsTableViewControllerDelegate?

    var isSelectableClient:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add,target: self,action: #selector(add))
        
        self.navigationItem.rightBarButtonItems = [addButtonItem,self.editButtonItem]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        clients = ClientService().getClients()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientTableViewCell", for: indexPath) as! ClientTableViewCell

        
        cell.clientNameLabel.text = clients[indexPath.row].name
        cell.emailLabel.text = clients[indexPath.row].email
        cell.avatarImageView.image = UIImage(named: clients[indexPath.row].photoURL)
    
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
            clients.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func add(){
        self.performSegue(withIdentifier: "pushNewClient", sender:self)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let client:Client = clients[indexPath.row]

        if isSelectableClient{
            clientsTableViewControllerDelegate?.didSelectClient(client)
          _ = self.navigationController?.popViewController(animated: true)
        }
        else{
            
            let clientDetailViewController = self.storyboard!.instantiateViewController(withIdentifier: "ClientDetailViewController") as! ClientDetailViewController
            
            clientDetailViewController.setClient(client: client,isEditingClient: true)
            self.navigationController?.pushViewController(clientDetailViewController, animated: true)

        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
