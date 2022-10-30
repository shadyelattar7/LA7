//
//  SuggestionsViewController.swift
//  la7Gym
//
//  Created by Mohamed on 17/09/2021.
//

import UIKit

class SuggestionsViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var btnSuggistions: UIButton!
    @IBOutlet weak var btnComplaints: UIButton!
    @IBOutlet weak var textViewComment: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    
    var isSuggestion = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSuggistions.layer.cornerRadius = 25
        btnComplaints.layer.cornerRadius = 25
        btnSend.layer.cornerRadius = 25
        GoogleAnalyticsHandler.instance.screenView(screenName: "SugessionsVC")
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func suggistions(_ sender: Any) {
        isSuggestion = true
        btnSuggistions.backgroundColor = .fromHex(hex: "#1E988A")
        btnComplaints.backgroundColor = .fromHex(hex: "#363636")
    }
    
    @IBAction func complaints(_ sender: Any) {
        isSuggestion = false
        btnComplaints.backgroundColor = .fromHex(hex: "#1E988A")
        btnSuggistions.backgroundColor = .fromHex(hex: "#363636")
    }
    
    @IBAction func send(_ sender: Any) {
        if textViewComment.text == "" {
            AppPopUpHandler.instance.initHintPopUp(container: self, message: "Please enter your comment")
        } else {
            showIndicator()
            let params = ["text": textViewComment.text!,
                          "type": isSuggestion ? "suggestion" : "complaint"]
            AppConnectionsHandler.post(url: AppUrl.instance.addSuggestions(), params: params, headers: GET_DEFAULT_HEADERS(), type: StatusModel.self) { (status, model, error) in
                self.showIndicator(false)
                switch status {
                case .sucess:
                    AppPopUpHandler.instance.initHintPopUp(container: self, message: "Your comment sent and we will review on it soon", type: "back")
                    break
                case .error:
                    AppPopUpHandler.instance.initHintPopUp(container: self, message: error ?? "")
                    break
                }
            }
        }
    }
}

extension SuggestionsViewController: HintPopupDelegate {
    
    func hintPopupReturn(type: String) {
        if type == "back" {
            navigationController?.popViewController(animated: true)
        }
    }
}
