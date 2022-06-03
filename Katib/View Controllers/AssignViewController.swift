//
//  AssignViewController.swift
//  Katib
//
//  Created by Omar Rayyan on 03/06/2022.
//

import UIKit

class AssignViewController: UIViewController {
    
    @IBOutlet weak var collectingView: UIView!
    
    @IBOutlet weak var mazeView: UIView!
    
    @IBOutlet weak var lettersView: UIView!
    
    @IBOutlet weak var wordsView: UIView!
    
    
    
    
    var tasks = ["Collecting Items", "Maze", "Tracing Letters", "Writing Words", "Custom Tracing"]

    var patient: Patient = Patient(firstName: "", lastName: "", photo: "", doctor: Doctor(firstName: "", lastName: "", username: "", email: "", uid: "", photo: "", patientsUID: []), finishedTasks: [], assignedTasks: [], lastActive: Date.now)
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectingView.round(divideHeightBy: 10)
        mazeView.round(divideHeightBy: 10)
        wordsView.round(divideHeightBy: 10)
        lettersView.round(divideHeightBy: 10)
     
        // Do any additional setup after loading the view.
    }
    

    @IBAction func clickedLettersTask(_ sender: Any) {
        performSegue(withIdentifier: "toLettersPackage", sender: self)
    }
    
    var clickedTask = ""
    
    @IBAction func clickedTask(_ sender: UIButton) {
        clickedTask = sender.currentTitle ?? ""
        performSegue(withIdentifier: "toTask", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLettersPackage" {
            let destinationVC = segue.destination as! LettersPackagesViewController
            destinationVC.patient = patient
        }
    }
    

}
