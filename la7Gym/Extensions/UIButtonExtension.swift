//
//  UIButtonExtensio.swift
//  nasTrends
//
//  Created by Mohamed Elmaazy on 1/23/19.
//  Copyright © 2019 Mohamed Elmaazy. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func setUnderLine() {
        let text = self.titleLabel?.text ?? ""
        let attributedString = NSAttributedString(string: text, attributes:[NSAttributedString.Key.underlineStyle: 1.0 ])
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
