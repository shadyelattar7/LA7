//
//  MyCalendarTableViewCell.swift
//  la7Gym
//
//  Created by Mohamed on 16/09/2021.
//

import UIKit

class MyCalendarTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imageViewClass: UIImageView!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelTrainer: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBackground.layer.cornerRadius = 20
        imageViewClass.layer.cornerRadius = 8
    }

    func setData(_ model: ClassModel) {
        imageViewClass.loadFromUrl(url: model.image_path ?? "")
        labelTime.text = "\(model.time_from ?? "") - \(model.time_to ?? "")"
        labelName.text = model.title ?? ""
        labelTrainer.text = model.instructor ?? ""
    }
}
