//
//  UserDefaultsExtensions.swift
//  MariaTradeSwift
//
//  Created by Mohamed Elmaazy on 2/4/20.
//  Copyright © 2020 Mohamed Elmaazy. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func getPushNotification() -> [String: Any] {
        return UserDefaults.standard.object(forKey: "remoteNotif") as? [String: Any] ?? [String: Any]()
    }
    
    func setPushNotification(_ notificatiotn: [String: Any]) {
        UserDefaults.standard.set(notificatiotn, forKey: "remoteNotif")
    }
    
    func getPushNotification() -> [AnyHashable: Any] {
        return UserDefaults.standard.object(forKey: "remoteNotif") as? [AnyHashable: Any] ?? [AnyHashable: Any]()
    }
    
    func setPushNotification(_ notificatiotn: [AnyHashable: Any]) {
        UserDefaults.standard.set(notificatiotn, forKey: "remoteNotif")
    }
    
    func getDatabaseToken() -> String {
        return UserDefaults.standard.object(forKey: "databaseToken") as? String ?? ""
    }
    
    func setDatabaseToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "databaseToken")
    }
    
    func getFirebaseToken() -> String {
        return UserDefaults.standard.object(forKey: "firebaseToken") as? String ?? ""
    }
    
    func setFirebaseToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "firebaseToken")
    }
    
    func getBaseUrl2() -> String {
        return UserDefaults.standard.object(forKey: "baseUrl2") as? String ?? ""
    }
    
    func setBaseUrl2(_ url: String) {
        UserDefaults.standard.set(url, forKey: "baseUrl2")
    }
    
    func getUserName() -> String {
        if getDatabaseToken() == "" {
            return "guest".localize
        }
        return UserDefaults.standard.object(forKey: "userName") as? String ?? ""
    }
    
    func setUserName(_ userName: String) {
        UserDefaults.standard.set(userName, forKey: "userName")
    }
    
    func setUser(user: UserModel?) {
        guard let user = user else { return }
        UserDefaults.standard.encode(for: user, using: "user")
    }
    
    func getUser() -> UserModel? {
        return UserDefaults.standard.decode(for: UserModel.self, using: "user")
    }
    
    func getSelectedBranch() -> BranchModel? {
        return UserDefaults.standard.decode(for: BranchModel.self, using: "selectedBranch")
    }
    
    func setSelectedBranch(_ branch: BranchModel) {
        UserDefaults.standard.encode(for: branch, using: "selectedBranch")
    }
    
    func decode<T : Codable>(for type : T.Type, using key : String) -> T? {
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: key) as? Data else {return nil}
        let decodedObject = try? PropertyListDecoder().decode(type, from: data)
        return decodedObject
    }

    func encode<T : Codable>(for type : T, using key : String) {
        let defaults = UserDefaults.standard
        let encodedData = try? PropertyListEncoder().encode(type)
        defaults.set(encodedData, forKey: key)
        defaults.synchronize()
    }
}
