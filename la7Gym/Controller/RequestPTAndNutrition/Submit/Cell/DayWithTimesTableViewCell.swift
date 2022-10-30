//
//  DayWithTimesTableViewCell.swift
//  la7Gym
//
//  Created by Mohamed on 17/09/2021.
//

import UIKit

protocol DayWithTimeDelegate {
    func openFrom(_ index: Int)
    func openTo(_ index: Int)
}

class DayWithTimesTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var viewFrom: UIView!
    @IBOutlet weak var labelFrom: UILabel!
    @IBOutlet weak var viewTo: UIView!
    @IBOutlet weak var labelTo: UILabel!
    
    var index = 0
    var delegate: DayWithTimeDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewFrom.layer.cornerRadius = 25
        viewTo.layer.cornerRadius = 25
        viewFrom.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openFrom)))
        viewTo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openTo)))
    }
    
    func setData(_ model: DayModel) {
        labelName.text = model.name
        labelFrom.text = model.fromCell
        labelTo.text = model.toCell
    }
    
    @objc func openFrom() {
        delegate?.openFrom(index)
    }
    
    @objc func openTo() {
        delegate?.openTo(index)
    }
}
