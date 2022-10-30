//
//  NotificationsViewController.swift
//  la7Gym
//
//  Created by Mohamed on 16/09/2021.
//

import UIKit

class NotificationsViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayNotifications = [NotificationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        GoogleAnalyticsHandler.instance.screenView(screenName: "NotificationsVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }

    func getData() {
        showIndicator()
        tableView.isHidden = true
        AppConnectionsHandler.get(url: AppUrl.instance.getNotifications(), headers: GET_DEFAULT_HEADERS(), type: NotificationsResponseModel.self) { (status, model, error) in
            self.showIndicator(false)
            switch status {
            case .sucess:
                let model = model as! NotificationsResponseModel
                self.arrayNotifications = model.notification ?? [NotificationModel]()
                self.tableView.isHidden = false
                self.tableView.reloadData()
                break
            case .error:
//                self.viewNoSessions.isHidden = false
                break
            }
        }
    }
}

class NotificationsResponseModel: Codable {
    
    let notification: [NotificationModel]?
}
