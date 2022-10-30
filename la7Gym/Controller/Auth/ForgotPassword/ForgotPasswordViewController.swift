//
//  ForgotPasswordViewController.swift
//  la7Gym
//
//  Created by Mohamed on 17/08/2021.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var textFieldEmail: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSubmit.layer.cornerRadius = 20
        GoogleAnalyticsHandler.instance.screenView(screenName: "ForgotPasswordVC")
    }

    @IBAction func submit(_ sender: Any) {
        if !textFieldEmail.isValidEmail() || textFieldEmail.text == "" {
            AppPopUpHandler.instance.initHintPopUp(container: self, message: "Please enter a valid email")
        } else {
            let params = ["email": textFieldEmail.text!]
            showIndicator()
            AppConnectionsHandler.post(url: AppUrl.instance.forgotPassword(), params: params, headers: GET_DEFAULT_HEADERS(), type: StatusModel.self) { (status, model, error) in
                self.showIndicator(false)
                switch status {
                case .sucess:
                    AppPopUpHandler.instance.initHintPopUp(container: self, message: "Message sent to your email address", type: "back")
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

extension ForgotPasswordViewController: HintPopupDelegate {
    
    func hintPopupReturn(type: String) {
        if type == "back" {
            navigationController?.popViewController(animated: true)
        }
    }
}
