//
//  CustomButton.swift
//  Elshamy
//
//  Created by m3azy on 08/02/2021.
//

import Foundation
import UIKit
//import MOLH

class CustomButton: UIButton {
    
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
        if self.titleLabel?.textAlignment == .natural {
//            self.titleLabel!.textAlignment = MOLHLanguage.isArabic() ? .right : .left
        }
    }
    
    func setCustomFontFor() {
        if self.titleLabel != nil {
            self.titleLabel!.font = UIFont.init(name: GET_FONT_FAMILY_NAME(self.titleLabel!.font.fontName), size: self.titleLabel!.font.pointSize)
            self.titleLabel!.adjustsFontSizeToFitWidth = true
            self.titleLabel!.minimumScaleFactor = 0.2
        }
    }
    
    func disableResizeFont() {
        if self.titleLabel != nil {
            self.titleLabel!.adjustsFontSizeToFitWidth = false
        }
    }
}
