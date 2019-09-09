//
//  UIColorExtension.swift
//  Cash Caulculator
//
//  Created by Salamender Li on 3/9/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    static let backgroundColor = UIColor(red: 252/256, green: 237/256, blue: 108/256, alpha: 1)
    
    static let fillcolor = UIColor(red: 54/256, green: 54/256, blue: 51/256, alpha: 1)
    
    static let strokeColor = UIColor(red: 215/256, green: 215/256, blue: 165/256, alpha: 1)
    
    static let shapeLayerColor =  UIColor(red: 165/256, green: 119/256, blue: 75/256, alpha: 1)

}

extension UIView {
    
    // Example use: myView.addBorder(toSide: .Left, withColor: UIColor.redColor().CGColor, andThickness: 1.0)
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: UIColor, andThickness thickness: CGFloat) {
        
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        
        switch side {
        case .Left:
            border.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            border.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
            border.widthAnchor.constraint(equalToConstant: thickness).isActive = true
        case .Right:
            border.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            border.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            border.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
            border.widthAnchor.constraint(equalToConstant: thickness).isActive = true
        case .Top:
            border.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            border.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            border.heightAnchor.constraint(equalToConstant: thickness).isActive = true
            border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        case .Bottom:
            border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            border.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            border.heightAnchor.constraint(equalToConstant: thickness).isActive = true
            border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        }
        
    }
}

extension NSDate {
    
    convenience init(date:Date) {
        self.init(timeIntervalSinceReferenceDate:date.timeIntervalSinceReferenceDate)
    }
    
    func dateFormater() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let string = dateFormatter.string(from: Date(date: self))
        return string
    }
    
    func dateFormaterForName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-dd-yyyy-HH-mm-ss"
        let string = dateFormatter.string(from: Date(date: self))
        return string
    }
}

extension Date{
    init(date: NSDate) {
        self.init(timeIntervalSinceReferenceDate: date.timeIntervalSinceReferenceDate)
    }
}

extension UIViewController {
    
    func displayErrorMessage(title:String, message: String){
        let alertview = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertview.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:nil))
        self.present(alertview, animated: true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        
    }
    
    func getKeyboardHeight(notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
}
