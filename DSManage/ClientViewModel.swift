//
//  ClientViewModel.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 21/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class ClientViewModel{
    private var client = Client()

    var id: String {
        return client.id
    }
    
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
    
    init(client:Client){
        self.client = client
    }
    
    func updateShoppingCart(){
        ShoppingCartService.sharedInstance.updateClient(client: client)
    }
    
    static func getClients()-> [ClientViewModel]{
        return ClientService().getClients()
    }

    
}
