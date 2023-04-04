//
//  SignupWebServiceProtocol.swift
//  PhotoApp
//
//  Created by Ramón Dias de Oliveira Almeida on 29/03/23.
//

import Foundation

protocol SignupWebServiceProtocol {
    func signup(withFormModel model: SignupFormRequestModel, completion: @escaping (SignupResponseModel?, SignupError?) -> Void)
}
