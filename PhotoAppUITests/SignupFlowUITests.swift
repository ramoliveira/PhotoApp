//
//  SignupFlowUITests.swift
//  PhotoAppUITests
//
//  Created by Ramón Dias de Oliveira Almeida on 28/03/23.
//

import XCTest

final class SignupFlowUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var firstName: XCUIElement!
    private var lastName: XCUIElement!
    private var email: XCUIElement!
    private var password: XCUIElement!
    private var repeatPassword: XCUIElement!
    private var signupButton: XCUIElement!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launchArguments = ["-skipSurvey", "-debugServer"]
//        app.launchEnvironment = [
//            "signupURL": "https://tlyqhtlbn8.execute-api.us-east-1.amazonaws.com/prod/signup-mock-service/users",
//            "inAppPurchaseEnabled": "true"
//        ]
        app.launch()
        
        firstName = app.textFields["firstNameTextField"]
        lastName = app.textFields["lastNameTextField"]
        email = app.textFields["emailTextField"]
        password = app.secureTextFields["passwordTextField"]
        repeatPassword = app.secureTextFields["repeatPasswordTextField"]
        signupButton = app.buttons["signupButton"]
        
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
        
        firstName = nil
        lastName = nil
        email = nil
        password = nil
        repeatPassword = nil
        signupButton = nil
        
        try super.tearDownWithError()
    }

    func testSignupViewController_WhenViewLoaded_RequiredUIElementsAreEnabled() {
        XCTAssertTrue(firstName.isEnabled, "First name UITextField is not enabled for user interactions")
        XCTAssertTrue(lastName.isEnabled, "Last name UITextField is not enabled for user interactions")
        XCTAssertTrue(email.isEnabled, "Email UITextField is not enabled for user interactions")
        XCTAssertTrue(password.isEnabled, "Password UITextField is not enabled for user interactions")
        XCTAssertTrue(repeatPassword.isEnabled, "Repeat password UITextField is not enabled for user interactions")
        XCTAssertTrue(signupButton.isEnabled, "Signup UIButton is not enabled for user interactions")
    }
    
    func testSignupViewController_WhenInvalidFormSubmitted_PresentsErrorAlertDialog() {
        firstName.tap()
        firstName.typeText("R")
        
        lastName.tap()
        lastName.typeText("A")
        
        email.tap()
        email.typeText("@")
        
        password.tap()
        password.typeText("1234567890")
        
        repeatPassword.tap()
        repeatPassword.typeText("123")
        
        // Act
        signupButton.tap()
        
//        let emailTextFieldScreenshot = email.screenshot()
//        let emailTextFieldAttachment = XCTAttachment(screenshot: emailTextFieldScreenshot)
//        emailTextFieldAttachment.name = "Screenshot of email text field"
//        emailTextFieldAttachment.lifetime = .keepAlways
//        add(emailTextFieldAttachment)
        
        let currentAppWindow = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: currentAppWindow)
        attachment.name = "Sign up page screenshot"
        attachment.lifetime = .keepAlways
        add(attachment)
        
        // Assert
        XCTAssertTrue(app.alerts["errorAlertDialog"].waitForExistence(timeout: 1), "An Error Alert dialog was not presented when invalid signup form was submitted")
    }
    
    func testSignupViewController_WhenValidFormSubmitted_PresentsSuccessAlertDialog() {
        firstName.tap()
        firstName.typeText("Ramón")
        
        lastName.tap()
        lastName.typeText("Almeida")
        
        email.tap()
        email.typeText("test@test.com")
        
        password.tap()
        password.typeText("12345678")
        
        repeatPassword.tap()
        repeatPassword.typeText("12345678")
        
        // Act
        signupButton.tap()
        
        // Assert
        XCTAssertTrue(app.alerts["successAlertDialog"].waitForExistence(timeout: 1), "A Success Alert dialog was not presented when invalid signup form was submitted")
    }
}
