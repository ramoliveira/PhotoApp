//
//  SignupViewControllerTests.swift
//  PhotoAppTests
//
//  Created by Ramón Dias de Oliveira Almeida on 30/03/23.
//

import XCTest
@testable import PhotoApp

final class SignupViewControllerTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var sut: SignupViewController!
    var navigationController: UINavigationController!
    var mockSignupPresenter: MockSignupPresenter!

    override func setUpWithError() throws {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController
        sut?.loadViewIfNeeded()
        
        let validator = MockSignupModelValidator()
        let webService = MockSignupWebService()
        mockSignupPresenter = MockSignupPresenter(
            formModelValidator: validator,
            webService: webService,
            delegate: sut
        )
        
        sut.presenter = mockSignupPresenter
        
        navigationController = UINavigationController(rootViewController: sut)
    }

    override func tearDownWithError() throws {
        storyboard = nil
        sut = nil
        navigationController = nil
        mockSignupPresenter = nil
    }

    func testSignupViewController_WhenCreated_HasRequiredTextFieldsEmpty() throws {
        let firstNameTextField = try XCTUnwrap(sut.firstNameTextField, "The firstNameTextField is not connected to an IBOutlet")
        let lastNameTextField = try XCTUnwrap(sut.lastNameTextField, "The lastNameTextField is not connected to an IBOutlet")
        let emailTextField = try XCTUnwrap(sut.emailTextField, "The emailTextField is not connected to an IBOutlet")
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "The passwordTextField is not connected to an IBOutlet")
        let repeatPasswordTextField = try XCTUnwrap(sut.repeatPasswordTextField, "The repeatPasswordTextField is not connected to an IBOutlet")
        
        
        XCTAssertEqual(firstNameTextField.text, "", "First name text field was not empty when the view controller intially loaded")
        XCTAssertEqual(lastNameTextField.text, "", "Last name text field was not empty when the view controller intially loaded")
        XCTAssertEqual(emailTextField.text, "", "Email text field was not empty when the view controller intially loaded")
        XCTAssertEqual(passwordTextField.text, "", "Password text field was not empty when the view controller intially loaded")
        XCTAssertEqual(repeatPasswordTextField.text, "", "Repeat password text field was not empty when the view controller intially loaded")
    }
    
    func testSignupViewController_WhenCreated_HasSignupButtonAction() throws {
        // Arrange
        let signupButton: UIButton = try XCTUnwrap(sut.signupButton, "The signupButton is not connected to an IBOutlet")
        
        // Act
        let actions = try XCTUnwrap(signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside), "Signup button does not have any actions assigned to it")
        
        // Assert
        XCTAssertEqual(actions.count, 1)
        XCTAssertEqual(actions.first, "signupButtonTapped:", "There is no action with a name signupButtonTapped assigned to signup button")
    }
    
    func testSignupViewController_WhenSignupButtonTapped_InvokesSignupProcess() {
        // Arrange
        // Act
        sut.signupButton.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssertTrue(mockSignupPresenter.processUserSignupCalled, "The processUserSignup() method was not called on a Presenter object when the signup button was tapped in a SignupViewController")
    }
    
    func testSignupViewController_WhenCreated_TextFieldsHaveContentType() throws {
        let firstNameTextField = try XCTUnwrap(sut.firstNameTextField, "The firstNameTextField is not connected to an IBOutlet")
        let lastNameTextField = try XCTUnwrap(sut.lastNameTextField, "The lastNameTextField is not connected to an IBOutlet")
        let emailTextField = try XCTUnwrap(sut.emailTextField, "The emailTextField is not connected to an IBOutlet")
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "The passwordTextField is not connected to an IBOutlet")
        let repeatPasswordTextField = try XCTUnwrap(sut.repeatPasswordTextField, "The repeatPasswordTextField is not connected to an IBOutlet")
        
        XCTAssertEqual(firstNameTextField.textContentType, .givenName)
        XCTAssertEqual(lastNameTextField.textContentType, .familyName)
        XCTAssertEqual(emailTextField.textContentType, .emailAddress)
        XCTAssertEqual(passwordTextField.textContentType, .password)
        XCTAssertEqual(repeatPasswordTextField.textContentType, .password)
    }
    
//    func testSignupViewController_WhenSignupButtonIsTapped_ShouldOpenCongratulationsScreen() {
//        let predicate = NSPredicate { input, _ in
//            return (input as? UINavigationController)?.topViewController is CongratulationsViewController
//        }
//        
//        self.expectation(for: predicate, evaluatedWith: navigationController)
//        
//        sut.signupButton.sendActions(for: .touchUpInside)
//        
//        self.waitForExpectations(timeout: 30)
//    }
//    
//    func testSignupViewController_WhenSignupButtonIsTapped_ShouldOpenCongratulationsScreen_V2() {
//        sut.signupButton.sendActions(for: .touchUpInside)
//        
//        RunLoop.current.run(until: Date())
//        
//        guard let _ = navigationController.topViewController as? CongratulationsViewController else {
//            XCTFail("Congratulations is not topVieController")
//            return
//        }
//    }
//    
//    func testSignupViewController_WhenSignupButtonIsTapped_ShouldOpenCongratulationsScreen_V3() {
//        let spyNavigationController = SpyNavigationController(rootViewController: sut)
//        
//        sut.signupButton.sendActions(for: .touchUpInside)
//        
//        guard let _ = spyNavigationController.pushedViewController as? CongratulationsViewController else {
//            XCTFail()
//            return
//        }
//    }
}
