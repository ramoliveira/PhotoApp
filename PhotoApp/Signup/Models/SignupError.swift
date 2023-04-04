//
//  SignupError.swift
//  PhotoApp
//
//  Created by Ramón Dias de Oliveira Almeida on 29/03/23.
//

import Foundation

enum SignupError: Error, Equatable {
    case invalidResponseModel
    case invalidRequestURLString
    case failedRequest
    case illegalCharactersFound
    case invalidFirstName
    case invalidLastName
    case invalidEmail
    case invalidPassword
    case passwordsDoNotMatch
}
