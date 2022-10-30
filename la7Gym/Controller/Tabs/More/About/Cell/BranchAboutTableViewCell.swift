//
//  BranchAboutTableViewCell.swift
//  la7Gym
//
//  Created by Mohamed on 24/09/2021.
//

import UIKit

protocol BranchCellDelegate {
    func openBranchLocation(_ index: Int)
    func callBranch(_ index: Int)
}

class BranchAboutTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imageViewBranch: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDetails: UILabel!
    @IBOutlet weak var viewScheduale: UIView!
    @IBOutlet weak var imageViewLocation: UIImageView!
    @IBOutlet weak var imageViewCall: UIImageView!
    
    var delegate: BranchCellDelegate?
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewBranch.layer.cornerRadius = 20
        viewScheduale.layer.cornerRadius = 25
        imageViewLocation.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openLocation)))
        imageViewCall.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openCall)))
    }

    func setData(_ model: BranchModel) {
        imageViewBranch.loadFromUrl(url: model.image_path ?? "")
        labelName.text = model.name ?? ""
        labelDetails.text = model.about ?? ""
    }
    
    @objc func openLocation() {
        delegate?.openBranchLocation(index)
    }
    
    @objc func openCall() {
        delegate?.callBranch(index)
    }
}
