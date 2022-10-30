//
//  CustomImageView.swift
//  Elshamy
//
//  Created by m3azy on 08/02/2021.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    
    override func awakeFromNib() {
        self.image = self.image?.imageFlippedForRightToLeftLayoutDirection()
        self.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
