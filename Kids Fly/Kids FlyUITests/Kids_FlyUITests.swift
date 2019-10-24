//
//  Kids_FlyUITests.swift
//  Kids FlyUITests
//
//  Created by Jake Connerly on 10/23/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import XCTest

class Kids_FlyUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testappLaunchAndSignIn() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.segmentedControls.buttons["Sign In"].tap()
        //signIn emailTextField Test
        app.textFields["signInEmailTextField"].tap()
        app.textFields["signInEmailTextField"].typeText("testymcTesterson@test.com")
        XCTAssertEqual(app.textFields["signInEmailTextField"].value as! String, "testymcTesterson@test.com")
        
        //signIn fullNameTextField Test
        app.textFields["signInFullNameTextField"].tap()
        app.textFields["signInFullNameTextField"].typeText("Testy McTesterson IV")
        XCTAssertEqual(app.textFields["signInFullNameTextField"].value as! String, "Testy McTesterson IV")
        
        //signIn passwordTextField Test
        app.secureTextFields["passwordTextField"].tap()
        app.secureTextFields["passwordTextField"].typeText("password")
        XCTAssertEqual(app.secureTextFields["passwordTextField"].value as! String, "••••••••")
        
        app.buttons["SignInButton"].tap()
        
        
        app.buttons["BookATripMainButton"].tap()
    }
    


    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
