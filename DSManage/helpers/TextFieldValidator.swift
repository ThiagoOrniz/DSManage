//
//  TextFieldValidator.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 08/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class TextfieldValidator{
    
    static func validateEmail(_ email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    static func validatePassword(_ password:String) -> Bool {
        return password.characters.count >= 6
    }
    
    static func validateName(_ name:String) -> Bool {
        return name.characters.count >= 2
    }
        
}
