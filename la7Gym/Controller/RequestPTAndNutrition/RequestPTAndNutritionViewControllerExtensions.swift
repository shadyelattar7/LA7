//
//  RequestPTAndNutritionViewControllerExtensions.swift
//  la7Gym
//
//  Created by Mohamed on 17/09/2021.
//

import Foundation

extension RequestPTAndNutritionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTableView() {
        tableView.register(SelectedTrainerTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTrainers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as SelectedTrainerTableViewCell
        cell.selectionStyle = .none
        cell.index = indexPath.row
        cell.delegate = self
        cell.setData(arrayTrainers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension RequestPTAndNutritionViewController: TrainerCellDelegate {
    
    func deleteTrainer(_ index: Int) {
        arrayTrainers.remove(at: index)
        tableView.reloadData()
        constraintHeightTableView.constant = CGFloat(arrayTrainers.count * 50)
    }
}

extension RequestPTAndNutritionViewController: TrainerControllerDelegate {
    
    func selectedTrainers(_ trainers: [TrainerModel]) {
        arrayTrainers = trainers
        tableView.reloadData()
        constraintHeightTableView.constant = CGFloat(arrayTrainers.count * 50)
    }
}
