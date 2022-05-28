//
//  CollectionViewCell.swift
//  Katib
//
//  Created by Omar Rayyan on 25/05/2022.
//

import UIKit

class PatientCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    
    var delegate: PatientChoiceDelegate!

    var patient = Patient(firstName: "", lastName: "ss", age: 0, gender: "", photo: #imageLiteral(resourceName: "Doctor"))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wholeView.layer.cornerRadius = 10
        wholeView.layer.borderWidth = 0.5
        wholeView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        emptyView.layer.cornerRadius = 10
        emptyView.layer.borderWidth = 0.5
        emptyView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        profilePhoto.layer.cornerRadius = 55/2
        profilePhoto.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        profilePhoto.layer.borderWidth = 0.5
        // Initialization code
    }

    @IBAction func clickedPatient(_ sender: Any) {
        delegate.clicked_patient(patient: patient)
    }
}

