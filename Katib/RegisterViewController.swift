//
//  RegisterViewController.swift
//  Katib
//
//  Created by Omar Rayyan on 28/05/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import NVActivityIndicatorView

class RegisterViewController: UIViewController {

   
    
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailShadow: UIView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameShadow: UIView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordShadow: UIView!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordShadow: UIView!
    
    @IBOutlet var wholeView: UIView!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.startAnimating()
        indicator.isHidden = true
        emailShadow.shadow_custom_1()
        usernameShadow.shadow_custom_1()
        passwordShadow.shadow_custom_1()
        confirmPasswordShadow.shadow_custom_1()
        registerButton.shadow_custom_1()


        emailTextField.textField_custom_1()
        usernameTextField.textField_custom_1()
        passwordTextField.textField_custom_1()
        confirmPasswordTextField.textField_custom_1()

        
        // Do any additional setup after loading the view.
    }
    
   
    
    
    let db = Firestore.firestore()
    
    @IBAction func login(_ sender: Any) {
        self.dismiss(animated: true)
    }
   
    @IBOutlet weak var errorLabel: UILabel!
    func isValidEmail(_ email: String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

           let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailPred.evaluate(with: email)
       }

       @IBAction func registerPressed(_ sender: Any) {

           view.endEditing(true)
           wholeView.isUserInteractionEnabled = false
           indicator.isHidden = false

           errorLabel.isHidden = true
           if emailTextField.text != "" && usernameTextField.text != ""  && passwordTextField.text != "" && confirmPasswordTextField.text != ""
           {
               
               var bob = 0
               let arrayed = Array(String(usernameTextField.text!))
               
               for array in arrayed {
                   if array != "a" && array != "b" && array != "c" && array != "d" && array != "e" && array != "f" && array != "g" && array != "h" && array != "i" && array != "j" && array != "k" && array != "l" && array != "m" && array != "n" && array != "o" && array != "p" && array != "q" && array != "r" && array != "s" && array != "t" && array != "u" && array != "v" && array != "w" && array != "x" && array != "y" && array != "z" && array != "A" && array != "B" && array != "C" && array != "D" && array != "E" && array != "F" && array != "G" && array != "H" && array != "I" && array != "J" && array != "K" && array != "L" && array != "M" && array != "N" && array != "O" && array != "P" && array != "Q" && array != "R" && array != "S" && array != "T" && array != "U" && array != "V" && array != "W" && array != "X" && array != "Y" && array != "X" && array != "0" && array != "1" && array != "2" && array != "3" && array != "4" && array != "5" && array != "6" && array != "7" && array != "8" && array != "9" && array != "." && array != "_"  {
                       bob = 1
                   }
               }

               
               usernameTextField.text = usernameTextField.text?.lowercased()
               emailTextField.text = emailTextField.text?.lowercased()
               
               
               var usernameOnlyLetters = usernameTextField.text
               usernameOnlyLetters = usernameOnlyLetters?.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "_", with: "").replacingOccurrences(of: "0", with: "").replacingOccurrences(of: "1", with: "").replacingOccurrences(of: "2", with: "").replacingOccurrences(of: "3", with: "").replacingOccurrences(of: "4", with: "").replacingOccurrences(of: "5", with: "").replacingOccurrences(of: "6", with: "").replacingOccurrences(of: "7", with: "").replacingOccurrences(of: "8", with: "").replacingOccurrences(of: "9", with: "").replacingOccurrences(of: "0", with: "")


               
               if bob == 1 {
                   indicator.isHidden = true
                   errorLabel.text = "Usernames can only have characters, numbers, dots and underscores"
                   errorLabel.isHidden = false
                   errorLabel.shake()
                   wholeView.isUserInteractionEnabled = true
                   
               }
               
               else if usernameTextField.text?.contains(" ") == true {
                   indicator.isHidden = true
                   errorLabel.text = "Username can't contain spaces"
                   errorLabel.isHidden = false
                   errorLabel.shake()
                   wholeView.isUserInteractionEnabled = true
               }
               else if usernameTextField.text!.count < 4 {
                   indicator.isHidden = true
                   errorLabel.text = "Username must be at least 4 characters"
                   errorLabel.isHidden = false
                   errorLabel.shake()
                   wholeView.isUserInteractionEnabled = true
                   
               }
               else if usernameTextField.text!.count > 25 {
                   indicator.isHidden = true
                   errorLabel.text = "Username must be less than 25 characters"
                   errorLabel.isHidden = false
                   errorLabel.shake()
                   wholeView.isUserInteractionEnabled = true
                   
               }
               else if passwordTextField.text?.contains(" ") == true {
                   indicator.isHidden = true
                   errorLabel.text = "Password can't contain spaces"
                   errorLabel.isHidden = false
                   errorLabel.shake()
                   wholeView.isUserInteractionEnabled = true
               }
               else if confirmPasswordTextField.text != confirmPasswordTextField.text {
                   indicator.isHidden = true
                   errorLabel.text = "Password don't match"
                   errorLabel.isHidden = false
                   errorLabel.shake()
                   wholeView.isUserInteractionEnabled = true
               }
               else if isValidEmail(emailTextField.text ?? "") == false{
                   indicator.isHidden = true
                   errorLabel.text = "Enter a valid email"
                   errorLabel.isHidden = false
                   errorLabel.shake()
                   wholeView.isUserInteractionEnabled = true
               }
               
              else {db.collection("Usernames").document("Usernames").getDocument { [self] (snapshot, error) in
                   if let e = error {
                       print(e)
                       indicator.isHidden = true
                       wholeView.isUserInteractionEnabled = true
                   }
                   else{
                       
                       let usernames = snapshot?.data()!["usernames"] as? [String]
                       
                       if usernames?.contains(usernameTextField.text!) == false {Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { [self] (authResult, error) in
                           if let e = error {
                               if e.localizedDescription.contains("email address is already") == true {
                                   indicator.isHidden = true
                                   errorLabel.isHidden = false
                                   errorLabel.text = "Email Used"
                                   errorLabel.shake()
                                   wholeView.isUserInteractionEnabled = true

                               }
                               else{
                                   indicator.isHidden = true
                                   errorLabel.isHidden = false
                                   errorLabel.text = "Enter a valid password of at least 6 characters"
                                   errorLabel.shake()
                                   wholeView.isUserInteractionEnabled = true
                               }
                               print(e.localizedDescription)
                               
                           }
                           else{
                               
                               
                               
                               
                               
                               insertNewUser(email: emailTextField.text!, username: usernameTextField.text!, UID: authResult!.user.uid, firstName: "", lastName: "")
                               {(inserted) in
                                   if inserted {
                                       // success
                                       performSegue(withIdentifier: "toPicture", sender: self)

                                       return
                                   }
                                   else{
                                       return  }
                               }


                           }
                           
                           }}
                       else{
                           indicator.isHidden = true
                           errorLabel.isHidden = false
                           errorLabel.text = "Username Used"
                           errorLabel.shake()
                           wholeView.isUserInteractionEnabled = true

                       }
                   }
               }}
               
               
               
               
              
               
               
               
           }
           else {
               if emailTextField.text == "" {
                   indicator.isHidden = true
                   errorLabel.text = "Enter an email"
                   errorLabel.isHidden = false
                   errorLabel.shake()
                   wholeView.isUserInteractionEnabled = true

               }
               else if usernameTextField.text == "" {
                   indicator.isHidden = true
                   errorLabel.text = "Enter a username"
                   errorLabel.isHidden = false
                   errorLabel.shake()
                   wholeView.isUserInteractionEnabled = true

               }
               else if passwordTextField.text == "" {
                   indicator.isHidden = true
                   errorLabel.text = "Enter a password"
                   errorLabel.isHidden = false
                   errorLabel.shake()
                   wholeView.isUserInteractionEnabled = true


               }

           }
           
       }
       
       
    public func insertNewUser (email: String, username: String, UID: String, firstName: String, lastName: String, completion: @escaping (Bool) -> Void) {
        db.collection("Doctors").document(UID).setData(["username": username, "email": email, "uid": UID, "firstName": firstName, "lastName": lastName, "profilePicture": "non", "patients": []]) { err in
                   if let err = err {
                       print("Error writing document: \(err)")
                       completion(false)

                   } else {
                       print("Document successfully written!")
                       self.db.collection("Usernames").document("Usernames").updateData(["usernames": FieldValue.arrayUnion([username])]) { (error) in
                           if let e = error {
                               print(e)
                               
                           }
                           else{
                               completion(true)
                           
                           }
                           }
                       }
                       
                       

                   }
               }

               
       
       }
       
