//
//  ProfilePictureViewController.swift
//  Katib
//
//  Created by Omar Rayyan on 28/05/2022.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import NVActivityIndicatorView
import Kingfisher

class ProfilePictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    let db = Firestore.firestore()
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    @IBOutlet weak var wholeFirstName: UIView!
    @IBOutlet weak var wholeLastName: UIView!
    @IBOutlet weak var lastNameShadow: UIView!
    @IBOutlet weak var firstNameShadow: UIView!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var profilePictureView: UIView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var addPictureButton: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadPrevious()
        indicator.startAnimating()
        indicator.isHidden = true
        profilePictureView.layer.cornerRadius = profilePictureView.frame.height/2
        profilePictureView.layer.borderWidth = 1
        profilePictureView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        skipButton.layer.cornerRadius = skipButton.frame.height/2
        profilePicture.layer.masksToBounds = true
        firstNameLabel.textField_custom_1()
        lastNameLabel.textField_custom_1()
        firstNameShadow.shadow_custom_1()
        lastNameShadow.shadow_custom_1()

        // Do any additional setup after loading the view.
    }
    

    func loadPrevious(){
        indicator.isHidden = false
        wholeView.isUserInteractionEnabled = false
        if let uid = Auth.auth().currentUser?.uid{
            db.collection("Doctors").document(uid).getDocument { snapshot, error in
                if let firstName = snapshot?.data()?["firstName"] as? String, let lastName = snapshot?.data()?["lastName"] as? String, let photoURL = snapshot?.data()?["profilePicture"] as? String {
                    self.firstNameLabel.text = firstName
                    self.lastNameLabel.text = lastName
                    self.profilePicture.kf.setImage(with: URL(string: photoURL))
                    self.indicator.isHidden = true
                    self.wholeView.isUserInteractionEnabled = true
                }
            }}
        else{
            indicator.isHidden = true
            wholeView.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func clickedAddPicture(_ sender: Any) {
        
        
        
        var alertStyle = UIAlertController.Style.actionSheet
        if (UIDevice.current.userInterfaceIdiom == .pad) {
          alertStyle = UIAlertController.Style.alert
        }
        let alert = UIAlertController(title: "Change Profile Picture", message: nil, preferredStyle: alertStyle)

       alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
           self.openCamera()
       }))

       alert.addAction(UIAlertAction(title: "Choose From Library", style: .default, handler: { _ in
           self.openGallery()
       }))

       alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

       present(alert, animated: true, completion: nil)
        
        
    }
        
    
    @IBOutlet var wholeView: UIView!
    
    @IBAction func clickedSkip(_ sender: Any) {
        // clicked save
        indicator.isHidden = false
        self.errorLabel.isHidden = true
        self.wholeView.isUserInteractionEnabled = false
        let photoIdString = NSUUID().uuidString
                   let firstPhotoID = photoIdString

        if firstNameLabel.text != "" && lastNameLabel.text != "" {
        if let firstPhotoUIimage = profilePicture.image, let firstPhotoData = profilePicture.image!.jpegData(compressionQuality: 0.2){

                   storageRef.child(firstPhotoID).putData(firstPhotoData, metadata: nil) { (metadata, error) in
                       if let e = error {
                           print(e)
                           self.wholeView.isUserInteractionEnabled = true
                           self.indicator.isHidden = true
                           self.errorLabel.isHidden = false
                           self.errorLabel.shake()
                           
                       }
                       else{
                         
                           self.storageRef.child(firstPhotoID).downloadURL { (url, error) in
                               print(url)
                               if let e = error {
                                   print(e)
                                   self.dismiss(animated: true, completion: nil)
                                   self.wholeView.isUserInteractionEnabled = true
                                   self.indicator.isHidden = true
                                   self.errorLabel.isHidden = false
                                   self.errorLabel.shake()
                              
                               }
                               else if let urlToFirstImage = url?.absoluteString {
                                   
                                   if let dotorUID = Auth.auth().currentUser?.uid {
                                       self.db.collection("Doctors").document(dotorUID).updateData(["profilePicture": urlToFirstImage, "firstName": self.firstNameLabel.text ?? "", "lastName": self.lastNameLabel.text ?? ""]) { error in
                                           if let e = error {
                                               print(e)
                                               self.wholeView.isUserInteractionEnabled = true
                                               self.indicator.isHidden = true
                                               self.errorLabel.isHidden = false
                                               self.errorLabel.shake()
                                           }
                                           else{
                                               // DONE
                                               print("DONE")
                                               self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                                           }
                                       }

                                   }
                                   
                                   
                               }
                                   
                                   
                                   
                               }
                            
                           }
                   }
                           
                           
                       }
                       
                       
                       
                       
               }
        else{
            self.wholeView.isUserInteractionEnabled = true
            self.indicator.isHidden = true
            self.errorLabel.isHidden = false
            self.errorLabel.shake()
        }
                   
              
                                    
        }
    
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery()
   {
       if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
           let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           imagePicker.allowsEditing = true
           imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
           self.present(imagePicker, animated: true, completion: nil)
       }
       else
       {
           let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
   }
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[.editedImage] as? UIImage {
                changedPic = true
                profilePicture.image = pickedImage.squared()
                
                picker.dismiss(animated: true, completion: nil)

           
        }
    }
    
    var changedPic = false
    
    let storageRef = Storage.storage().reference(forURL: "gs://katib-aba97.appspot.com").child("Profile-Pictures")

    
    private func squareImageFromImage(image: UIImage) -> UIImage{
        var maxSize = max(image.size.width,image.size.height)
        var squareSize = CGSize.init(width: maxSize, height: maxSize)

        var dx = (maxSize - image.size.width) / 2.0
        var dy = (maxSize - image.size.height) / 2.0
        UIGraphicsBeginImageContext(squareSize)
        var rect = CGRect.init(x: 0, y: 0, width: maxSize, height: maxSize)

        var context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(rect)

        rect = rect.insetBy(dx: dx, dy: dy)
        image.draw(in: rect, blendMode: CGBlendMode.normal, alpha: 1.0)
        var squareImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return squareImage!
    }
    
    
}
