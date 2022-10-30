//
//  UILabelExtension.swift
//  Safir El3rood
//
//  Created by mohamed elmaazy on 7/26/18.
//  Copyright © 2018 Internet Plus. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    var isTruncated: Bool {
        guard let labelText = text else {
            return false
        }
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font!],
            context: nil).size
        return labelTextSize.height > bounds.size.height
    }
    
    func stringFromHtml(htmlString: String) {
        let htmlData = NSString(string: htmlString).data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        self.attributedText = attributedString
    }
    
    func setStrikethrough(text: String) {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        
        self.attributedText = attributeString
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
    
    func setUnderLine() {
        guard let text = self.text else { return }
        let textRange = NSMakeRange(0, text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        // Add other attributes if needed
        self.attributedText = attributedText
    }
}
