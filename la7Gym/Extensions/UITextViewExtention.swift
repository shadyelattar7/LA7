//
//  UITextViewExtention.swift
//  IQRAA
//
//  Created by Admin on 3/7/19.
//  Copyright © 2019 internet plus. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    
    func setPaddingPoints(_ amount:CGFloat){
        self.contentInset = UIEdgeInsets(top: 5, left: amount, bottom: 5, right: amount)
    }
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
    func stringFromHtml(htmlString: String) {
        let htmlData = NSString(string: htmlString).data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        self.attributedText = attributedString
    }
    
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineHeightMultiple = lineHeight
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.count))
            self.attributedText = attributeString
            self.textAlignment = .right
        }
    }
    
    func setSpecificAttributes(texts: [String], fonts: [UIFont]?, colors: [UIColor]?) {
        var main = ""
        var ranges = [NSRange]()
        for sub in texts {
            main += sub
            ranges.append((main as NSString).range(of: sub))
        }
        let attribute = NSMutableAttributedString.init(string: main)
        
        if fonts != nil {
            for (i, font) in fonts!.enumerated() {
                attribute.addAttribute(NSAttributedString.Key.font, value: font, range: ranges[i])
            }
        }
        
        if colors != nil {
            for (i, color) in colors!.enumerated() {
                attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: ranges[i])
            }
        }
        self.attributedText = attribute
    }
}
