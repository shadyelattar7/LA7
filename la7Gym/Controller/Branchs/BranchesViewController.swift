//
//  BranchesViewController.swift
//  la7Gym
//
//  Created by Mohamed on 6/3/21.
//

import UIKit

class BranchesViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewError: UIView!
    @IBOutlet weak var labelError: UILabel!
    
    var arrayBranches = [BranchModel]()
    var gotoLogin = false
    
    init(gotoLogin: Bool) {
        self.gotoLogin = gotoLogin
        super.init(nibName: "BranchesViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        getData()
        GoogleAnalyticsHandler.instance.screenView(screenName: "BranchVC")
    }
    
    func getData() {
        showIndicator()
        viewError.isHidden = true
        AppConnectionsHandler.get(url: AppUrl.instance.branches(), headers: GET_DEFAULT_HEADERS(), type: BranchesResponseModel.self) { (status, model, error) in
            self.showIndicator(false)
            switch status {
            case .sucess:
                let model = model as! BranchesResponseModel
                self.arrayBranches = model.Branches ?? [BranchModel]()
                self.tableView.reloadData()
                break
            case .error:
                self.viewError.isHidden = false
                self.labelError.text = error ?? ""
                break
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func retry(_ sender: Any) {
        getData()
    }
}

class BranchesResponseModel: Codable {
    let Branches: [BranchModel]?
}
