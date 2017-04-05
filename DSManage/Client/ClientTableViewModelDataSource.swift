//
//  ClientTableViewModelDataSource.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 04/04/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import CoreData

extension ClientTableViewModel: NSFetchedResultsControllerDelegate  {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?)
    {
        
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                clients.insert(controller.object(at: indexPath) as! Client, at: indexPath.row)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                clients.remove(at: indexPath.row)
            }
            break
        default:
            print("default")
            
        }
        
        objectHasUpdatedDelegate?.hasUpdated()
    }

}
