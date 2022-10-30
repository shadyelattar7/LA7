//
//  HintPopupViewController.swift
//  1Pharmacy
//
//  Created by mohamed elmaazy on 6/24/18.
//  Copyright © 2018 mohamed elmaazy. All rights reserved.
//

import UIKit

protocol HintPopupDelegate {
    func hintPopupReturn(type: String)
}

class HintPopupViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var btnOk: UIButton!
    
    var message = ""
    var delegate: HintPopupDelegate?
    var type = ""
    
    init(message:String, type: String) {
        super.init(nibName: "HintPopupViewController", bundle: nil)
        self.message = message
        self.type = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    func initViews() {
        initText()
        btnOk.layer.cornerRadius = GET_RATIO(10)
    }
    
    func initText() {
        labelMessage.text = message
    }
    
    @IBAction func ok(_ sender: UIButton) {
        dismiss(animated: true, completion: {
            self.delegate?.hintPopupReturn(type: self.type)
        })
    }
}
