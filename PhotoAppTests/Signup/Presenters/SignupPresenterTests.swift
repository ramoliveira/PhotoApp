//
//  SignupPresenterTests.swift
//  PhotoAppTests
//
//  Created by Ramón Dias de Oliveira Almeida on 29/03/23.
//

import XCTest
@testable import PhotoApp

final class SignupPresenterTests: XCTestCase {
    
    var signupFormModel: SignupFormModel!
    var mockSignupModelValidator: MockSignupModelValidator!
    var mockSignupWebService: MockSignupWebService!
    var sut: SignupPresenter!
    var mockSignupViewDelegate: MockSignupViewDelegate!

    override func setUpWithError() throws {
        signupFormModel = SignupFormModel(
            firstName: "Ramón",
            lastName: "Almeida",
            email: "test@test.com",
            password: "12345678",
            repeatPassword: "12345678"
        )
        mockSignupModelValidator = MockSignupModelValidator()
        mockSignupWebService = MockSignupWebService()
        mockSignupViewDelegate = MockSignupViewDelegate()
        sut = SignupPresenter(
            formModelValidator: mockSignupModelValidator,
            webService: mockSignupWebService,
            delegate: mockSignupViewDelegate
        )
    }

    override func tearDownWithError() throws {
        signupFormModel = nil
        mockSignupModelValidator = nil
        mockSignupWebService = nil
        mockSignupViewDelegate = nil
        sut = nil
    }
    
    func testSignupPresenter_WhenInformationProvided_WillValidateEachProperty() {
        // Arrange
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        
        // Assert
        XCTAssertTrue(mockSignupModelValidator.isFirstNameValidated, "First name was not validated.")
        XCTAssertTrue(mockSignupModelValidator.isLastNameValidated, "Last name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isEmailValidated, "Email was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordValidated, "Password was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordEqualityValidated, "Password equality was not validated")
    }
    
    func testSignupPresenter_WhenGivenValidFormModel_ShouldCallSignupMethod() {
        // Arrange
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        
        // Assert
        XCTAssertTrue(mockSignupWebService.isSignupMethodCalled, "signup() method was not called in the SignupWebService class")
    }
    
    func testSignupPresenter_WhenSignupOperationSuccessful_CallsSuccessOnViewDelegate() {
        // Arrange
        let viewExpectation = XCTestExpectation(description: "Expected the successfulSignup() method to be called")
        
        mockSignupViewDelegate.expectation = viewExpectation
        mockSignupWebService.signupResponseModel = SignupResponseModel(status: "ok")
        
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        self.wait(for: [viewExpectation], timeout: 5)
        
        // Assert
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 1, "successfulSignup() method was called more than one time")
    }
    
    func testSignupPresenter_WhenSignupOperationFailed_CallsErrorHandlerOnViewDelegate() {
        let viewExpectation = XCTestExpectation(description: "Expected the errorHandler() method to be called")
        
        mockSignupViewDelegate.expectation = viewExpectation
        mockSignupWebService.signupError = SignupError.failedRequest
        
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        self.wait(for: [viewExpectation], timeout: 5)
        
        // Assert
        XCTAssertEqual(mockSignupViewDelegate.errorHandlerCounter, 1, "errorHandler() method was called more than one time")
    }
}
