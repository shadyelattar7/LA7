//
//  BranchModel.swift
//  la7Gym
//
//  Created by Mohamed on 6/3/21.
//

import Foundation

class BranchModel: Codable {
    let id: String?
    let name: String?
    let desc: String?
    let icon: String?
    let image_path: String?
    let about: String?
    let contact_data: BranchContactDataModel?
    let facilities: [FacilityModel]?
    let interests: [InterestModel]?
    let classes: [ClassModel]?
    let api_url: String?
    
    init() {
        id = nil
        name = nil
        desc = nil
        icon = nil
        image_path = nil
        about = nil
        contact_data = nil
        facilities = nil
        interests = nil
        classes = nil
        api_url = nil
    }
}

class BranchContactDataModel: Codable {
    let facebook: String?
    let instagram: String?
    let website: String?
    let phone: String?
    let location: String?
}
