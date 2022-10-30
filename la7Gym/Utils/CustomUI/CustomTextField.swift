//
//  CustomTextField.swift
//  Elshamy
//
//  Created by m3azy on 08/02/2021.
//

import Foundation
import UIKit
//import MOLH

class CustomTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateAlignmentUI()
        setCustomFontFor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomFontFor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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

