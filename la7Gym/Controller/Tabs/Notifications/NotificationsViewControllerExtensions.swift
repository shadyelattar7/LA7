//
//  NotificationsViewControllerExtensions.swift
//  la7Gym
//
//  Created by Mohamed on 23/09/2021.
//

import Foundation
import UIKit

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTableView() {
        tableView.registerWithAutomaticHeight(NotificationTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNotifications.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as NotificationTableViewCell
        cell.selectionStyle = .none
        cell.setData(arrayNotifications[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
