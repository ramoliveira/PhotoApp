//
//  SignupWebServiceTests.swift
//  PhotoAppTests
//
//  Created by Ramón Dias de Oliveira Almeida on 29/03/23.
//

import XCTest
@testable import PhotoApp

final class SignupWebServiceTests: XCTestCase {
    
    var sut: SignupWebService!
    var signupFormRequestModel: SignupFormRequestModel!

    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        sut = SignupWebService(urlString: SignupConstants.signupURLString, urlSession: urlSession)
        
        signupFormRequestModel = SignupFormRequestModel(
            firstName: "Ramón",
            lastName: "Almeida",
            email: "test@test.com",
            password: "12345678"
        )
    }

    override func tearDownWithError() throws {
        sut = nil
        signupFormRequestModel = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnSuccess() {
        // Arrange
        let jsonString = "{\"status\":\"ok\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = XCTestExpectation(description: "signup() method expectation for a response that contains a \(String(describing: SignupResponseModel.self))")
        
        // Act
        sut.signup(withFormModel: signupFormRequestModel) { (model, error) in
            // Assert
            XCTAssertNotNil(model, "The signup(withFormRequest:) should have returned a \(String(describing: SignupResponseModel.self)) but returned NIL")
            XCTAssertEqual(model?.status, "ok", "The signup(withFormRequest:) should have returned a status OK but returned ERROR")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenReceivedDifferentJSONResponse_ErrorTookPlace() {
        // Arrange
        let jsonString = "{\"path\":\"users\", \"error\":\"Internal Server Error\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = XCTestExpectation(description: "signup() method expectation for a response that contains a different JSON structure")
        
        // Act
        sut.signup(withFormModel: signupFormRequestModel) { (model, error) in
            // Assert
            XCTAssertEqual(error, SignupError.invalidResponseModel, "The signup(withFormRequest:) should have returned a \(SignupError.invalidResponseModel) error")
            XCTAssertNil(model, "The signup(withFormRequest:) should have returned a NIL but returned \(String(describing: SignupResponseModel.self))")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenEmptyURLStringProvided_ReturnsError() {
        // Arrange
        sut = SignupWebService(urlString: "")
        
        let expectation = XCTestExpectation(description: "signup() method expectation for a URL request with empty string")
        // Act
        sut.signup(withFormModel: signupFormRequestModel) { model, error in
            // Assert
            XCTAssertEqual(error, SignupError.invalidRequestURLString, "The signup(withFormRequest:) should have returned a \(SignupError.invalidRequestURLString)")
            XCTAssertNil(model, "The signup(withFormRequest:) should have returned a NIL but returned \(String(describing: SignupResponseModel.self))")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenURLRequestFails_ReturnsErrorMessageDescription() {
        // Arrange
        MockURLProtocol.error = SignupError.failedRequest
        
        let expectation = XCTestExpectation(description: "signup() method expectation for a failed request")
        
        // Act
        sut.signup(withFormModel: signupFormRequestModel) { model, error in
            // Assert
            XCTAssertEqual(error, SignupError.failedRequest)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
}
