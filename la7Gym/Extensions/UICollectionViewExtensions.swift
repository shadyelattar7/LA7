//
//  UICollectionViewExtensions.swift
//  KiddowzNursery
//
//  Created by Mohamed Elmaazy on 3/12/20.
//  Copyright © 2020 Mohamed Hossam Khedr. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func register(_ nibName: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: nibName)
    }
}
