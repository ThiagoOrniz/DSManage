//
//  ClientsTableViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 08/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "ClientTableViewCell"


protocol ClientsTableViewControllerDelegate: class {
    func didSelectClient(_ client:Client)
}

class ClientsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating
{
    
    var filteredData:[Client] = []
    var resultSearchController:UISearchController!
    
    weak var clientsTableViewControllerDelegate:ClientsTableViewControllerDelegate?
    var isSelectableClient:Bool = false
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButtonItem = UIBarButtonItem( barButtonSystemItem: UIBarButtonSystemItem.add,
                                             target: self,
                                             action: #selector(addNewClient)
                                           )
        
        self.navigationItem.rightBarButtonItems = [addButtonItem,self.editButtonItem]
        
        
        resultSearchController = UISearchController(searchResultsController: nil)
        resultSearchController.searchResultsUpdater = self
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.prominent
        resultSearchController.searchBar.sizeToFit()

        self.tableView.tableHeaderView = resultSearchController.searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupFetchedResultsController()
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("______Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        fetchedResultsController.delegate = nil
    }
    
    private func setupFetchedResultsController() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Client")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                              managedObjectContext: CoreDataStack.getContext(),
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil
                                                             )
        
        fetchedResultsController.delegate = self
    }

    func addNewClient(){
        self.performSegue(withIdentifier: "pushNewClient", sender:self)
    }
    
    
    // MARK: TableView Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if resultSearchController.isActive {
            return filteredData.count
        }
        else {
        
        if let count = fetchedResultsController?.sections?[section].numberOfObjects {
            return count
        }
        return 0
    }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ClientTableViewCell

        configureCell(cell: cell, indexPath: indexPath)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let client = fetchedResultsController.object(at: indexPath) as? Client else {
                fatalError("Unexpected Object in FetchedResultsController")
            }
            CoreDataStack.getContext().delete(client)
            CoreDataStack.saveContext()
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let client = fetchedResultsController.object(at: indexPath) as? Client else {
            fatalError("Unexpected Object in FetchedResultsController")
        }
        
        if isSelectableClient{
            ShoppingCartService.sharedInstance.updateClient(client: client)
            
            clientsTableViewControllerDelegate?.didSelectClient(client)
          _ = self.navigationController?.popViewController(animated: true)
        }
        else{
            
            let clientDetailViewController = self.storyboard!.instantiateViewController(withIdentifier: "ClientDetailViewController") as! ClientDetailViewController
            
            clientDetailViewController.setClient(client: client,isEditingClient: true)
            self.navigationController?.pushViewController(clientDetailViewController, animated: true)

        }

    }
    
    func configureCell(cell: ClientTableViewCell, indexPath: IndexPath) {
        
        if resultSearchController.isActive {
            let c = filteredData[indexPath.row]
            cell.clientNameLabel.text = c.name
            cell.emailLabel.text = c.email
            
            if let photo = c.avatar {
                cell.avatarImageView.image = UIImage(data: (photo as NSData) as Data)
            }
            
        }
        else {
        guard let client = fetchedResultsController.object(at: indexPath) as? Client else {
            fatalError("Unexpected Object in FetchedResultsController")
        }
        
        cell.clientNameLabel.text = client.name
        cell.emailLabel.text = client.email
        
        if let photo = client.avatar {
            cell.avatarImageView.image = UIImage(data: (photo as NSData) as Data)
        }
        }
    }
    
  
    
    // MARK: NSFetchedResultsControllerDelegate Methods
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        case .update:
            if let indexPath = newIndexPath {
                configureCell(cell: tableView.cellForRow(at: indexPath)! as! ClientTableViewCell, indexPath: indexPath)
            }
        default:
            print("default")
        
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        let searchPredicate = NSPredicate(format: "name contains[c] %@", searchText)
        
        filteredData = (self.fetchedResultsController.fetchedObjects?.filter() {
            return searchPredicate.evaluate(with: $0)
        } as! [Client]?)!
        
        self.tableView.reloadData()
        print(searchPredicate)
    }

    public func updateSearchResults(for searchController: UISearchController) {

        if (searchController.searchBar.text?.characters.count)! > 0 {
            filterContentForSearchText(searchController.searchBar.text!)
        } else {
            filterContentForSearchText("")
        }
    }
}
