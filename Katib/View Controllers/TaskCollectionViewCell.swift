//
//  CollectionViewCell.swift
//  Katib
//
//  Created by Omar Rayyan on 03/06/2022.
//

import UIKit

class TaskCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var wholeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wholeView.layer.cornerRadius = wholeView.frame.height/25
        wholeView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        wholeView.layer.borderWidth = 0.5

        // Initialization code
    }

}
