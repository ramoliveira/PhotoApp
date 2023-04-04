//
//  MockSignupViewDelegate.swift
//  PhotoAppTests
//
//  Created by Ramón Dias de Oliveira Almeida on 29/03/23.
//

import XCTest
@testable import PhotoApp

class MockSignupViewDelegate: SignupViewDelegateProtocol {
    var expectation: XCTestExpectation?
    var successfulSignupCounter = 0
    var errorHandlerCounter = 0
    
    func successfulSignup() {
        successfulSignupCounter += 1
        expectation?.fulfill()
    }
    
    func errorHandler(error: PhotoApp.SignupError) {
        errorHandlerCounter += 1
        expectation?.fulfill()
    }
}
