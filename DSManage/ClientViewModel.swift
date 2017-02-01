//
//  ClientViewModel.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 21/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import CoreData

class ClientViewModel{
    
    private var client = ClientModel()

    var nameText: String {
        get{
            return client.name
        }
        set{
            client.name = newValue
        }
    }
    
    var emailText: String {
        get{
            return client.email
        }
        set{
            client.email = newValue
        }
    }
    
    var addressText: String {
        get{
            return client.address
        }
        set{
            client.address = newValue
        }
    }
    
    var phoneText: String {
        get{
            return client.phone
        }
        set{
            client.phone = newValue
        }
    }
    
    var photoText: String {
        return client.photoURL
    }
    
    init(client:ClientModel){
        self.client = client
    }
    
    func updateShoppingCart(){
        ShoppingCartService.sharedInstance.updateClient(client: client)
    }
    
    static func getClients()-> [ClientViewModel]{
        return ClientService().getClients()
    }
    
    func saveClient(){
        
        CoreDataStack().persistentContainer.viewContext.perform {
            
            Client.saveClient(self.client, inManagedObjectContext: CoreDataStack().persistentContainer.viewContext)
            
            try? CoreDataStack().persistentContainer.viewContext.save()
            
        }
    }
    
    func printStatistics(){
        
        let context = CoreDataStack().persistentContainer.viewContext
        
        context.perform {
        
            let request:NSFetchRequest = Client.fetchRequest()
            let results = try? context.fetch(request)
            print("results:")
            print(results?.count ?? "without results")

        }
    }
    
}
