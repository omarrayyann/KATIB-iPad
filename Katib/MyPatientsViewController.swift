//
//  PatientsViewController.swift
//  Katib
//
//  Created by Omar Rayyan on 25/05/2022.
//

import UIKit
import Kingfisher
import FirebaseFirestore
import FirebaseAuth

protocol PatientChoiceDelegate{
    func clicked_patient(patient: Patient)
}


protocol refreshingDelegate{
    func refresh_patients()
}



class MyPatientsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, PatientChoiceDelegate, refreshingDelegate {
    
    func refresh_patients() {
        loadPatients()
    }
    
    @IBOutlet weak var addPatientsButton: UIButton!
    private let refreshControl = UIRefreshControl()
    
    func clicked_patient(patient: Patient){
        if patient.firstName == "additionButton"{
            // clicked add patient
            performSegue(withIdentifier: "toAddPatient", sender: self)
        }
        else{
        chosen_patient = patient
            performSegue(withIdentifier: "toPatient", sender: self)}
    }
    
    var patients: [Patient] = []
    var chosen_patient: Patient = Patient(firstName: "", lastName: "", photo: "", doctor: Doctor(firstName: "", lastName: "", username: "", email: "", uid: "", photo: "", patientsUID: []), finishedTasks: [], assignedTasks: [], lastActive: Date.now)
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.patients.count + 1)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath.row < patients.count) {
            var patient = patients[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "patient", for: indexPath as IndexPath) as! PatientCollectionViewCell
            cell.patient = patient
            cell.nameLabel.text = "\(patient.firstName) \(patient.lastName)"
            if patient.photo=="" || patient.photo=="non"{
                cell.profilePhoto.image = UIImage(named: "default")
            }
            else{
                cell.profilePhoto.kf.setImage(with: URL(string: patient.photo))}
            cell.lastActiveLabel.text = "Last Active: \(patient.lastActive.timeAgoDisplay())"
            cell.delegate = self
            cell.wholeView.isHidden = false
            return cell
            
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "patient", for: indexPath as IndexPath) as! PatientCollectionViewCell
            cell.patient.firstName = "additionButton"
            cell.wholeView.isHidden = true
            cell.delegate = self
            return cell
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    let db = Firestore.firestore()
    
    func loadPatients(){
        patients = []
        if let uidDoctor = Auth.auth().currentUser?.uid{
            db.collection("Doctors").document(uidDoctor).getDocument { snapshot, error in
                if let e = error {
                    print(e)
                }
                else{
                    if let patientsData = snapshot?.data()?["patients"] as? [String] {
                        if patientsData.count == 0{
                            self.collectionView.isHidden = true
                            self.addPatientsButton.isHidden = false
                        }
                        for patient in patientsData {
                            self.addPatientsButton.isHidden = true
                            self.collectionView.isHidden = false
                            self.db.collection("Patients").document(patient).getDocument { snapshotPatient, error in
                                if let e = error {
                                    print(e)
                                }
                                else{
                                    if let patientFirstName = snapshotPatient?.data()?["firstName"] as? String, let patientLastName = snapshotPatient?.data()?["lastName"] as? String, let patientUsername = snapshotPatient?.data()?["username"] as? String, let email = snapshotPatient?.data()?["email"] as? String, let assignedTasks = snapshotPatient?.data()?["assignedTasks"] as? [String], let finishedTasks = snapshotPatient?.data()?["finishedTasks"] as? [String], let patientPhoto = snapshotPatient?.data()?["profilePicture"] as? String , let doctorUID = snapshotPatient?.data()?["doctorUID"] as? String, let lastTimeActive = snapshotPatient?.data()?["lastTimeActive"] as? String  {
                                        print("here")
                                        
                                        self.patients.append(Patient(firstName: patientFirstName, lastName: patientLastName, photo: patientPhoto, doctor: Data.shared.doctor, finishedTasks: finishedTasks, assignedTasks: assignedTasks, lastActive: Date(timeIntervalSince1970: Double(lastTimeActive) ?? 0)))
                                        if self.patients.count == patientsData.count {
                                            self.collectionView.reloadData()
                                            print("Done")
                                            self.refreshControl.endRefreshing()
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            
        }
            
            
            
    }
    
    
    @objc private func refreshFeed(_ sender: Any) {
            // Fetch Weather Data
            loadPatients()
        }
    
    @IBAction func addPatientsClicked(_ sender: Any) {
        performSegue(withIdentifier: "toAddPatient", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPatients()
        collectionView.refreshControl = refreshControl
        refreshControl.tintColor = UIColor(named: "OtherColor")
        refreshControl.addTarget(self, action: #selector(refreshFeed(_:)), for: .valueChanged)
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
        if segue.identifier == "toAddPatient"{
            let nav = segue.destination as! UINavigationController
            let destinationVC = nav.viewControllers.first as! AddPatientOptionsViewController
            destinationVC.delegateRefresh = self

        }
    }

}
