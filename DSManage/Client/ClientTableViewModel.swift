//
//  ClientTableViewModel.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 04/04/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class ClientTableViewModel: NSObject {
    
    var clients = [Client]()
    private var clientDAO: ClientDAO?
    var objectHasUpdatedDelegate: ObjectHasUpdated?

    override init() {
        super.init()
        
        fetchClients()
    }
    
    func fetchClients() {
        clientDAO = ClientDAO()
        clientDAO?.fetchedResultsController.delegate = self
        
        clients = clientDAO?.fetchedResultsController.fetchedObjects as! [Client]
    }
    
    func count() -> Int {
        return clients.count
    }
    
    func get(at index: Int) -> ClientViewModel {
        return ClientViewModel(client: clients[index])
    }
    
    func removeObject(at index: Int){
        ClientDAO.removeObject(clients[index])
    }
    
}
