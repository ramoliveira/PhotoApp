//
//  SignupPresenter.swift
//  PhotoApp
//
//  Created by Ramón Dias de Oliveira Almeida on 29/03/23.
//

import Foundation

class SignupPresenter: SignupPresenterProtocol {
    private var formModelValidator: SignupModelValidatorProtocol
    private var webService: SignupWebServiceProtocol
    private weak var delegate: SignupViewDelegateProtocol?
    
    required init(
        formModelValidator: SignupModelValidatorProtocol,
        webService: SignupWebServiceProtocol,
        delegate: SignupViewDelegateProtocol
    ) {
        self.formModelValidator = formModelValidator
        self.webService = webService
        self.delegate = delegate
    }
    
    func processUserSignup(formModel: SignupFormModel) {
        if !formModelValidator.isFirstNameValid(firstName: formModel.firstName) {
            delegate?.errorHandler(error: .invalidFirstName)
            return
        }
        
        if !formModelValidator.isLastNameValid(lastName: formModel.lastName) {
            delegate?.errorHandler(error: .invalidLastName)
            return
        }
        
        if !formModelValidator.isEmailValid(email: formModel.email) {
            delegate?.errorHandler(error: .invalidEmail)
            return
        }
        
        if !formModelValidator.isPasswordValid(password: formModel.password) {
            delegate?.errorHandler(error: .invalidPassword)
            return
        }
        
        if !formModelValidator.doPasswordMatch(password: formModel.password, repeatPassword: formModel.repeatPassword) {
            delegate?.errorHandler(error: .passwordsDoNotMatch)
            return
        }
        
        let requestModel = SignupFormRequestModel(
            firstName: formModel.firstName,
            lastName: formModel.lastName,
            email: formModel.email,
            password: formModel.password
        )
        
        webService.signup(withFormModel: requestModel) { [weak self] response, error in
            guard let self = self else { return }
            if let _ = response {
                self.delegate?.successfulSignup()
                return
            }
            if let error = error {
                self.delegate?.errorHandler(error: error)
            }
        }
    }
}
