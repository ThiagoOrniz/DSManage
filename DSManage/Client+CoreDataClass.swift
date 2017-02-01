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
    
    class func saveClient(_ clientModel:ClientModel){
        
        let context =  CoreDataStack().persistentContainer.viewContext
        
        context.perform {
            
            let request:NSFetchRequest = self.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", clientModel.id)
            
            do{
                let queryResults = try context.fetch(request)
                
                if queryResults.first != nil  {// queryResults.first as? ClientModel {
                    print("has client already")
                    return
                }
                else if let client = NSEntityDescription.insertNewObject(forEntityName: "Client", into: context) as? Client {
                    print("yay new client")
                    
                    client.id = clientModel.id
                    client.name = clientModel.name
                    client.address = clientModel.address
                    client.email = clientModel.email
                    client.phone = clientModel.phone
                    
                }
            }
            catch let error{
                print(error)
            }
            
            try? context.save()
        }
    }

}
