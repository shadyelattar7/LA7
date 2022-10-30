//
//  ClassTableViewCell.swift
//  la7Gym
//
//  Created by Mohamed on 6/23/21.
//

import UIKit

protocol ClassTableCellDelegate {
    func bookNow(_ index: Int)
}

class ClassTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewClass: UIImageView!
    @IBOutlet weak var viewBackgroundTime: UIView!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelClassName: UILabel!
    @IBOutlet weak var labelCoachName: UILabel!
    @IBOutlet weak var viewBackgroundType: UIView!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var btnBookNow: UIButton!
    @IBOutlet weak var labelDate: UILabel!
    
    var index = 0
    var delegate: ClassTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewClass.layer.cornerRadius = 8
        viewBackgroundTime.layer.cornerRadius = 8
        viewBackgroundType.layer.cornerRadius = 15
        btnBookNow.setBorder(color: .white, radius: 15, borderWidth: 1)
    }
    
    func setData(_ model: ClassModel, hideDate: Bool = true) {
        imageViewClass.loadFromUrl(url: model.image_path ?? "")
        labelTime.text = "\(model.time_from ?? "") - \(model.time_to ?? "")"
        labelClassName.text = model.title ?? ""
        labelCoachName.text = model.instructor ?? ""
        labelType.text = model.target_type ?? ""
        labelDate.text = model.date ?? ""
        labelDate.isHidden = hideDate
        if UserDefaults.standard.getDatabaseToken() == "" {
            btnBookNow.isHidden = true
        } else {
            btnBookNow.isHidden = false
            if model.status?.lowercased() == "canceled" {
                btnBookNow.isEnabled = false
                btnBookNow.alpha = 0.5
                btnBookNow.setTitle("Canceled", for: .normal)
            } else if model.booked_by_user ?? "" == "1" {
                btnBookNow.isEnabled = false
                btnBookNow.alpha = 0.5
                btnBookNow.setTitle("Booked", for: .normal)
            } else if (model.target_type ?? "").lowercased().contains("laides") || (model.target_type ?? "").lowercased().contains("women") {
                if (UserDefaults.standard.getUser()?.gender ?? "").lowercased() == "female" {
                    btnBookNow.isEnabled = true
                    btnBookNow.alpha = 1
                    btnBookNow.setTitle("Book now", for: .normal)
                } else {
                    btnBookNow.isEnabled = false
                    btnBookNow.alpha = 0.5
                    btnBookNow.setTitle("Women only", for: .normal)
                }
            } else {
                btnBookNow.isEnabled = true
                btnBookNow.alpha = 1
                btnBookNow.setTitle("Book now", for: .normal)
            }
        }
    }
    
    @IBAction func bookNow(_ sender: Any) {
        delegate?.bookNow(index)
    }
}
