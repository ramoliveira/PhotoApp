//
//  MockSignupPresenter.swift
//  PhotoAppTests
//
//  Created by Ramón Dias de Oliveira Almeida on 31/03/23.
//

import Foundation
@testable import PhotoApp

class MockSignupPresenter: SignupPresenterProtocol {
    var processUserSignupCalled: Bool = false
    
    weak var delegate: SignupViewDelegateProtocol?
    
    required init(formModelValidator: SignupModelValidatorProtocol, webService: SignupWebServiceProtocol, delegate: SignupViewDelegateProtocol) {
        self.delegate = delegate
    }
    
    func processUserSignup(formModel: SignupFormModel) {
        processUserSignupCalled = true
        delegate?.successfulSignup()
    }
}
