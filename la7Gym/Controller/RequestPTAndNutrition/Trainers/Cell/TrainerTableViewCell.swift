//
//  TrainerTableViewCell.swift
//  la7Gym
//
//  Created by Mohamed on 16/09/2021.
//

import UIKit

class TrainerTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imageViewTrainer: UIImageView!
    @IBOutlet weak var imageViewSelected: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBackground.layer.cornerRadius = 20
        imageViewTrainer.layer.cornerRadius = 25
    }

    func setData(_ model: TrainerModel) {
        imageViewTrainer.loadFromUrl(url: model.avatar ?? "")
        labelName.text = "\(model.first_name ?? "") \(model.last_name ?? "")"
        labelDescription.text = model.position ?? ""
        imageViewSelected.image = model.selected ?? false ? #imageLiteral(resourceName: "Group 1362") : #imageLiteral(resourceName: "Group 1359")
    }
}
