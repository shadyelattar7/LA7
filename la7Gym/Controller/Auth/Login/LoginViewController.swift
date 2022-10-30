//
//  LoginViewController.swift
//  la7Gym
//
//  Created by Mohamed on 09/08/2021.
//

import UIKit

class LoginViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var textFieldPhone: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var textFieldPassword: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.layer.cornerRadius = 20
        GoogleAnalyticsHandler.instance.screenView(screenName: "LoginVC")
    }

    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
    
    @IBAction func login(_ sender: Any) {
        if checkData() {
            let params = ["phone": textFieldPhone.text!,
                          "password": textFieldPassword.text!,
                          "device_token": UserDefaults.standard.getFirebaseToken(),
                          "device_type": "ios"]
            showIndicator()
            AppConnectionsHandler.post(url: AppUrl.instance.login(), params: params, headers: GET_DEFAULT_HEADERS(), type: UserResponseModel.self) { (status, model, error) in
                self.showIndicator(false)
                switch status {
                case .sucess:
                    let model = model as! UserResponseModel
                    UserDefaults.standard.setDatabaseToken(model.access_token ?? "")
                    UserDefaults.standard.setUser(user: model.user)
                    UserDefaults.standard.setUserName(model.user?.first_name ?? "")
                    self.navigationController?.pushViewController(InterestsViewController(interests: UserDefaults.standard.getSelectedBranch()?.interests ?? [InterestModel]()), animated: true)
                    break
                case .error:
                    AppPopUpHandler.instance.initHintPopUp(container: self, message: error ?? "")
                    break
                }
            }
        }
    }
    
    func checkData() -> Bool {
        if textFieldPhone.text == "" {
            AppPopUpHandler.instance.initHintPopUp(container: self, message: "Please enter phone number")
            return false
        } else if textFieldPassword.text == "" {
            AppPopUpHandler.instance.initHintPopUp(container: self, message: "Please enter password")
            return false
        }
        return true
    }
}

struct UserResponseModel: Codable {
    let user: UserModel?
    let access_token: String?
}
