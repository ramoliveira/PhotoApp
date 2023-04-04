//
//  SignupWebService.swift
//  PhotoApp
//
//  Created by Ramón Dias de Oliveira Almeida on 29/03/23.
//

import Foundation

class SignupWebService: SignupWebServiceProtocol {
    
    private var urlString: String
    private var urlSession: URLSession
    
    init(urlString: String, urlSession: URLSession = URLSession.shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func signup(withFormModel model: SignupFormRequestModel, completion: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, SignupError.invalidRequestURLString)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(model)
        
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(nil, SignupError.failedRequest)
                return
            }
            
            if let data = data, let response = try? JSONDecoder().decode(SignupResponseModel.self, from: data) {
                completion(response, nil)
            } else {
                completion(nil, SignupError.invalidResponseModel)
            }
        }
        
        dataTask.resume()
    }
    
}
