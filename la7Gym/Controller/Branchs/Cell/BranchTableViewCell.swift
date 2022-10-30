//
//  BranchTableViewCell.swift
//  la7Gym
//
//  Created by Mohamed on 6/3/21.
//

import UIKit

class BranchTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imageViewBranch: UIImageView!
    @IBOutlet weak var labelDetails: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBackground.layer.cornerRadius = 20
        imageViewBranch.layer.cornerRadius = 20
    }

   
    func setData(_ model: BranchModel) {
        imageViewBranch.loadFromUrl(url: model.image_path ?? "")
        labelName.text = model.name ?? ""
        labelDetails.text = model.about ?? ""
    }
    
}
