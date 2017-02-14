//
//  SaleDetailViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 17/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit
import CoreData

class SaleDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var clientLabel: UILabel!
    @IBOutlet weak var clientImageView: UIImageView!
    
    var products:[ProductModel] = []
    var sale:Sale = Sale()
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        productsTableView.register(UINib(nibName: "ProductSaleTableViewCell", bundle: nil), forCellReuseIdentifier: "ShoppingCartTableViewCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        populateView()
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

    
    
    private func populateView(){
//        self.clientLabel.text = self.sale.client.name
//        self.clientImageView.image = UIImage(named: self.sale.client.photoURL)
//        self.products = self.sale.products
//        self.totalLabel.text = String(format:"%.2f",sale.getTotal())
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedResultsController?.sections?[section].numberOfObjects {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartTableViewCell", for: indexPath) as! ShoppingCartTableViewCell
//        
//        
//        let product:ProductModel = products[indexPath.row]
//        
//        cell.productLabel.text = product.product
//        cell.priceLabel.text = String(format:"%.2f",product.price)
//        cell.quantityLabel.text = product.quantity + " item(s)"
////        cell.subtotalLabel.text = product.getSubTotal()
//        cell.productImageView.image = UIImage(named: product.photoURL)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartTableViewCell", for: indexPath) as! ShoppingCartTableViewCell
        
        configureCell(cell: cell, indexPath: indexPath)

        
        return cell
    }

    func configureCell(cell: ShoppingCartTableViewCell, indexPath: IndexPath) {
        
        guard let sale = fetchedResultsController.object(at: indexPath) as? Sale else {
            fatalError("Unexpected Object in FetchedResultsController")
        }
        
        cell.priceLabel.text = sale.client?.name
    }

    
    public func setSale(sale:Sale){
        self.sale = sale
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: NSFetchedResultsControllerDelegate Methods
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.productsTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.productsTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                
                productsTableView.insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                productsTableView.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        case .update:
            if let indexPath = newIndexPath {
                configureCell(cell: productsTableView.cellForRow(at: indexPath)! as! ShoppingCartTableViewCell, indexPath: indexPath)
            }
        default:
            print("default")
            
        }
    }

    

}
