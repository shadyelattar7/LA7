//
//  ChooseTimePopupViewController.swift
//  la7Gym
//
//  Created by Mohamed on 17/09/2021.
//

import UIKit

protocol ChooseTimePopupDelegate {
    func returnWithTime(date: Date, isFrom: Bool, index: Int)
}

class ChooseTimePopupViewController: UIViewController {

    @IBOutlet weak var pickerTime: UIDatePicker!
    @IBOutlet weak var btnChoose: UIButton!
    
    var delegate: ChooseTimePopupDelegate?
    var isFrom = false
    var index = 0
    
    init(isFrom: Bool, index: Int) {
        self.isFrom = isFrom
        self.index = index
        super.init(nibName: "ChooseTimePopupViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for view in pickerTime.subviews {
            view.setValue(UIColor.white, forKeyPath: "textColor")
        }
        pickerTime.setValue(false, forKey: "highlightsToday")
        btnChoose.setBorder(color: .white, radius: 25, borderWidth: 1)
    }

    @IBAction func choose(_ sender: Any) {
        mz_dismissFormSheetController(animated: true) { _ in
            self.delegate?.returnWithTime(date: self.pickerTime.date, isFrom: self.isFrom, index: self.index)
        }
    }
}
