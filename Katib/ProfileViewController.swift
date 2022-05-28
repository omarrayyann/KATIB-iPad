//
//  ProfileViewController.swift
//  Katib
//
//  Created by Omar Rayyan on 28/05/2022.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var signOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func clickedSignOut(_ sender: Any) {
        print("clicked")
        logoutUser { Bool in
            if Bool == true {
                
                
                performSegue(withIdentifier: "toSign2", sender: self)
                
                
            }
        }

        
    }
    
    
       public func logoutUser(completion: (Bool) -> Void){
       
           do{
               try Auth.auth().signOut()
               completion(true)
               return
           }
           catch{
               print(error)
               completion(false)
               return
               
           }
           
           
           
       }
       


}
