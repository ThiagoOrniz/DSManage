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
    func didSelectClient(_ client:ClientViewModel)
}

class ClientsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    private var clientsViewModel:[ClientViewModel] = []
    
    weak var clientsTableViewControllerDelegate:ClientsTableViewControllerDelegate?

    var isSelectableClient:Bool = false
    
    let context =  CoreDataStack().persistentContainer.viewContext
    
    var fetchedResultsController: NSFetchedResultsController<Client>?
    
//    lazy var fetchedResultsController:NSFetchedResultsController = { () -> NSFetchedResultsController<Client> in
//        let fetchRequest:NSFetchRequest = Client.fetchRequest()
//        var sortDescriptor:NSSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        
//        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack().persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//        
//        frc.delegate = self as! NSFetchedResultsControllerDelegate
//        return frc
//    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add,target: self,action: #selector(add))
        
        self.navigationItem.rightBarButtonItems = [addButtonItem,self.editButtonItem]
        
//        do{
//            try fetchedResultsController.performFetch()
//            
//            
//        } catch let err{
//            
//            print("_________error \(err)")
//        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        clientsViewModel =  ClientViewModel.getClients()
        
        print("VIEW WILL APPEAR")
        
        
        setupFetchedResultsController()

       
    }
    
    private func setupFetchedResultsController() {
        
        let fetchRequest:NSFetchRequest = Client.fetchRequest()// NSFetchRequest<Month>(entityName: "Month")
        let dateDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [dateDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController?.delegate = self
        
        try! fetchedResultsController?.performFetch()
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return clientsViewModel.count
        if let count = fetchedResultsController?.sections?[section].numberOfObjects {
            return count
        }
        
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ClientTableViewCell

        let client = fetchedResultsController?.object(at: indexPath) 
        
        
//        cell.populateView(with: clientsViewModel[indexPath.row])
        cell.clientNameLabel.text = client?.name

        
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

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        print("OI")
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
      
        print("oiii")
        
//        switch (type) {
//        case .insert:
//            if let indexPath = newIndexPath {
//                tableView.insertRows(at: [indexPath], with: .fade)
//            }
//            break;
//        case .delete:
//            if let indexPath = indexPath {
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            }
//            break;
//        case .update:
//            if let indexPath = indexPath {
//                let cell = tableView.cellForRow(at: indexPath) as! ClientTableViewCell
//            }
//            break;
//        default:
//            print("default")
//        
//        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
