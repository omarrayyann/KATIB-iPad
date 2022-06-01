//
//  PatientViewController.swift
//  Katib
//
//  Created by Omar Rayyan on 26/05/2022.
//

import UIKit

class PatientViewController: UIViewController {
    
    @IBOutlet weak var profilePicture: UIImageView!
    var patient: Patient!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        profilePicture.image = patient.photo
        profilePicture.layer.borderWidth = 1
        profilePicture.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        profilePicture.layer.cornerRadius = profilePicture.frame.height / 20
        // This will change the navigation bar background color
        nameLabel.text = "\(patient.firstName) \(patient.lastName)"
        ageLabel.text = "\(patient.age) years old"
        genderLabel.text = patient.gender
        
        
        
    }
    

   
    
}
