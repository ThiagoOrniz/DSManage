//
//  Client.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 31/12/16.
//  Copyright © 2016 Thiago Orniz Martin. All rights reserved.
//

import Foundation

struct ClientModel {
    
    var id: String = ""
    var name: String = ""
    var email: String = ""
    var phone: String = ""
    var photoURL: String = ""
    var address:String = ""
    
     init(){
    }
    
    init(id:String, name:String, email:String, phone:String, address:String, photoURL:String){
        
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.address = address
        self.photoURL = photoURL
        
    }

    
}
