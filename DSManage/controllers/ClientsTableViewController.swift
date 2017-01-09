//
//  ClientsTableViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 08/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

class ClientsTableViewController: UITableViewController {

    var clients = [Client(name: "Jose",email: "jose@email.com",phone: "1111-1111",address: "rua 1"),
                   Client(name: "Maria",email: "maria@email.com",phone: "2222-2222",address: "rua 2"),
                   Client(name: "Joao",email: "joao@email.com",phone: "3333-3333",address: "rua 3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add,target: self,action: #selector(add))
        
        self.navigationItem.rightBarButtonItems = [addButtonItem,self.editButtonItem]
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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        let clientDetailViewController = segue.destination as! ClientDetailViewController
        
        var selectedIndexPath = self.tableView.indexPathForSelectedRow
        
        if(selectedIndexPath != nil){
            clientDetailViewController.setClient(client: clients[(selectedIndexPath?.row)!],isEditingClient: true)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}