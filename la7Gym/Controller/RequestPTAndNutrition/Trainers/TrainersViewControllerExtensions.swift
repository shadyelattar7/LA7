//
//  TrainersViewControllerExtensions.swift
//  la7Gym
//
//  Created by Mohamed on 16/09/2021.
//

import Foundation

extension TrainersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTableView() {
        tableView.register(TrainerTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTrainers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as TrainerTableViewCell
        cell.selectionStyle = .none
        cell.setData(arrayTrainers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        arrayTrainers[indexPath.row].selected  = !(arrayTrainers[indexPath.row].selected ?? false)
        tableView.reloadData()
    }
}
