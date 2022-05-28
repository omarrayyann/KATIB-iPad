//
//  ViewController.swift
//  Katib
//
//  Created by Omar Rayyan on 24/05/2022.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var passwordShadowView: UIView!
    @IBOutlet weak var usernameShadowView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = loginButton.frame.height/2
        registerButton.layer.cornerRadius = registerButton.frame.height/2
        registerButton.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        registerButton.layer.borderWidth = 1
        usernameField.textField_custom_1()
        passwordField.textField_custom_1()
        passwordShadowView.shadow_custom_1()
        usernameShadowView.shadow_custom_1()
        loginButton.shadow_custom_1()
        registerButton.shadow_custom_1()


        

        // Do any additional setup after loading the view.
    }

    @IBAction func clickedRegister(_ sender: Any) {
        errorLabel.isHidden = true
        let smallVC = storyboard!.instantiateViewController(identifier: "register")
        smallVC.modalPresentationStyle = .custom
        present(smallVC, animated: true, completion: nil )
    }
    
    @IBAction func clickedLogIn(_ sender: Any) {
        Auth.auth().signIn(withEmail: usernameField.text ?? "", password: passwordField.text ?? "") { authResult, error in
            if error != nil {
                self.errorLabel.isHidden = false
                self.errorLabel.shake()
            }
            else{
                print("successfully logged in")
                self.dismiss(animated: true)
            }
        }    }
    
}



