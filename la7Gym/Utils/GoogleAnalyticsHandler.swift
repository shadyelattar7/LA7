//
//  GoogleAnalyticsHandler.swift
//  la7Gym
//
//  Created by m3azy on 05/02/2022.
//

import Foundation
import FirebaseAnalytics

class GoogleAnalyticsHandler {
    
    static let instance = GoogleAnalyticsHandler()
    private init() { }
    
    func bookClass(classId: String) {
        let params = ["class_id": classId,
                      "user_id": UserDefaults.standard.getUser()?.id ?? ""]
        Analytics.logEvent("book_class", parameters: params)
    }
    
    func addPT() {
        let params = ["user_id": UserDefaults.standard.getUser()?.id ?? ""]
        Analytics.logEvent("add_pt_session", parameters: params)
    }
    
    func addNutration() {
        let params = ["user_id": UserDefaults.standard.getUser()?.id ?? ""]
        Analytics.logEvent("add_nutrition_session", parameters: params)
    }
    
    func screenView(screenName: String) {
        Analytics.setUserID(UserDefaults.standard.getUser()?.id ?? "")
        Analytics.setUserProperty("user_name", forName: UserDefaults.standard.getUserName())
        let params = ["Platform": "iOS",
                      "Screen": screenName]
        Analytics.logEvent("screen_view", parameters: params)
    }
}
