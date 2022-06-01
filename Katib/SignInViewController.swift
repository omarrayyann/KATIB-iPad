//
//  ViewController.swift
//  Katib
//
//  Created by Omar Rayyan on 24/05/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import NVActivityIndicatorView

class SignInViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var passwordShadowView: UIView!
    @IBOutlet weak var usernameShadowView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet var wholeView: UIView!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        indicator.isHidden = true
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
    
    let db = Firestore.firestore()
  
    
    @IBAction func LogInPressed(_ sender: Any) {
      
           view.endEditing(true)
        indicator.isHidden = false
        if (usernameField.text != nil) && (passwordField.text != nil) {
            errorLabel.isHidden = true
            indicator.isHidden = false
            wholeView.isUserInteractionEnabled = false
               
            usernameField.text = usernameField.text?.lowercased()
               
               // if not email
               if (usernameField.text?.contains("@") == false){
                   
                   // tries using lebsi region
                   db.collection("Doctors").whereField("username", in: [usernameField.text]).getDocuments { (snapshot, error) in
                       if let e = error {
                           self.indicator.isHidden = true
                           self.errorLabel.text = "Error singing in"
                           self.errorLabel.isHidden = false
                           self.errorLabel.shake()
                           self.wholeView.isUserInteractionEnabled = true
                       }
                       else{
                           if snapshot?.documents.count != 0 {
                           let emailFromUsername = snapshot?.documents[0].data()["email"]
                           Auth.auth().signIn(withEmail: emailFromUsername! as! String, password: self.passwordField.text!) { (authResult, error) in
                               if let e = error {
                                   print(e)
                                 
                                   self.indicator.isHidden = true
                                   self.errorLabel.text = "Wrong Email/Password"
                                   self.errorLabel.isHidden = false
                                   self.errorLabel.shake()
                                   self.wholeView.isUserInteractionEnabled = true

                               }
                               else{
                                  // success log in
                                   print("success log in")

                                   self.indicator.isHidden = true
                                   // success
                                   UserDefaults.standard.setValue(true, forKey: "log")
                                   self.dismiss(animated: true)

                               }
                           }
                           
                       }
                           else{
                               self.indicator.isHidden = true
                               self.errorLabel.text = "Wrong Email/Password"
                               self.errorLabel.isHidden = false
                               self.errorLabel.shake()
                               self.wholeView.isUserInteractionEnabled = true
                               
                           }
                           }
                   }
               }
                   
               
               
               // USE EMAIL USE EMAIL
               
               
               else{
                   
                   // tries using lebsi region
                   db.collection("Doctor").whereField("email", in: [usernameField.text]).getDocuments { (snapshot, error) in
                       if let e = error {
                           self.indicator.isHidden = true
                           self.errorLabel.text = "Error singing in"
                           self.errorLabel.isHidden = false
                           self.errorLabel.shake()
                           self.wholeView.isUserInteractionEnabled = true
                       }
                       else{
                           if snapshot?.documents.count != 0 {
                               
                               Auth.auth().signIn(withEmail: self.usernameField.text!, password: self.passwordField.text!) { (authResult, error) in
                                   if let e = error {
                                       print(e)
                                     
                                       self.indicator.isHidden = true
                                       self.errorLabel.text = "Wrong Email/Password"
                                       self.errorLabel.isHidden = false
                                       self.errorLabel.shake()
                                       self.wholeView.isUserInteractionEnabled = true

                                   }
                                   else{
                                      // success log in
                                       print("success log in")

                                       self.indicator.isHidden = true
                                       // success
                                       UserDefaults.standard.setValue(true, forKey: "log")
                                       self.navigationController?.popToRootViewController(animated: true)

                                   }
                               }
                               
                               
                               }
                           }
                   }
               }
               
        }

         
           
       }
    
}



