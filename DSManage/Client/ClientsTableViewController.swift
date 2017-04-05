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
    func didSelectClient(_ client:Client)
}

protocol ObjectHasUpdated {
    func hasUpdated()
}

class ClientsTableViewController: UITableViewController, ObjectHasUpdated {
    
    private var clientTableViewModel = ClientTableViewModel()
    
    weak var clientsTableViewControllerDelegate:ClientsTableViewControllerDelegate?
    var isSelectableClient:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButtonItem = UIBarButtonItem( barButtonSystemItem: UIBarButtonSystemItem.add,
                                             target: self,
                                             action: #selector(addNewClient)
                                           )
        
        self.navigationItem.rightBarButtonItems = [addButtonItem,self.editButtonItem]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        clientTableViewModel.objectHasUpdatedDelegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
   
    func addNewClient(){
        self.performSegue(withIdentifier: "pushNewClient", sender:self)
    }
    
    
    // MARK: TableView Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientTableViewModel.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ClientTableViewCell

        cell.populateView(with: clientTableViewModel.get(at: indexPath.row))
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            clientTableViewModel.removeObject(at: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func hasUpdated() {
        tableView.reloadData()
    }
}
