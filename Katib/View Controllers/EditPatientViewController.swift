//
//  EditPatientViewController.swift
//  Katib
//
//  Created by Omar Rayyan on 31/05/2022.
//

import UIKit

class EditPatientViewController: UIViewController {

    @IBOutlet weak var removePatientButton: UIButton!
    @IBOutlet weak var loginDetailsButon: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removePatientButton.shadow_custom_1()
        loginDetailsButon.shadow_custom_1()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func clickedDone(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
