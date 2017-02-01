//
//  Client+CoreDataClass.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 31/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import CoreData

@objc(Client)
public class Client: NSManagedObject {
    
    class func saveClient(_ clientModel:ClientModel, inManagedObjectContext context:NSManagedObjectContext) {
        
        let request:NSFetchRequest = self.fetchRequest()
        request.predicate = NSPredicate(format: "unique =@", clientModel.id)
        
        do{
            let queryResults = try context.execute(request)
            
            if let client = queryResults.accessibilityElement(at: 0) as? ClientModel {
                print("has client already")
            }
            else if let client = NSEntityDescription.insertNewObject(forEntityName: "Client", into: context) as? Client {
                
                print("yay new client")
                
                client.name = clientModel.name
                client.address = clientModel.address
                client.email = clientModel.email
                client.phone = clientModel.phone
                
            }
        }
        catch let error{
            print(error)
        }
        
        
        
    }


}
