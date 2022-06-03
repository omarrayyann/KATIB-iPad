//
//  AddPatientOptionsViewController.swift
//  Katib
//
//  Created by Omar Rayyan on 01/06/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import NVActivityIndicatorView
import MessageUI

class AddPatientOptionsViewController: UIViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate {
  
    

    @IBOutlet var wholeView: UIView!

    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    let db = Firestore.firestore()

    var delegateRefresh: refreshingDelegate?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameLabel.delegate = self
        lastNameLabel.delegate = self
        emailLabel.delegate = self
        self.preferredContentSize = CGSize(width: 400, height: 150)
        indicator.startAnimating()
        indicator.isHidden = true
        firstNameLabel.left_text_field_indent(width: 10)
        lastNameLabel.left_text_field_indent(width: 10)
        emailLabel.left_text_field_indent(width: 10)



        // Do any additional setup after loading the view.
    }
    

    var didWork = true
    
    @IBAction func clickedCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
 
    
 
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField{
        case firstNameLabel:
        if string != "" && lastNameLabel.text != "" && emailLabel.text != "" {
            addButton.isEnabled = true
        }
        else{
            addButton.isEnabled = false
        }
            return true
            break
        case lastNameLabel:
        if string != "" && firstNameLabel.text != "" && emailLabel.text != "" {
            addButton.isEnabled = true
        }
        else{
            addButton.isEnabled = false
        }
            return true
            break
        case emailLabel:
        if string != "" && lastNameLabel.text != "" && firstNameLabel.text != "" {
            addButton.isEnabled = true
        }
        else{
            addButton.isEnabled = false
        }
            return true
            break
            
        default:
            return true
            break
            
        }
    }
    
    @IBAction func clickedSendInvitation(_ sender: Any) {
        errorLabel.isHidden = true

        if Auth.auth().currentUser?.uid != nil {
        if emailLabel.text != "" {
            
        let len = 8
        let pswdChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@"
        let rndPswd = String((0..<len).compactMap{ _ in pswdChars.randomElement() })
        var generatedUsername = ""
        var generatedPassword = rndPswd
        
            if let index = emailLabel.text!.firstIndex(of: "@") {
                generatedUsername = String(emailLabel.text!.prefix(upTo: index))
        }
            
            if !didWork {
                generatedUsername = generatedUsername + String(Int.random(in: 0..<100))

            }
        
        
        view.endEditing(true)
        wholeView.isUserInteractionEnabled = false
        indicator.isHidden = false

        errorLabel.isHidden = true
        
            
            var bob = 0
            let arrayed = Array(String(generatedUsername))
                
            for array in arrayed {
                if array != "a" && array != "b" && array != "c" && array != "d" && array != "e" && array != "f" && array != "g" && array != "h" && array != "i" && array != "j" && array != "k" && array != "l" && array != "m" && array != "n" && array != "o" && array != "p" && array != "q" && array != "r" && array != "s" && array != "t" && array != "u" && array != "v" && array != "w" && array != "x" && array != "y" && array != "z" && array != "A" && array != "B" && array != "C" && array != "D" && array != "E" && array != "F" && array != "G" && array != "H" && array != "I" && array != "J" && array != "K" && array != "L" && array != "M" && array != "N" && array != "O" && array != "P" && array != "Q" && array != "R" && array != "S" && array != "T" && array != "U" && array != "V" && array != "W" && array != "X" && array != "Y" && array != "X" && array != "0" && array != "1" && array != "2" && array != "3" && array != "4" && array != "5" && array != "6" && array != "7" && array != "8" && array != "9" && array != "." && array != "_"  {
                    bob = 1
                }
            }

            
            generatedPassword = generatedPassword.lowercased()
            emailLabel.text = emailLabel.text?.lowercased()
            
            
            var usernameOnlyLetters = generatedPassword
            usernameOnlyLetters = usernameOnlyLetters.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "_", with: "").replacingOccurrences(of: "0", with: "").replacingOccurrences(of: "1", with: "").replacingOccurrences(of: "2", with: "").replacingOccurrences(of: "3", with: "").replacingOccurrences(of: "4", with: "").replacingOccurrences(of: "5", with: "").replacingOccurrences(of: "6", with: "").replacingOccurrences(of: "7", with: "").replacingOccurrences(of: "8", with: "").replacingOccurrences(of: "9", with: "").replacingOccurrences(of: "0", with: "") ?? ""


            
            if bob == 1 {
                indicator.isHidden = true
                errorLabel.text = "Usernames can only have characters, numbers, dots and underscores"
                errorLabel.isHidden = false
                errorLabel.shake()
                wholeView.isUserInteractionEnabled = true
                
            }
            else if generatedPassword.contains(" ") == true {
                indicator.isHidden = true
                errorLabel.text = "Password can't contain spaces"
                errorLabel.isHidden = false
                errorLabel.shake()
                wholeView.isUserInteractionEnabled = true
            }
            else if isValidEmail(emailLabel.text ?? "") == false{
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
                    
                    if usernames?.contains(generatedUsername) == false
                    {
                        
                        db.collection("Emails").document("Emails").getDocument { [self] (snapshot, error) in
                             if let e = error {
                                 print(e)
                                 indicator.isHidden = true
                                 wholeView.isUserInteractionEnabled = true
                             }
                             else{
                                 
                                 let emails = snapshot?.data()!["emails"] as? [String]
                                 
                                 if emails?.contains(emailLabel.text ?? "zzxx") != true
                                 {
                                     
                                     insertNewUser(email: emailLabel.text ?? "", username: generatedUsername, firstName: firstNameLabel.text ?? "", lastName: lastNameLabel.text ?? "", doctorUID: Auth.auth().currentUser?.uid ?? "", generatedPassword: generatedPassword)
                            {(inserted) in
                                if inserted {
                                    // success
                                    Config.shared.refreshPatientsList = true
                                    print("Username: \(generatedUsername)\n Password: \(generatedPassword)")
                                    
                                    
                                    
                                        if MFMailComposeViewController.canSendMail() {
                                            let mail = MFMailComposeViewController()
                                            mail.mailComposeDelegate = self
                                            mail.setToRecipients([self.emailLabel.text!])
                                            mail.setSubject("KATIB Log-In Details")
                                            mail.setMessageBody("<h4>Dear \(self.firstNameLabel.text!.capitalizingFirstLetter()),</h4><h3>Below are your Log-in details for KATIB:</h4><h4>Username:  \(generatedUsername)</h4><h4>Password: \(generatedPassword)</h4><h4>Regards,</br> Dr. \(Data.shared.doctor.firstName.capitalizingFirstLetter()) \(Data.shared.doctor.lastName.capitalizingFirstLetter())</h4>", isHTML: true)

                                            present(mail, animated: true)
                                        } else {
                                            // show failure alert
                                        }
                                    

                                    
//                                    self.db.collection("mail").addDocument(data: [
//                                        "to": self.emailLabel.text ?? "",
//                                        "message": [
//                                          "subject": "Hello from Firebase",
//                                          "html": "Hello \(String(describing: self.firstNameLabel.text)), <br>Doctor \(Data.shared.doctor.firstName) have invited you to use Katib<br>Login Details:<br>Username: \(generatedUsername)<br>Password: \(generatedPassword)<br><br>Thanks!"
//                                        ]
//                                    ]) { err in
//                                        if let err = err {
//                                            print("Error writing document: \(err)")
//                                        } else {
//                                            print("Email successfully written!")
//                                        }}
                                    
                                    
                                    
                                    
                                    
                                        
                                        
                                    self.navigationController?.popToRootViewController(animated: true)
                                    return
                                }
                                else{
                                    return  }
                            }


                        }
                                 else{
                                     indicator.isHidden = true
                                     errorLabel.text = "Email used"
                                     errorLabel.isHidden = false
                                     errorLabel.shake()
                                     wholeView.isUserInteractionEnabled = true
                                 }
                             }
                    }
                     
                }
                    else{
                        didWork = false
                        clickedSendInvitation(self)
                    }
            
            
   
                }}
            
        }
                    
                    
                    
                    
                    
      
            
            
        }
            else{
                indicator.isHidden = true
                errorLabel.text = "Enter a valid email"
                errorLabel.isHidden = false
                errorLabel.shake()
                wholeView.isUserInteractionEnabled = true
            }
        }
        else{
            indicator.isHidden = true
            errorLabel.text = "Error Occured"
            errorLabel.isHidden = false
            errorLabel.shake()
            wholeView.isUserInteractionEnabled = true
        }
        
        
        
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            self.dismiss(animated: true) {
                self.delegateRefresh?.refresh_patients()
            }
        }
    }
    
    public func insertNewUser (email: String, username: String, firstName: String, lastName: String, doctorUID: String, generatedPassword: String, completion: @escaping (Bool) -> Void) {
        db.collection("Patients").document(email).setData(["username": username, "email": email, "firstName": firstName, "lastName": lastName, "profilePicture": "non", "doctorUID": doctorUID, "assignedTasks": [], "finishedTasks": [], "password": generatedPassword, "lastTimeActive": String(Date.now.timeIntervalSince1970)]) { err in
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
                               self.db.collection("Doctors").document(Auth.auth().currentUser?.uid ?? "").updateData(["patients": FieldValue.arrayUnion([email])]) { error  in
                                   if let e = error {
                                       print(e)
                                   }
                                   else{
                                       self.db.collection("Emails").document("Emails").updateData(["emails": FieldValue.arrayUnion([email])]) { (error) in
                                           if let e = error {
                                               print(e)
                                               
                                           }
                                           else{
                                       
                                       
                                               completion(true)}
                                           }
                                   }
                               }
                
                           }
                           }
                       }
                       
                       

                   }
               }
    
}
