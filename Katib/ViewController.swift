//
//  ViewController.swift
//  Katib
//
//  Created by Omar Rayyan on 24/05/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.layer.cornerRadius = registerButton.frame.height/10
        registerButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        registerButton.layer.borderWidth = 2
        usernameField.layer.cornerRadius = usernameField.frame.height/2
        passwordField.layer.cornerRadius = passwordField.frame.height/2
        // Do any additional setup after loading the view.
    }


}

