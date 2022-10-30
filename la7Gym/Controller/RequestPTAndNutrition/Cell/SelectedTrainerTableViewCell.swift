//
//  SelectedTrainerTableViewCell.swift
//  la7Gym
//
//  Created by Mohamed on 17/09/2021.
//

import UIKit

protocol TrainerCellDelegate {
    func deleteTrainer(_ index: Int)
}

class SelectedTrainerTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imageVewTrainer: UIImageView!
    @IBOutlet weak var imageViewDelete: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    var index = 0
    var delegate: TrainerCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBackground.layer.cornerRadius = 20
        imageVewTrainer.layer.cornerRadius = 15
        imageViewDelete.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleteTrainer)))
    }

    func setData(_ model: TrainerModel) {
        imageVewTrainer.loadFromUrl(url: model.avatar ?? "")
        labelName.text = "\(model.first_name ?? "") \(model.last_name ?? "")"
    }
    
    @objc func deleteTrainer() {
        delegate?.deleteTrainer(index)
    }
}
