//
//  AllClassesViewControllerExtensions.swift
//  la7Gym
//
//  Created by Mohamed on 17/09/2021.
//

import Foundation

extension AllClassesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTableView() {
        tableView.register(ClassTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayClasses.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as ClassTableViewCell
        cell.selectionStyle = .none
        cell.index = indexPath.row
        cell.delegate = self
        cell.setData(arrayClasses[indexPath.row], hideDate: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(ClassDetailsViewController(classId: arrayClasses[indexPath.row].id ?? ""), animated: true)
    }
}

extension AllClassesViewController: ClassTableCellDelegate {
    
    func bookNow(_ index: Int) {
        if UserDefaults.standard.getDatabaseToken() == "" {
            AppPopUpHandler.instance.initOptionPopUp(container: self, message: "You have to login to use this feature", type: "login")
        } else {
            let vc = BookNowPopupViewController(modelClass: arrayClasses[index])
            vc.delegate = self
            AppPopUpHandler.instance.openVC(vc, height: 400)
        }
    }
}

extension AllClassesViewController: BookClassPopupDelegate {
    
    func classBooked() {
        AppPopUpHandler.instance.initHintPopUp(container: self, message: "Class booked sucessfully")
        getData()
    }
}
