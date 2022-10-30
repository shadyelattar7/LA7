//
//  OptionPopupViewController.swift
//  nasTrends
//
//  Created by Ahmed gamal on 1/31/19.
//  Copyright © 2019 Mohamed Elmaazy. All rights reserved.
//

import UIKit

protocol OptionPopupDelegate {
    func makeConfirm(ok: Bool, type: String)
}

class OptionPopupViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var labelMessage: UILabel!
    
    var delegate: OptionPopupDelegate?
    var message = ""
    var type = ""
    
    init(message: String, type: String) {
        self.message = message
        self.type = type
        super.init(nibName: "OptionPopupViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        labelMessage.text = message
        btnOk.layer.cornerRadius = 20
        btnCancel.layer.cornerRadius = 20
        disableDarkMode()
    }

    @IBAction func ok(_ sender: Any) {
        dismiss(animated: true, completion: {
            self.delegate?.makeConfirm(ok: true, type: self.type)
        })
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: {
            self.delegate?.makeConfirm(ok: false, type: self.type)
        })
    }
}
