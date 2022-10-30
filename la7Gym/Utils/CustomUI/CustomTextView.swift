//
//  CustomTextView.swift
//  Elshamy
//
//  Created by m3azy on 08/02/2021.
//

import Foundation
import UIKit
//import MOLH

class CustomTextView: UITextView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateAlignmentUI()
        setCustomFontFor()
    }
    
    func updateAlignmentUI(){
        if self.textAlignment == .natural {
//            self.textAlignment = MOLHLanguage.isArabic() ? .right : .left
        }
    }
    
    func setCustomFontFor() {
        if self.font != nil {
            self.font = UIFont.init(name: GET_FONT_FAMILY_NAME(self.font!.fontName), size: self.font!.pointSize)
        }
    }
}

