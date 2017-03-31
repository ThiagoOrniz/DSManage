//
//  ForgotPasswordViewModel.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 30/03/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//


import Foundation
import RxSwift

class ForgotPasswordViewModel {
    
    var email = Variable<String>("")
    
    var isValid: Observable<Bool> {
        return Observable.just(TextfieldValidator.validateEmail(email.value))
    }
    
    var callbackMessage = PublishSubject<String>()
    
    
    func sendEmail() {
        
        // try to send email using a backend service
        
        // if email sending service is completed
        // do nothing
        // else
        // self?.callbackMessage.onNext(title ?? "Não foi possível enviar e-mail.")
    }
}
