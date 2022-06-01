//
//  MainViewController.swift
//  Katib
//
//  Created by Omar Rayyan on 24/05/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Kingfisher

class MainViewController: UIViewController {


    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var welcomeMessage: UILabel!

    let db = Firestore.firestore()
    var doctor: Doctor?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        fetchDoctorData()
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
            
        profilePicture.layer.borderWidth = 1
        profilePicture.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        profilePicture.layer.masksToBounds = true
        
        if (Auth.auth().currentUser?.uid) != nil {
  
        }
        
        else{
            
            performSegue(withIdentifier: "toSign", sender: self)
            
        }
        
        // Do any additional setup after loading the view.
    }
    

    func fetchDoctorData() {
        
        if Data.shared.fetchedData {
            self.welcomeMessage.text = "Hello Dr. \(self.doctor?.firstName.capitalizingFirstLetter() ?? "")"
            self.profilePicture.kf.setImage(with: URL(string: self.doctor?.photo ?? ""))
        }
        else{
        if let doctorUID = Auth.auth().currentUser?.uid {
            db.collection("Doctors").document(doctorUID).getDocument { snapshot, error in
                if let e = error {
                    print(e)
                    
                }
                else{
                    if let firstName = snapshot?.data()?["firstName"] as? String, let lastName = snapshot?.data()?["lastName"] as? String, let email = snapshot?.data()?["email"] as? String, let username = snapshot?.data()?["username"] as? String, let profilePicture = snapshot?.data()?["profilePicture"] as? String, let patientsArray = snapshot?.data()?["patients"] as? [String], let uid = snapshot?.data()?["uid"] as? String  {
                        self.doctor = Doctor(firstName: firstName, lastName: lastName, username: username, email: email, uid: uid, photo: profilePicture, patientsUID: patientsArray)
                        Data.shared.doctor = self.doctor!
                        Data.shared.fetchedData = true
                        print("sucess fetching data")
                        self.welcomeMessage.text = "Hello Dr. \(self.doctor?.firstName.capitalizingFirstLetter() ?? "")"
                        self.profilePicture.kf.setImage(with: URL(string: self.doctor?.photo ?? ""))
                    }

                }
            }
        }
        else{
            print("Not signed in error")
        
        }}
    }

}
