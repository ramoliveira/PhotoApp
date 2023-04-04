//
//  SignupModelValidatorProtocol.swift
//  PhotoApp
//
//  Created by Ramón Dias de Oliveira Almeida on 29/03/23.
//

import Foundation

protocol SignupModelValidatorProtocol {
    func isFirstNameValid(firstName: String) -> Bool
    func isLastNameValid(lastName: String) -> Bool
    func isEmailValid(email: String) -> Bool
    func isPasswordValid(password: String) -> Bool
    func doPasswordMatch(password: String, repeatPassword: String) -> Bool
}
