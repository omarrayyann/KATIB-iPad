//
//  Patient.swift
//  Katib
//
//  Created by Omar Rayyan on 25/05/2022.
//

import Foundation
import UIKit

struct Doctor{
    var firstName: String
    var lastName: String
    var username: String
    var email: String
    var uid: String
    var photo: String
    var patientsUID: [String]
    var patients: [Patient] = []
}
