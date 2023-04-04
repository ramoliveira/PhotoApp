//
//  SignupFormModelValidator.swift
//  PhotoApp
//
//  Created by Ramón Dias de Oliveira Almeida on 28/03/23.
//

import Foundation

class SignupFormModelValidator: SignupModelValidatorProtocol {
    func isFirstNameValid(firstName: String) -> Bool {
        SignupConstants.firstNameRange.contains(firstName.count)
    }
    
    func isLastNameValid(lastName: String) -> Bool {
        SignupConstants.lastNameRange.contains(lastName.count)
    }
    
    func isEmailValid(email: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", #"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"#).evaluate(with: email)
    }
    
    func isPasswordValid(password: String) -> Bool {
        SignupConstants.passswordRange.contains(password.count)
    }
    
    func doPasswordMatch(password: String, repeatPassword: String) -> Bool {
        password == repeatPassword
    }
}
