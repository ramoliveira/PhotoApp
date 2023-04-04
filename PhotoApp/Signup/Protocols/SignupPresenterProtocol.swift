//
//  SignupPresenterProtocol.swift
//  PhotoApp
//
//  Created by Ramón Dias de Oliveira Almeida on 31/03/23.
//

import Foundation

protocol SignupPresenterProtocol: AnyObject {
    init(formModelValidator: SignupModelValidatorProtocol, webService: SignupWebServiceProtocol, delegate: SignupViewDelegateProtocol)
    
    func processUserSignup(formModel: SignupFormModel)
}
