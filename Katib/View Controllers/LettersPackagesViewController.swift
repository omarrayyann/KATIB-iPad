//
//  LettersPackagesViewController.swift
//  Katib
//
//  Created by Omar Rayyan on 03/06/2022.
//

import UIKit

class LettersPackagesViewController: UIViewController {

    
    @IBOutlet weak var arabicLettersView: UIView!
    @IBOutlet weak var englishLettersView: UIView!
    @IBOutlet weak var customLettersView: UIView!

    
    var patient = Patient(firstName: "", lastName: "", photo: "", doctor: Doctor(firstName: "", lastName: "", username: "", email: "", uid: "", photo: "", patientsUID: []), finishedTasks: [], assignedTasks: [], lastActive: Date.now)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arabicLettersView.round(divideHeightBy: 20)
        englishLettersView.round(divideHeightBy: 20)
        customLettersView.round(divideHeightBy: 20)

        // Do any additional setup after loading the view.
    }
    

    @IBAction func clickedArabicLetters(_ sender: Any) {
        packageClicked = "Arabic"
        performSegue(withIdentifier: "toLetters", sender: self)
    }

    @IBAction func clickedEnglishLetters(_ sender: Any) {
        packageClicked = "English"
        performSegue(withIdentifier: "toLetters", sender: self)
    }
    
    @IBAction func clickedCustomLetters(_ sender: Any) {
        packageClicked = "English"
        performSegue(withIdentifier: "toLetters", sender: self)
    }
    
    
    
    var packageClicked = ""
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLetters" {
            let destinationVC = segue.destination as! LettersViewController
            
            destinationVC.package = packageClicked
            
            destinationVC.patient = patient
            
        }
    }
  
}
