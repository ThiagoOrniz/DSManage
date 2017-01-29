//
//  ClientService.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 10/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class ClientService{
    
    func getClients()->[ClientViewModel]{
        
        return [ClientViewModel(client:ClientModel(id:"01", name: "R2D2",email: "r2d2@oldrepublic.com",phone: "1111-1111",address: "Tatooine", photoURL:"user_r2d2")),
                
                ClientViewModel(client:ClientModel(id:"02", name: "Chewie",email: "chewie@rebel.com",phone: "2222-2222",address: "Millennium Falcon", photoURL:"user_chewie")),
                
                ClientViewModel(client:ClientModel(id:"03", name: "Ewok",email: "ewok@fuffly.endor",phone: "3333-3333",address: "Endor", photoURL:"user_ewok"))
        ]
        
    }

}
