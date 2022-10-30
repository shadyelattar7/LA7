//
//  BookATourViewController.swift
//  la7Gym
//
//  Created by Mohamed on 6/7/21.
//

import UIKit

class BookATourViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var textFieldName: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var textFieldPhone: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var textFieldAge: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var btnSendRequest: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSendRequest.layer.cornerRadius = 20
        GoogleAnalyticsHandler.instance.screenView(screenName: "BookATourVC")
    }

    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendRequest(_ sender: Any) {
        if checkData() {
            let params = ["name": textFieldName.text!,
                          "phone": textFieldPhone.text!,
                          "age": textFieldAge.text!]
            showIndicator()
            AppConnectionsHandler.post(url: AppUrl.instance.addTour(), params: params, headers: GET_DEFAULT_HEADERS(), type: StatusModel.self) { (status, model, error) in
                self.showIndicator(false)
                switch status {
                case .sucess:
                    self.navigationController?.pushViewController(ThankYouViewController(), animated: true)
                    break
                case .error:
                    AppPopUpHandler.instance.initHintPopUp(container: self, message: error ?? "")
                    break
                }
            }
        }
    }
    
    func checkData() -> Bool {
        if textFieldName.text == "" {
            AppPopUpHandler.instance.initHintPopUp(container: self, message: "Please enter your name")
            return false
        } else if textFieldPhone.text == "" {
            AppPopUpHandler.instance.initHintPopUp(container: self, message: "Please enter your phone number")
            return false
        } else if textFieldAge.text == "" {
            AppPopUpHandler.instance.initHintPopUp(container: self, message: "Please enter your age")
            return false
        }
        return true
    }
}

extension BookATourViewController: HintPopupDelegate {
    
    func hintPopupReturn(type: String) {
        if type == "close" {
            navigationController?.popViewController(animated: true)
        }
    }
}
