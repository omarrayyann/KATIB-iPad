//
//  Extensions.swift
//  Katib
//
//  Created by Omar Rayyan on 24/05/2022.
//

import Foundation
import UIKit


extension UIView {
    func menuButtons(){
        self.layer.cornerRadius = self.frame.height/9
        self.layer.borderWidth = 2
        self.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
}


