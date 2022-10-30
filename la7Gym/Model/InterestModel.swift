//
//  InterestModel.swift
//  la7Gym
//
//  Created by Mohamed on 6/3/21.
//

import Foundation

class InterestModel: Codable {
    let id: String?
    var title: String?
    let icon: String?
    let pivot: InterestPivot?
    
    var selected: String?
    
    init() {
        id = ""
        title = ""
        icon = ""
        pivot = nil
        selected = nil
    }
}

class InterestPivot: Codable {
    let branch_id: String?
    let interest_id: String?
}
