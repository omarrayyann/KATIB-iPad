//
//  Data.swift
//  Katib
//
//  Created by Omar Rayyan on 26/05/2022.
//

import Foundation


class Data {
    
    static let shared = Data()

    var patients = [Patient(firstName: "Dhiyaa", lastName: "Al-Jorf", age: 18, gender: "Male", photo: #imageLiteral(resourceName: "Dhiyaa")), Patient(firstName: "Omar", lastName: "Rayyan", age: 19, gender: "Male", photo: #imageLiteral(resourceName: "Omar")), Patient(firstName: "Samia", lastName: "Raed", age: 11, gender: "Female", photo: #imageLiteral(resourceName: "Girl")), Patient(firstName: "Saed", lastName: "Fakhry", age: 12, gender: "Male", photo: #imageLiteral(resourceName: "Boy2")), Patient(firstName: "Ivan", lastName: "Toni", age: 13, gender: "Male", photo: #imageLiteral(resourceName: "Boy")), Patient(firstName: "Jim", lastName: "Lanez", age: 32, gender: "Male", photo: #imageLiteral(resourceName: "Jim"))]
}
