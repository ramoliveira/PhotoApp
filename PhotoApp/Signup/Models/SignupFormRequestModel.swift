//
//  SignupFormRequestModel.swift
//  PhotoApp
//
//  Created by Ramón Dias de Oliveira Almeida on 29/03/23.
//

import Foundation

struct SignupFormRequestModel: Encodable {
    let firstName: String?
    let lastName: String?
    let email: String?
    let password: String?
}
