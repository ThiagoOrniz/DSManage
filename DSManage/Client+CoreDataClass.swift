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
            
            if let client = (try? context.fetch(request))?.first {
                print("has client already")
                
            } else if let client = NSEntityDescription.insertNewObject(forEntityName: "Client", into: context) as? Client {
                print("yay new client")
                
                client.id = String(format:"%@",client.objectID)
                client.name = clientModel.name
                client.address = clientModel.address
                client.email = clientModel.email
                client.phone = clientModel.phone
            }

            try? context.save()
            
            retrieveAllClients()
        }
    }
    
    
    class func retrieveAllClients(){
        
        let context =  CoreDataStack().persistentContainer.viewContext
        
        context.perform {
            
            let request:NSFetchRequest = self.fetchRequest()
            
            do {
                let clients = try context.fetch(request) as [Client]
                
                for client in clients {
                    print(client.name)
                    print(client.id)
                    print(client.objectID)

                }
                
            } catch {
                let fetchError = error as NSError
                print(fetchError)
            }
            
        }
    }


}
