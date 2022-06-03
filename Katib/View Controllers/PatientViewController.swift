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
    @IBOutlet weak var lastActiveLabel: UILabel!
    
    @IBOutlet weak var currentlyAssignedTasks: UIView!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var performanceMessage: UILabel!
    @IBOutlet weak var assignTaskMessage: UILabel!
    @IBOutlet weak var assignTasksView: UIView!
    @IBOutlet weak var assignedHeight: NSLayoutConstraint!
    @IBOutlet weak var assignedTaskButton: UIButton!
    
    @IBOutlet weak var performanceTasksView: UIView!
    @IBOutlet weak var perfotrmanceHeight: NSLayoutConstraint!
    @IBOutlet weak var perfotrmanceButton: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editButton.round(divideHeightBy: 2)
        currentlyAssignedTasks.round(divideHeightBy: 20)
        assignTaskMessage.text = "Assigns tasks for \(patient.firstName.capitalizingFirstLetter()) to perform on KATIB"
        performanceMessage.text = "See how \(patient.firstName.capitalizingFirstLetter()) performed in previous tasks assigned"
        assignedHeight.constant = assignedTaskButton.frame.height*1.6
        assignTasksView.layer.cornerRadius = assignTasksView.frame.height/15
        assignTasksView.layer.masksToBounds = true
        bottomView.layer.cornerRadius = bottomView.frame.height/15
        perfotrmanceHeight.constant = perfotrmanceButton.frame.height*1.6
        performanceTasksView.layer.cornerRadius = performanceTasksView.frame.height/15
        performanceTasksView.layer.masksToBounds = true
        
//        profilePicture.image = patient.photo
        profilePicture.layer.borderWidth = 1
        profilePicture.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        profilePicture.layer.cornerRadius = profilePicture.frame.height / 2
        // This will change the navigation bar background color
        nameLabel.text = "\(patient.firstName) \(patient.lastName)"
        lastActiveLabel.text = "Last Active: \(patient.lastActive.timeAgoDisplay())"    
        
        
        
    }
    
    @IBAction func clickedAssignTasks(_ sender: Any) {
        performSegue(withIdentifier: "toAssign", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAssign"{
            let destinationVC = segue.destination as? AssignViewController
            destinationVC?.patient = patient
        }
    }
    
    @IBAction func clickedViewPerformance(_ sender: Any) {
    }
    
    
}
