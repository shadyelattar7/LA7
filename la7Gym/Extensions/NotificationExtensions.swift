//
//  NotificationNameExtensions.swift
//  IQRAA
//
//  Created by jimmy on 12/2/19.
//  Copyright © 2019 internet plus. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    static let cartChanges = Notification.Name("cartChanges")
    static let handleNotification = Notification.Name("handleNotification")
    static let loginSuccess = Notification.Name("loginSuccess")
    static let logout = Notification.Name("logout")
    static let openCart = Notification.Name("openCart")
    static let openHome = Notification.Name("openHome")
}
