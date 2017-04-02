//
//  LoginViewControllerTests.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 09/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import XCTest
@testable import DSManage

class TextFieldValidatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValidEmail() {

        var email = "email@test.com"
        XCTAssert(TextfieldValidator.validateEmail(email))
        
        email = "em"
        XCTAssertFalse(TextfieldValidator.validateEmail(email))

    }
    
    func testValidPassword() {
        
        var password = "password"
        XCTAssert(TextfieldValidator.validatePassword(password))
        
        password = "s"
        XCTAssertFalse(TextfieldValidator.validatePassword(password))
    }
    
    func testValidName() {
        
        var name = "nameOk"
        XCTAssert(TextfieldValidator.validateName(name))
        
        name = ""
        XCTAssertFalse(TextfieldValidator.validateName(name))
    }
}
