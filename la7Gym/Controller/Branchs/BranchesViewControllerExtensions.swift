//
//  BranchesViewControllerExtensions.swift
//  la7Gym
//
//  Created by Mohamed on 6/3/21.
//

import Foundation
import UIKit

extension BranchesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTableView() {
        tableView.register(BranchTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayBranches.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as BranchTableViewCell
        cell.selectionStyle = .none
        cell.setData(arrayBranches[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.setSelectedBranch(arrayBranches[indexPath.row])
//        navigationController?.pushViewController(InterestsViewController(interests: arrayBranches[indexPath.row].interests ?? [InterestModel]()), animated: true)
        UserDefaults.standard.setBaseUrl2("\(arrayBranches[indexPath.row].api_url ?? "")/")
        if gotoLogin {
            navigationController?.pushViewController(LoginViewController(), animated: true)
        } else {
            navigationController?.pushViewController(TabsViewController(), animated: true)
        }
    }
}
