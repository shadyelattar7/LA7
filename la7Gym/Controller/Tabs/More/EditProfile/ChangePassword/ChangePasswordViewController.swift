//
//  ChangePasswordViewController.swift
//  la7Gym
//
//  Created by Mohamed on 21/09/2021.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var textFieldPAssword: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var textFieldRePassword: SkyFloatingLabelTextFieldWithIcon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSend.setBorder(color: .white, radius: 20, borderWidth: 1)
        GoogleAnalyticsHandler.instance.screenView(screenName: "ChangePasswordVC")
    }

    @IBAction func send(_ sender: Any) {
        if textFieldPAssword.text == "" {
            AppPopUpHandler.instance.initHintPopUp(container: self, message: "Please enter password")
        } else if textFieldPAssword.text != textFieldRePassword.text {
            AppPopUpHandler.instance.initHintPopUp(container: self, message: "Passwords mismatched")
        } else {
            showIndicator()
            AppConnectionsHandler.post(url: AppUrl.instance.changePassword(), params: ["password": textFieldRePassword.text!], headers: GET_DEFAULT_HEADERS(), type: StatusModel.self) { (status, model, error) in
                self.showIndicator(false)
                switch status {
                case .sucess:
                    AppPopUpHandler.instance.initHintPopUp(container: self, message: "Password changed successfuly", type: "back")
                    break
                case .error:
                    AppPopUpHandler.instance.initHintPopUp(container: self, message: error ?? "")
                    break
                }
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension ChangePasswordViewController: HintPopupDelegate {
    
    func hintPopupReturn(type: String) {
        if type == "back" {
            navigationController?.popViewController(animated: true )
        }
    }
}
