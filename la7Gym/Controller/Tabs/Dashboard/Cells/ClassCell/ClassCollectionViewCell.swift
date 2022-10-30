//
//  ClassCollectionViewCell.swift
//  la7Gym
//
//  Created by Mohamed on 6/7/21.
//

import UIKit

class ClassCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewClass: UIImageView!
    @IBOutlet weak var viewBackgroundTime: UIView!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelClassName: UILabel!
    @IBOutlet weak var labelCoachName: UILabel!
    @IBOutlet weak var labelType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewClass.layer.cornerRadius = 8
        viewBackgroundTime.layer.cornerRadius = 8
    }
    
    func setData(_ model: ClassModel) {
        imageViewClass.loadFromUrl(url: model.image_path ?? "")
        labelTime.text = "\(model.time_from ?? "") - \(model.time_to ?? "")"
        labelClassName.text = model.title ?? ""
        labelCoachName.text = model.instructor ?? ""
        labelType.text = model.target_type ?? ""
    }

}
