//
//  NotificationTableViewCell.swift
//  la7Gym
//
//  Created by Mohamed on 23/09/2021.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imageViewNotification: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBackground.layer.cornerRadius = 20
    }

    func setData(_ model: NotificationModel) {
        imageViewNotification.loadFromUrl(url: model.data?.icon ?? "")
        labelName.text = model.data?.type ?? ""
        labelType.text = model.data?.text ?? ""
        labelDate.text = model.sent_at ?? ""
    }
}
