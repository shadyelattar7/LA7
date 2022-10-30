//
//  FreezingAccountViewControllerExtensions.swift
//  la7Gym
//
//  Created by Mohamed on 18/09/2021.
//

import Foundation
import FSCalendar

extension FreezingAccountViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // nothing selected:
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]
            print("datesRange contains: \(datesRange!)")
            labelDateRange.text = "Selected dates number = \(datesRange?.count ?? 0)"
            return
        }
        // only first date is selected:
        if firstDate != nil && lastDate == nil {
            // handle the case of if the last date is less than the first date:
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                print("datesRange contains: \(datesRange!)")
                labelDateRange.text = "Selected dates number = \(datesRange?.count ?? 0)"
                return
            }
            while firstDate! < date {
                firstDate = Calendar.current.date(byAdding: .day, value: 1, to: firstDate!)!
                calendar.select(firstDate)
                datesRange?.append(firstDate!)
            }
            firstDate = datesRange?.first
            lastDate = datesRange?.last

            
            print("datesRange contains: \(datesRange!)")
            labelDateRange.text = "Selected dates number = \(datesRange?.count ?? 0)"
            return
        }
        // both are selected:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            lastDate = nil
            firstDate = date
            datesRange = [firstDate!]
            calendar.select(firstDate)
            print("datesRange contains: \(datesRange!)")
        }
        labelDateRange.text = "Selected dates number = \(datesRange?.count ?? 0)"
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // both are selected:
        
        // NOTE: the is a REDUANDENT CODE:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            lastDate = nil
            firstDate = nil
            
            datesRange = []
            print("datesRange contains: \(datesRange!)")
            labelDateRange.text = "Selected dates number = \(datesRange?.count ?? 0)"
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
            
             //Remove timeStamp from date
             if date.removeTimeStamp!.compare(Date().removeTimeStamp!) == .orderedAscending {
            
                return .gray
            
             }
//        else if date.removeTimeStamp!.compare(Date().removeTimeStamp!) == .orderedDescending{
//
//                return .red
//
//             } else {
//
//                return .black
//
//             }
        return .white
          }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}

extension FreezingAccountViewController: HintPopupDelegate {
    
    func hintPopupReturn(type: String) {
        if type == "back" {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension Date {

    public var removeTimeStamp : Date? {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
         return nil
        }
        return date
    }
}
