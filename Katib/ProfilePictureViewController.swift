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

class ProfilePictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var addPictureButton: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        profilePicture.layer.borderWidth = 1
        profilePicture.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        addPictureButton.layer.cornerRadius = addPictureButton.frame.height/2
        skipButton.layer.cornerRadius = skipButton.frame.height/2

        

        // Do any additional setup after loading the view.
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
        
    
    
    @IBAction func clickedSkip(_ sender: Any) {
        // clicked save
        indicator.startAnimating()
        skipButton.isHidden = true
        let photoIdString = NSUUID().uuidString
                   let firstPhotoID = photoIdString

        if let firstPhotoUIimage = profilePicture.image, let firstPhotoData = profilePicture.image!.jpegData(compressionQuality: 0.2){

                   storageRef.child(firstPhotoID).putData(firstPhotoData, metadata: nil) { (metadata, error) in
                       if let e = error {
                           print(e)
                           self.indicator.stopAnimating()
                           self.skipButton.isHidden = false
                           
                       }
                       else{
                         
                           self.storageRef.child(firstPhotoID).downloadURL { (url, error) in
                               print(url)
                               if let e = error {
                                   print(e)
                                   self.dismiss(animated: true, completion: nil)
                                   self.indicator.stopAnimating()
                                   self.skipButton.isHidden = false
                              
                               }
                               else if let urlToFirstImage = url?.absoluteString {
                                   
                                   if let dotorUID = Auth.auth().currentUser?.uid {
                                       self.db.collection("Doctors").document(dotorUID).updateData(["profilePicture": urlToFirstImage]) { error in
                                           if let e = error {
                                               print(e)
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
