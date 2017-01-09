//
//  DSManageUITests.swift
//  DSManageUITests
//
//  Created by Thiago Orniz Martin on 31/12/16.
//  Copyright © 2016 Thiago Orniz Martin. All rights reserved.
//

import XCTest

class DSManageUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        XCUIApplication().launch()

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValidateEmailAndPassword_thenLogin() {
    
        let app = XCUIApplication()
        let scrollViewsQuery = app.scrollViews
        
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.textFields["email"].tap()
        elementsQuery.textFields["email"].typeText("oi@oi.com")
        
        elementsQuery.textFields["password"].tap()
        elementsQuery.textFields["password"].typeText("123456")
        
       let login = XCUIApplication().scrollViews.otherElements.buttons["Log in"]
        login.tap()
        
        let alertEmail = app.alerts["Invalid email"]
        let alertPassword = app.alerts["Invalid password"]
        
        XCTAssertFalse(alertEmail.exists)
        XCTAssertFalse(alertPassword.exists)
        
        
    }
    
}
