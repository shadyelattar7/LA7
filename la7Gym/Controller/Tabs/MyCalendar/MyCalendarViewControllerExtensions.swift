//
//  MyCalendarViewControllerExtensions.swift
//  la7Gym
//
//  Created by Mohamed on 16/09/2021.
//

import Foundation
import UIKit
import FSCalendar

extension MyCalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTableView() {
        tableView.register(MyCalendarTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayClasses.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as MyCalendarTableViewCell
        cell.selectionStyle = .none
        cell.setData(arrayClasses[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MyCalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        if UserDefaults.standard.getDatabaseToken() != "" {
            getData()
        }
    }

    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}
