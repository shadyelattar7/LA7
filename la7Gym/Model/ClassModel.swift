//
//  ClassModel.swift
//  la7Gym
//
//  Created by Mohamed on 6/7/21.
//

import Foundation

class ClassModel: Codable {
    let id: String?
    let title: String?
    let date: String?
    let time_from: String?
    let time_to: String?
    let age: String?
    let instructor: String?
    let target_type: String?
    let image_path: String?
    let branch_id: String?
    let created_at: String?
    let updated_at: String?
    let about: String?
    let booked_by_user: String?
    let pivot: ClassPivotModel?
    let is_full: String?
    let status: String?
}

class ClassPivotModel: Codable {
    let user_id: String?
    let class_id: String?
}
