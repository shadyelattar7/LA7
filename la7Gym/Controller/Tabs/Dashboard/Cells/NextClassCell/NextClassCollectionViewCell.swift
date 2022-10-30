//
//  NextClassCollectionViewCell.swift
//  la7Gym
//
//  Created by Mohamed on 17/08/2021.
//

import UIKit

class NextClassCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageViewClass: UIImageView!
    @IBOutlet weak var viewBackgroundDate: UIView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelInstuctor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewClass.layer.cornerRadius = 8
        viewBackgroundDate.layer.cornerRadius = 8
        viewBackground.layer.cornerRadius = 8
    }
    
    func setData(_ model: ClassModel) {
        imageViewClass.loadFromUrl(url: model.image_path ?? "")
        labelTime.text = "\(model.time_from ?? "") - \(model.time_to ?? "")"
        labelDate.text = model.date ?? ""
        labelInstuctor.text = model.instructor ?? ""
        labelName.text = model.title ?? ""
    }

}
