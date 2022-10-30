//
//  UITextFieldExtention.swift
//  Pharmacist
//
//  Created by Ahmed gamal on 7/18/18.
//  Copyright © 2018 Ahmed gamal. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    @objc func validateNumber() {
//        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.keyboardType = .asciiCapableNumberPad
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if self.text != "" {
            if self.isSecureTextEntry == true {
                self.text = validateNumberInPassword(str: textField.text!)
            } else {
                self.text = validateNumber(str: textField.text!)
            }
        }
    }
    
    func setPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setPaddingLeft(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func validateNumber(str: String) -> String {
        var dotCounter = 0
        var string = str
        string  = string.replacingOccurrences(of: ",", with: "")
        for s in string {
            if s == "٠" {
                string.removeLast()
                string.append("0")
            } else if s == "١" {
                string.removeLast()
                string.append("1")
            } else if s == "٢" {
                string.removeLast()
                string.append("2")
            } else if s == "٣" {
                string.removeLast()
                string.append("3")
            } else if s == "٤" {
                string.removeLast()
                string.append("4")
            } else if s == "٥" {
                string.removeLast()
                string.append("5")
            } else if s == "٦" {
                string.removeLast()
                string.append("6")
            } else if s == "٧" {
                string.removeLast()
                string.append("7")
            } else if s == "٨" {
                string.removeLast()
                string.append("8")
            } else if s == "٩" {
                string.removeLast()
                string.append("9")
            } else if s != "0" && s != "1" && s != "2" && s != "3" && s != "4" && s != "5" && s != "6" && s != "7" && s != "8" && s != "9" && s != "." {
                string.removeLast()
            } else if s == "." {
                dotCounter += 1
            }
        }
        
        if dotCounter > 1 {
            string.removeLast()
        }
        //  string = getNumberFormat(number: string)
        return string
    }
    
    func validateNumberInPassword(str: String) -> String {
        var string = str
        let s = string.last
        if s == "٠" {
            string.removeLast()
            string.append("0")
        } else if s == "١" {
            string.removeLast()
            string.append("1")
        } else if s == "٢" {
            string.removeLast()
            string.append("2")
        } else if s == "٣" {
            string.removeLast()
            string.append("3")
        } else if s == "٤" {
            string.removeLast()
            string.append("4")
        } else if s == "٥" {
            string.removeLast()
            string.append("5")
        } else if s == "٦" {
            string.removeLast()
            string.append("6")
        } else if s == "٧" {
            string.removeLast()
            string.append("7")
        } else if s == "٨" {
            string.removeLast()
            string.append("8")
        } else if s == "٩" {
            string.removeLast()
            string.append("9")
        }
        return string
    }
    
    func isValidEmail() -> Bool {
        let mailWithoutSpaces = self.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: mailWithoutSpaces)
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
