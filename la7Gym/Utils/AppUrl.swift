//
//  AppUrl.swift
//  MariaTradeSwift
//
//  Created by Mohamed Elmaazy on 2/4/20.
//  Copyright © 2020 Mohamed Elmaazy. All rights reserved.
//

import Foundation

class AppUrl {
    
    static let instance = AppUrl()
    private init () {}
    
    fileprivate let POSTMAN_COLLECTION =  "https://www.getpostman.com/collections/5a82d2b9f041f67f805e"
    private var BASE_URL = "http://gym-app-data.monsterscs.com/api/"
    
    func branches() -> String {
        "\(BASE_URL)get-branches"
    }
    
    func branchDetails(_ id: String) -> String {
        "\(BASE_URL)get-branch/\(id)"
    }
    
    func branchCapacity(_ id: String) -> String {
        "\(BASE_URL)get-branch-capacity/\(id)"
    }
    
    func addTour() -> String {
        "\(BASE_URL)add-tour"
    }
    
    func classDetails(_ id: String) -> String {
        "\(UserDefaults.standard.getBaseUrl2())get-class/\(id)"
    }
    
    func getSessionsInDate(_ date: String) -> String {
        "\(UserDefaults.standard.getBaseUrl2())get-classes?\(date != "" ? "date=\(date)&" : "")branch_id=\(UserDefaults.standard.getSelectedBranch()?.id ?? "")"
    }
    
    func login() -> String {
        "\(UserDefaults.standard.getBaseUrl2())login"
    }
    func getinterests() -> String {
        "\(UserDefaults.standard.getBaseUrl2())get-interests"
    }
    func addInterests() -> String {
        "\(UserDefaults.standard.getBaseUrl2())add-interests"
    }
    func forgotPassword() -> String {
        "\(UserDefaults.standard.getBaseUrl2())send_reset_link_email"
    }
    func homeData() -> String {
        "\(UserDefaults.standard.getBaseUrl2())home"
    }
    func bookClass() -> String {
        "\(UserDefaults.standard.getBaseUrl2())book-class"
    }
    func getUser() -> String {
        "\(UserDefaults.standard.getBaseUrl2())user"
    }
    func getTrainers() -> String {
        "\(UserDefaults.standard.getBaseUrl2())trainers"
    }
    func addPTRequest() -> String {
        "\(UserDefaults.standard.getBaseUrl2())add-pt-request"
    }
    func addNutrationRequest() -> String {
        "\(UserDefaults.standard.getBaseUrl2())add-nutrition-request"
    }
    func addSuggestions() -> String {
        "\(BASE_URL)add-suggestion"
    }
    func freezRequest() -> String {
        "\(UserDefaults.standard.getBaseUrl2())add-freeze-request"
    }
    func addInvitationRequest() -> String {
        "\(UserDefaults.standard.getBaseUrl2())add-invitation-request"
    }
    func changePassword() -> String {
        "\(UserDefaults.standard.getBaseUrl2())update-password"
    }
    func getNotifications() -> String {
        "\(UserDefaults.standard.getBaseUrl2())notifications"
    }
    func aboutGym() -> String {
        "\(BASE_URL)get-branch/\(UserDefaults.standard.getSelectedBranch()?.id ?? "")"
    }
    func getGraph() -> String {
        "\(UserDefaults.standard.getBaseUrl2())user-assessment"
    }
    func cancelClass() -> String {
        "\(UserDefaults.standard.getBaseUrl2())cancel-class"
    }
}
