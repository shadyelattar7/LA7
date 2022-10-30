//
//  TabsViewController.swift
//  la7Gym
//
//  Created by Mohamed on 6/3/21.
//

import UIKit

class TabsViewController: UITabBarController, UITabBarControllerDelegate {
    
    let dashboardVC = DashboardViewController()
    let scheduleVC = ScheduleViewController()
    let myCalendarVC = MyCalendarViewController()
    let notificationsVC = NotificationsViewController()
    let moreVC = MoreViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTabs()
        disableDarkMode()
        tabBar.barTintColor = .black
//        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    private func initTabs () {
        tabBar.isTranslucent = true
        
        dashboardVC.tabBarItem = UITabBarItem.init(title:"Dashboard".localize, image: #imageLiteral(resourceName: "dashboard_ic"), tag: 0)
        scheduleVC.tabBarItem = UITabBarItem.init(title: "Schedule".localize, image: #imageLiteral(resourceName: "schedule_ic"), tag: 1)
        myCalendarVC.tabBarItem = UITabBarItem.init(title: "Calendar".localize, image: #imageLiteral(resourceName: "calendar_ic"), tag: 2)
        notificationsVC.tabBarItem = UITabBarItem.init(title: "Notifications", image: #imageLiteral(resourceName: "notifications_ic"), tag: 3)
        moreVC.tabBarItem = UITabBarItem.init(title: "More".localize, image: #imageLiteral(resourceName: "more_ic"), tag: 4)
        
        viewControllers = [dashboardVC, scheduleVC, myCalendarVC, notificationsVC, moreVC]
        UITabBar.appearance().tintColor = UIColor.fromHex(hex: "1E988A")
        tabBar.unselectedItemTintColor = UIColor.fromHex(hex: "9B9B9B")
    }
    
}
