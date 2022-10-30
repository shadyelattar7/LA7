//
//  UITableViewExtensions.swift
//  KiddowzNursery
//
//  Created by Mohamed Elmaazy on 3/16/20.
//  Copyright © 2020 Mohamed Hossam Khedr. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func register(_ nibName: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: nibName)
    }
    
    func registerWithAutomaticHeight(_ nibName: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: nibName)
        self.rowHeight = UITableView.automaticDimension
    }

    func register(_ cell: UITableViewCell.Type) {
        let nibName = String(describing: cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    func registerWithAutomaticHeight(_ cell: UITableViewCell.Type) {
        let nibName = String(describing: cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        self.rowHeight = UITableView.automaticDimension
    }
    
    func dequeue<Cell: UITableViewCell>() -> Cell {
        let nibName = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: nibName) as? Cell else {
            fatalError("Error in cell")
        }
        return cell
    }
}
