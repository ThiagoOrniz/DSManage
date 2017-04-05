//
//  ClientDAO.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 04/04/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import CoreData

class ClientDAO: NSObject {
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!

    override init() {
        super.init()
        
        setupFetchedResultsController()
        
        do {
            try fetchedResultsController.performFetch()
            print(fetchedResultsController)
        } catch {
            fatalError("______Failed to initialize FetchedResultsController: \(error)")
        }
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
        
    }
    
    class func removeObject(_ client: Client) {
        CoreDataStack.getContext().delete(client)
        CoreDataStack.saveContext()
    }
    
}
