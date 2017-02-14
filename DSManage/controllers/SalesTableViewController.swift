//
//  SalesTableViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 17/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit
import CoreData

class SalesTableViewController: UITableViewController,NSFetchedResultsControllerDelegate {

    private var sales:[Sale] = []

    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let addButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add,target: self,action: #selector(add))
        
        self.navigationItem.rightBarButtonItems = [addButtonItem]
        
    }
    
    func add(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Product", bundle:nil)
        
        let productCollectionViewController = storyBoard.instantiateViewController(withIdentifier: "productCollectionViewController") as! ProductCollectionViewController
        
        self.navigationController?.pushViewController(productCollectionViewController, animated: true)

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
    
    private func setupFetchedResultsController() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Sale")
        let sortDescriptor = NSSortDescriptor(key: "client.name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                              managedObjectContext: CoreDataStack.getContext(),
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil
        )
        
        fetchedResultsController.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedResultsController?.sections?[section].numberOfObjects {
            return count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SaleTableViewCell", for: indexPath) as! SaleTableViewCell
        
        configureCell(cell: cell, indexPath: indexPath)

        
//        let sale:Sale = sales[indexPath.row]
//        
//        cell.clientLabel.text = sale.client.name
//        cell.totalLabel.text = String(format:"%.2f",sale.getTotal())
        
    
        return cell
    }

    func configureCell(cell: SaleTableViewCell, indexPath: IndexPath) {
        
        guard let sale = fetchedResultsController.object(at: indexPath) as? Sale else {
            fatalError("Unexpected Object in FetchedResultsController")
        }
        
        cell.clientLabel.text = sale.client?.name
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sale:Sale = sales[indexPath.row]
        print(sale)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let saleDetailViewController = segue.destination as! SaleDetailViewController
        var selectedIndexPath = self.tableView?.indexPathsForSelectedRows?.first
        saleDetailViewController.setSale(sale: sales[(selectedIndexPath?.row)!])
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: NSFetchedResultsControllerDelegate Methods
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
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
                configureCell(cell: tableView.cellForRow(at: indexPath)! as! SaleTableViewCell, indexPath: indexPath)
            }
        default:
            print("default")
            
        }
    }

}
