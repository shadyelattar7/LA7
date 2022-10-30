//
//  InvitationRequestViewController.swift
//  la7Gym
//
//  Created by Mohamed on 19/09/2021.
//

import UIKit

class InvitationRequestViewController: UIViewController {

    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var textFieldPhone: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var textFieldName: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var textFieldAge: SkyFloatingLabelTextFieldWithIcon!
    
    var isMale = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        GoogleAnalyticsHandler.instance.screenView(screenName: "InvitationRequestVC")
    }
    
    func initView() {
        btnMale.layer.cornerRadius = 25
        btnFemale.layer.cornerRadius = 25
        btnSend.layer.cornerRadius = 25
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func male(_ sender: Any) {
        isMale = true
        btnMale.backgroundColor = .fromHex(hex: "#1E988A")
        btnFemale.backgroundColor = .fromHex(hex: "#363636")
    }
    
    @IBAction func female(_ sender: Any) {
        isMale = false
        btnFemale.backgroundColor = .fromHex(hex: "#1E988A")
        btnMale.backgroundColor = .fromHex(hex: "#363636")
    }
    
    @IBAction func send(_ sender: Any) {
        if checkData() {
            showIndicator()
            let params = ["age": textFieldAge.text!,
                          "gender": isMale ? "male" : "female",
                          "user_id": UserDefaults.standard.getUser()?.id ?? "",
                          "phone": textFieldPhone.text!,
                          "name": textFieldName.text!]
            AppConnectionsHandler.post(url: AppUrl.instance.addInvitationRequest(), params: params, headers: GET_DEFAULT_HEADERS(), type: StatusModel.self) { (status, model, error) in
                self.showIndicator(false)
                switch status {
                case .sucess:
                    AppPopUpHandler.instance.initHintPopUp(container: self, message: "Your request sent and we will review it soon", type: "back")
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
            AppPopUpHandler.instance.initHintPopUp(container: self, message: "Please enter name")
            return false
        } else if textFieldPhone.text == "" {
            AppPopUpHandler.instance.initHintPopUp(container: self, message: "Please enter phone number")
            return false
        } else if textFieldAge.text == "" {
            AppPopUpHandler.instance.initHintPopUp(container: self, message: "Please enter age")
            return false
        }
        return true
    }
}

extension InvitationRequestViewController: HintPopupDelegate {
    
    func hintPopupReturn(type: String) {
        if type == "back" {
            navigationController?.popViewController(animated: true)
        }
    }
}
