//
//  UIViewExtension.swift
//  Pharmacist
//
//  Created by mohamed elmaazy on 7/9/18.
//  Copyright © 2018 Ahmed gamal. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func setBorder(color:UIColor, radius:CGFloat, borderWidth:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func shakeWithError(color:UIColor, radius:CGFloat) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
        
        self.setBorder(color: .red, radius: radius, borderWidth: 1)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.setBorder(color: color, radius: radius , borderWidth: 1)
        }
    }
    
    func pop() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.5
        animation.duration = 0.2
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
        animation.repeatCount = 1
        self.layer.add(animation, forKey: "pulsing")
    }
    
    func moveView(end: CGPoint, duration:Double) {
        let path = UIBezierPath()
        path.move(to: self.center)
        path.addLine(to: end)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.duration = duration
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        self.layer.add(animation, forKey: nil)
    }
    
    func makeShadow(color:UIColor, alpha:Float, radius:CGFloat){
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = alpha
//        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = radius
        
        layer.shadowOffset = CGSize(width: 0, height: radius * UIScreen.main.bounds.width / 360)
        
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func roundCorners(_ radius: CGFloat){
        layer.cornerRadius = radius
    }
    
    func fadeIn(_ duration: TimeInterval = 2.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: nil)  }
    
    func fadeOut(_ duration: TimeInterval = 2.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
    func scaleOut (duration: TimeInterval = 0.8 , AffineTransform : CGAffineTransform = CGAffineTransform.identity) {
        UIView.animate(withDuration: duration,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
                        UIView.animate(withDuration: duration) {
                        self.transform = AffineTransform
                        }
        })
    }
    
    func maximize(duration: TimeInterval = 0.8 , AffineTransform : CGAffineTransform = CGAffineTransform.identity) {
        self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: duration) {
            self.transform = AffineTransform
        }
    }
    
    func minimize(duration: TimeInterval = 0.8 , AffineTransform : CGAffineTransform = CGAffineTransform.identity) {
        self.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
        UIView.animate(withDuration: duration) {
            self.transform = AffineTransform
        }
    }
    
    func moveUp(duration: TimeInterval = 0.5, distance: CGFloat = 5.0) {
        UIView.animate(withDuration: duration, animations: {
            self.frame.origin.y -= distance
        }, completion: nil)

    }
    
    func moveDown(duration: TimeInterval = 0.5, distance: CGFloat = 5.0) {
        UIView.animate(withDuration: duration, animations: {
            self.frame.origin.y += distance
        }, completion: nil)
        
    }
    
    func up(duration: TimeInterval = 0.5, distance: CGFloat = 5.0) {
        self.transform = CGAffineTransform(translationX: self.frame.origin.x, y: +distance)
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform.identity
        }
    }
    
    func down(duration: TimeInterval = 0.5, distance: CGFloat = 5.0) {
        self.transform = CGAffineTransform(translationX: self.frame.origin.x, y: -distance)
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform.identity
        }
    }
    
    func rotate(duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform(rotationAngle: 360)
            self.layoutIfNeeded()
            

        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    class func initFromNib<T: UIView>() -> T {
            return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
        }
    }



