//
//  GraphModel.swift
//  la7Gym
//
//  Created by Mohamed on 24/09/2021.
//

import Foundation

class GraphModel: Codable {
    
    let id: String?
    let date: String?
    let type: String?
    let symbol: String?
    let value: String?
    let user_id: String?
    let created_at: String?
    let updated_at: String?
    
    func getDate() -> Double {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date ?? "") ?? Date()
        return date.timeIntervalSince1970
    }
    
    func getDateFormatted() -> String {
        let arr = date?.components(separatedBy: "-")
        if arr?.count ?? 0 > 2 {
            return "\(arr![1])/\(arr![2])"
        }
        return ""
    }
}
