//
//  LettersViewController.swift
//  Katib
//
//  Created by Omar Rayyan on 03/06/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Kingfisher
import NVActivityIndicatorView

class LettersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return letters.count
    }
    
    var patient = Patient(firstName: "", lastName: "", photo: "", doctor: Doctor(firstName: "", lastName: "", username: "", email: "", uid: "", photo: "", patientsUID: []), finishedTasks: [], assignedTasks: [], lastActive: Date.now)
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var currentLetter = letters[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "letterCell", for: indexPath) as! TaskCollectionViewCell
        cell.image.kf.setImage(with: URL(string: currentLetter.image))
        return cell
        
    }
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var letters: [Letter] = []
    let db = Firestore.firestore()
    var package = ""

    func loadLetters(){
    
        db.collection("Letters").document(package).getDocument { snapshot, error in
            if let e = error {
                print(e)
            }
            else{
                if let lettersMap = snapshot?.data()?["letters"] as? [[String:Any]] {
                    for letter in lettersMap {
                        var newLetter = Letter(name: letter["Name"] as! String, image: letter["Image"] as! String)
                        self.letters.append(newLetter)
                    }
                    self.indicator.isHidden = true
                    self.collectionView.reloadData()
                }
                    
            }
        }
        
    }
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = "Choose from the \(package) letters below to assign to patient"
        indicator.startAnimating()
        indicator.isHidden = false

        collectionView.dataSource = self
        collectionView.delegate = self
        loadLetters()
        
     
        collectionView.register(UINib(nibName: "TaskCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "letterCell" )
        
        
        let width = (windowWidth()-80)/9.5
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        layout.headerReferenceSize = CGSize(width: 0, height: 20)
        layout.footerReferenceSize = CGSize(width: 0, height: 20)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        
        
        
    }
    


}
