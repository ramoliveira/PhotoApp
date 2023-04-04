//
//  MockSignupWebService.swift
//  PhotoAppTests
//
//  Created by Ramón Dias de Oliveira Almeida on 29/03/23.
//

import Foundation
@testable import PhotoApp

class MockSignupWebService: SignupWebServiceProtocol {
    
    var isSignupMethodCalled: Bool = false
    var signupResponseModel: SignupResponseModel?
    var signupError: SignupError?
    
    func signup(withFormModel model: PhotoApp.SignupFormRequestModel, completion: @escaping (PhotoApp.SignupResponseModel?, PhotoApp.SignupError?) -> Void) {
        isSignupMethodCalled = true
        
        if let signupResponseModel = signupResponseModel {
            completion(signupResponseModel, nil)
            return
        }
        
        if let signupError = signupError {
            completion(nil, signupError)
        }
    }
    
}
