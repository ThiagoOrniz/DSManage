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

    var error = PublishSubject<String>()
    
    var isValid: Observable<(Bool,Bool)> {
        
        return Observable.combineLatest(self.email.asObservable(), self.password.asObservable())
        {
            return self.validates(email: $0, andPassword: $1)
        }
    }
    
    func validates(email: String, andPassword password: String) -> (Bool, Bool) {
        
        if(!TextfieldValidator.validateEmail(email)){
            return (false,true)
        }
        
        if(!TextfieldValidator.validatePassword(password)){
            return (true,false)
        }
        
        return (true,true)
    }
    
    func authWithFirebase() {
        
//        FIRAuth.auth()?.signIn(withEmail: email.value, password: password.value)
//        { [weak self] (user, error) in
//            
//            if error != nil {
//                var message: String?
//                
//                if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
//                    
//                    switch errCode {
//                    case .errorCodeInvalidEmail: message = "E-mail não existente."
//                    case .errorCodeWrongPassword: message = "Senha Incorreta."
//                    case .errorCodeUserNotFound: message = "E-mail não existente."
//                    default : message = "Por favor, verique sua conexão com a internet."
//                    }
//                }
//                
//                self?.error.onNext(message ?? "Por favor, verique sua conexão com a internet.")
//                
//            }
//        }
    }
    
    
//    var isValid: Observable<Bool> {
//        
//        return Observable.combineLatest(self.email.asObservable(), self.password.asObservable())
//        {
//            return self.validates(email: $0, andPassword: $1)
//        }
//    }
//    
//    private func validates(email: String, andPassword password: String) -> Bool{
//        
//        if(!TextfieldValidator.validateEmail(email)){
//            return false
//        }
//        
//        if(!TextfieldValidator.validatePassword(password)){
//            return false
//        }
//        
//        return true
//    }
//
}
