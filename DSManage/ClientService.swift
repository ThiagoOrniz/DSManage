//
//  ClientService.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 10/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class ClientService{
    
    func getClients()->[Client]{
        
        return [Client(name: "Jose",email: "jose@email.com",phone: "1111-1111",address: "rua 1"),
                Client(name: "Maria",email: "maria@email.com",phone: "2222-2222",address: "rua 2"),
                Client(name: "Joao",email: "joao@email.com",phone: "3333-3333",address: "rua 3")
        ]
        
    }

}
