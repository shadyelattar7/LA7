//
//  CustomLabel.swift
//  Elshamy
//
//  Created by m3azy on 08/02/2021.
//

import Foundation
import UIKit
//import MOLH

class CustomLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        updateAlignmentUI()
//        setCustomFontFor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setCustomFontFor()
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
        self.font = UIFont.init(name: GET_FONT_FAMILY_NAME(self.font.fontName), size: self.font.pointSize)
        print("fontSize: \(self.font.pointSize) withText: \(self.text!) andName: \(GET_FONT_FAMILY_NAME(self.font.fontName))")
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.2
    }
    
    func disableResizeFont() {
        self.adjustsFontSizeToFitWidth = false
    }
}
