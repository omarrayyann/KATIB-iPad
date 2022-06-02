//
//  Patient.swift
//  Katib
//
//  Created by Omar Rayyan on 25/05/2022.
//

import Foundation
import UIKit

struct Patient{
    var firstName: String
    var lastName: String
    var photo: String
    var doctor: Doctor
    var finishedTasks: [String]
    var assignedTasks: [String]
    var lastActive: Date 
    

}
