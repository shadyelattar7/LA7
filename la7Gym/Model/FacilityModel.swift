//
//  FacilityModel.swift
//  la7Gym
//
//  Created by Mohamed on 6/3/21.
//

import Foundation

class FacilityModel: Codable {
    let id: String?
    let name: String?
    let icon: String?
    let image_path: String?
    let pivot: FacilityPivot?
}

class FacilityPivot: Codable {
    let branch_id: String?
    let facility_id: String?
}
