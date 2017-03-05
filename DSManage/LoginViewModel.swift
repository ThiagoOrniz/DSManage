//
//  LoginViewModel.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 05/03/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel {
    
    var email = Variable<String>("")
    var password = Variable<String>("")
    
    var isValid: Observable<Bool> {
        
        return Observable.combineLatest(self.email.asObservable(), self.password.asObservable())
        {
            return self.validates(email: $0, andPassword: $1)
        }
    }
    
    private func validates(email: String, andPassword password: String) -> Bool{
        
        if(!TextfieldValidator.validateEmail(email)){
            return false
        }
        
        if(!TextfieldValidator.validatePassword(password)){
            return false
        }
        
        return true
    }

}
