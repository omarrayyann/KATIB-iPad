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
    
    func round(divideHeightBy: Double){
        self.layer.cornerRadius = self.frame.height/divideHeightBy
        self.layer.masksToBounds = true

    }
    
    func shadow_custom_1(){
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = false
        self.layer.shadowOpacity=0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-5.0, 5.0, -5.0, 5.0, -2.5, 2.5, -1.25, 1.25, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    

}

extension UITextField{
    func textField_custom_1(){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.height/2
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: self.frame.height))
        self.leftViewMode = .always

    }
    func left_text_field_indent(width: Double){

        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftViewMode = .always

    }
}

extension UIImage {
    
    
    func saveImage(topImage: UIImage) -> UIImage {
        let bottomImage = self
        let topImage = topImage

        let newSize = bottomImage.size
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)

        bottomImage.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: bottomImage.size))
        topImage.draw(in: CGRect(origin: CGPoint(x: 109, y: 287), size: CGSize(width: 1821, height: 1821)))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    

        var isPortrait:  Bool    { size.height > size.width }
        var isLandscape: Bool    { size.width > size.height }
        var breadth:     CGFloat { min(size.width, size.height) }
        var breadthSize: CGSize  { .init(width: breadth, height: breadth) }
        func squared(isOpaque: Bool = false) -> UIImage? {
            guard let cgImage = cgImage?
                .cropping(to: .init(origin: .init(x: isLandscape ? ((size.width-size.height)/2).rounded(.down) : 0,
                                                  y: isPortrait  ? ((size.height-size.width)/2).rounded(.down) : 0),
                                    size: breadthSize)) else { return nil }
            let format = imageRendererFormat
            format.opaque = isOpaque
            return UIGraphicsImageRenderer(size: breadthSize, format: format).image { _ in
                UIImage(cgImage: cgImage, scale: 1, orientation: imageOrientation)
                .draw(in: .init(origin: .zero, size: breadthSize))
            }
        }
    
    
    

  

}

extension Date {
        func timeAgoDisplay() -> String {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            return formatter.localizedString(for: self, relativeTo: Date())
        }
   }


extension UIViewController {
    func windowHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }

    func windowWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func isValidEmail(_ email: String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

           let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailPred.evaluate(with: email)
       }

}


extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
