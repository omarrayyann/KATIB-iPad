//
//  MainViewController.swift
//  Katib
//
//  Created by Omar Rayyan on 24/05/2022.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {


    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var welcomeMessage: UILabel!

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
