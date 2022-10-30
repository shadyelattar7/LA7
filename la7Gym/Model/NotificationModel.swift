//
//  NotificationModel.swift
//  la7Gym
//
//  Created by Mohamed on 23/09/2021.
//

import Foundation

class NotificationModel: Codable {
    
    let id: String?
    let type: String?
    let notifiable_type: String?
    let notifiable_id: String?
    let data: NotificationDataModel?
    let read_at: String?
    let created_at: String?
    let updated_at: String?
    let sent_at: String?
}

class NotificationDataModel: Codable {
    let type: String?
    let text: String?
    let icon: String?
}
