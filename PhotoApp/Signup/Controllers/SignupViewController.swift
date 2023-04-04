//
//  SignupViewController.swift
//  PhotoApp
//
//  Created by Ramón Dias de Oliveira Almeida on 28/03/23.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    var presenter: SignupPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        #if DEBUG
//        if CommandLine.arguments.contains("-skipSurvey") {
//            print("Skipping survey page")
//        }
//        #endif
//
//        #if DEBUG
//            if ProcessInfo.processInfo.arguments.contains("-skipSurvey") {
//                print("Skipping survey page")
//            }
//        #endif
        
        if presenter == nil {
            
            let signupURL = ProcessInfo.processInfo.environment["signupURL"] ?? SignupConstants.signupURLString
            
            presenter = SignupPresenter(
                formModelValidator: SignupFormModelValidator(),
                webService: SignupWebService(urlString: signupURL),
                delegate: self
            )
        }
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        let formModel = SignupFormModel(
            firstName: firstNameTextField.text ?? "",
            lastName: lastNameTextField.text ?? "",
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? "",
            repeatPassword: repeatPasswordTextField.text ?? ""
        )
        presenter?.processUserSignup(formModel: formModel)
    }
}

extension SignupViewController: SignupViewDelegateProtocol {
    func successfulSignup() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let controller = storyboard.instantiateViewController(withIdentifier: "CongratulationsViewController") as? CongratulationsViewController else { return }
//        navigationController?.pushViewController(controller, animated: true)
        
        let alert = UIAlertController(title: "Success", message: "Sign up was successful", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        DispatchQueue.main.async {
            alert.view.accessibilityIdentifier = "successAlertDialog"
            self.present(alert, animated: true)
        }
    }
    
    func errorHandler(error: SignupError) {
        let alert = UIAlertController(title: "Error", message: "Your request could not be processed at this time", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        DispatchQueue.main.async {
            alert.view.accessibilityIdentifier = "errorAlertDialog"
            self.present(alert, animated: true)
        }
    }
}

