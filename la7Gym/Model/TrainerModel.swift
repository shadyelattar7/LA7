//
//  TrainerModel.swift
//  la7Gym
//
//  Created by Mohamed on 16/09/2021.
//

import Foundation

class TrainerModel: Codable {
    
    let id: String?
    let first_name: String?
    let last_name: String?
    let avatar_directory: String?
    let avatar_filename: String?
    let position: String?
    let have_pt_session: String?
    let avatar: String?
    let membership_id: String?
    let subscription_end_date: String?
    
    var selected: Bool?
}
