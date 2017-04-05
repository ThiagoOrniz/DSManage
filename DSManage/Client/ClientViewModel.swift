//
//  ClientViewModel.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 21/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import CoreData



class ClientViewModel {
    
    private var client = Client()
    
    var nameText: String {
        get{
            return client.name ?? ""
        }
        set{
            client.name = newValue
        }
    }
    
    var emailText: String {
        get{
            return client.email ?? ""
        }
        set{
            client.email = newValue
        }
    }
    
    var addressText: String {
        get{
            return client.address ?? ""
        }
        set{
            client.address = newValue
        }
    }
    
    var phoneText: String {
        get{
            return client.phone ?? ""
        }
        set{
            client.phone = newValue
        }
    }
    
    var avatar: Data {
        get {
            return client.avatar as Data? ?? Data()
        }
        set {
            client.avatar = newValue as NSData?
        }
    }
    

    init(){
        client = Client(context: CoreDataStack.getContext())
    }
    
    init(client: Client){
        self.client = client
    }
    
    func saveClient(){
        ClientDAO.saveObject()
    }
    
    func removeClient() {
        ClientDAO.removeObject(client)
    }
}
