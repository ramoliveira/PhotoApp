//
//  SignupFormModelValidatorTests.swift
//  PhotoAppTests
//
//  Created by Ramón Dias de Oliveira Almeida on 28/03/23.
//

import XCTest
@testable import PhotoApp

final class SignupFormModelValidatorTests: XCTestCase {
    
    var sut: SignupFormModelValidator!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SignupFormModelValidator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testSignFormModelValidator_WhenValidFirstNameProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "Ramón")
        
        // Assert
        XCTAssertTrue(isFirstNameValid, "The isFirstNameValid() should have returned TRUE for a valid first name but returned FALSE")
    }
    
    func testSignFormModelValidator_WhenTooShortFirstNameProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "R")
        
        // Assert
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned FALSE for a first name that is shorter than \(SignupConstants.firstNameRange.lowerBound) characters but it has returned TRUE")
    }
    
    func testSignFormModelValidator_WhenTooLongFirstNameProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "RamónRamónRamón")
        
        // Assert
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned FALSE for a first name that is longer than \(SignupConstants.firstNameRange.upperBound) characters but it has returned TRUE")
    }
    
    func testSignFormModelValidator_WhenValidLastNameProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let isFirstNameValid = sut.isLastNameValid(lastName: "Ramón")
        
        // Assert
        XCTAssertTrue(isFirstNameValid, "The isFirstNameValid() should have returned TRUE for a valid first name but returned FALSE")
    }
    
    func testSignFormModelValidator_WhenTooShortLastNameProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isFirstNameValid = sut.isLastNameValid(lastName: "R")
        
        // Assert
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned FALSE for a first name that is shorter than \(SignupConstants.lastNameRange.lowerBound) characters but it has returned TRUE")
    }
    
    func testSignFormModelValidator_WhenTooLongLastNameProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isFirstNameValid = sut.isLastNameValid(lastName: "RamónRamónRamónRamón")
        
        // Assert
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned FALSE for a first name that is longer than \(SignupConstants.lastNameRange.upperBound) characters but it has returned TRUE")
    }
    
    func testSignFormModelValidator_WhenValidEmailProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let isEmailValid = sut.isEmailValid(email: "ramon@ramon.com")
        
        // Assert
        XCTAssertTrue(isEmailValid, "The isEmailValid() should have returned TRUE for a valid email but returned FALSE")
    }
    
    func testSignFormModelValidator_WhenInvalidEmailProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isEmailValid = sut.isEmailValid(email: "ramon@@ramon")
        
        // Assert
        XCTAssertFalse(isEmailValid, "The isEmailValid() should have returned FALSE for a valid email but returned TRUE")
    }
    
    func testSignFormModelValidator_WhenEqualPasswordProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let doPasswordMatch = sut.doPasswordMatch(password: "1234", repeatPassword: "1234")
        
        // Assert
        XCTAssertTrue(doPasswordMatch, "The doPasswordMatch() should have returned TRUE for a valid first name but returned FALSE")
    }
    
    func testSignFormModelValidator_WhenUnequalPasswordProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let doPasswordMatch = sut.doPasswordMatch(password: "1234", repeatPassword: "123456")
        
        // Assert
        XCTAssertFalse(doPasswordMatch, "The doPasswordMatch() should have returned FALSE for a valid first name but returned TRUE")
    }
    
    func testSignFormModelValidator_WhenTooShortPasswordProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "12")
        
        // Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should have returned FALSE for a first name that is shorter than \(SignupConstants.passswordRange.lowerBound) characters but it has returned TRUE")
    }
    
    func testSignFormModelValidator_WhenTooLongPasswordProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "123456789012")
        
        // Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should have returned FALSE for a first name that is longer than \(SignupConstants.passswordRange.upperBound) characters but it has returned TRUE")
    }
}
