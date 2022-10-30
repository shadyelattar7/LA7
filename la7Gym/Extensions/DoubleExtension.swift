//
//  DoubleExtension.swift
//  FakahanySwift
//
//  Created by jimmy on 1/28/20.
//  Copyright © 2020 MiNi Mac. All rights reserved.
//

import Foundation

extension Double {
    
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
