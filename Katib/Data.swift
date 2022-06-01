
import Foundation
import FirebaseFirestore
import FirebaseAuth

class Data {
    
    static let shared = Data()
    let db = Firestore.firestore()
    var fetchedData = false
    var patients: [String] = []
    var doctor: Doctor = Doctor(firstName: "", lastName: "", username: "", email: "", uid: "", photo: "", patientsUID: [])
  
    
}
