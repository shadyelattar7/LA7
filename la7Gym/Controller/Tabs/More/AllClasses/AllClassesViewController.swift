//
//  AllClassesViewController.swift
//  la7Gym
//
//  Created by Mohamed on 17/09/2021.
//

import UIKit

class AllClassesViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayClasses = [ClassModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        GoogleAnalyticsHandler.instance.screenView(screenName: "AllClassesVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    func getData() {
        showIndicator()
        tableView.isHidden = true
        AppConnectionsHandler.get(url: AppUrl.instance.getSessionsInDate(""), headers: GET_DEFAULT_HEADERS(), type: SessionsResponseModel.self) { (status, model, error) in
            self.showIndicator(false)
            switch status {
            case .sucess:
                let model = model as! SessionsResponseModel
                self.arrayClasses = model.classes ?? [ClassModel]()
                if self.arrayClasses.count == 0 {
                    self.tableView.isHidden = true
                } else {
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
                break
            case .error:
                break
            }
        }
    }

    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
