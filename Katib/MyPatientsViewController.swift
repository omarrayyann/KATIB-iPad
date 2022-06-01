//
//  PatientsViewController.swift
//  Katib
//
//  Created by Omar Rayyan on 25/05/2022.
//

import UIKit
import Kingfisher

protocol PatientChoiceDelegate{
    func clicked_patient(patient: Patient)
}

class MyPatientsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, PatientChoiceDelegate {
    
    func clicked_patient(patient: Patient){
        if patient.firstName == "additionButton"{
            // clicked add patient
            
        }
        else{
        chosen_patient = patient
            performSegue(withIdentifier: "toPatient", sender: self)}
    }
    
    var patients: [Patient] = []
    var chosen_patient: Patient = Patient(firstName: "", lastName: "", age: 0, gender: "", uid: "", photo: "", doctor: Doctor(firstName: "", lastName: "", username: "", email: "", uid: "", photo: "", patientsUID: []))
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (patients.count + 1)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath.row < patients.count) {
            var patient = patients[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "patient", for: indexPath as IndexPath) as! PatientCollectionViewCell
            cell.patient = patient
            cell.nameLabel.text = "\(patient.firstName) \(patient.lastName)"
            cell.profilePhoto.kf.setImage(with: URL(string: patient.photo))
            cell.ageLabel.text = "\(patient.age) years old"
            cell.delegate = self
            return cell
            
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "patient", for: indexPath as IndexPath) as! PatientCollectionViewCell
            cell.patient.firstName = "additionButton"
            cell.wholeView.isHidden = true
            return cell
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        patients = Data.shared.patients
        collectionView.register(UINib(nibName: "PatientCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "patient" )
        let width = (windowWidth()-100)/4
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: 140)
        layout.headerReferenceSize = CGSize(width: 0, height: 20)
        layout.footerReferenceSize = CGSize(width: 0, height: 20)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPatient"{
            let destinationVC = segue.destination as! PatientViewController
            destinationVC.patient = chosen_patient
        }
    }

}
