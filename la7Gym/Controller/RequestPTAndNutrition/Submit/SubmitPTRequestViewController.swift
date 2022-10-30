//
//  SubmitPTRequestViewController.swift
//  la7Gym
//
//  Created by Mohamed on 17/09/2021.
//

import UIKit

class SubmitPTRequestViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var tableViewsDays: UITableView!
    @IBOutlet weak var constraintHeightTableViewDays: NSLayoutConstraint!
    @IBOutlet weak var textFieldNotes: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var isPT = false
    var startDate = Date()
    var arrayDays = [DayModel]()
    var gender = 0
    var arrayTrainers = [TrainerModel]()
    
    init(isPT: Bool, startDate: Date, arrayDays: [DayModel], gender: Int, arrayTrainers: [TrainerModel]) {
        self.isPT = isPT
        self.startDate = startDate
        self.arrayDays = arrayDays
        self.gender = gender
        self.arrayTrainers = arrayTrainers
        super.init(nibName: "SubmitPTRequestViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        constraintHeightTableViewDays.constant = CGFloat(arrayDays.count * 100)
        labelTitle.text = isPT ? "Request PT Session" : "Request Nutrition Session"
        btnSubmit.layer.cornerRadius = 25
        GoogleAnalyticsHandler.instance.screenView(screenName: "RequestPtOrNutrationSubmitVC")
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submit(_ sender: Any) {
        if checkData() {
            showIndicator()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            var gen = ""
            if gender == 0 {
                gen = "either"
            } else if gender == 1 {
                gen = "male"
            } else {
                gen = "female"
            }
            var daysDic = [[String: String]]()
            for item in arrayDays {
                let dayDic = ["day": item.name, "from": item.from, "id": item.id, "symbol": item.symbol, "to": item.to]
                daysDic.append(dayDic)
            }
            let params = ["start_date": formatter.string(from: startDate),
                          "notes": textFieldNotes.text! == "" ? "empty notes" : textFieldNotes.text!,
                          "gender": gen,
                          "days": daysDic,
                          "trainers": arrayTrainers.map({$0.id ?? ""}),
                          "user_id": UserDefaults.standard.getUser()?.id ?? ""] as [String : Any]
            AppConnectionsHandler.raw(url: isPT ? AppUrl.instance.addPTRequest() : AppUrl.instance.addNutrationRequest(), params: params, headers: GET_DEFAULT_HEADERS(), type: StatusModel.self) { (status, model, error) in
                self.showIndicator(false)
                switch status {
                case .sucess:
                    if self.isPT {
                        GoogleAnalyticsHandler.instance.addPT()
                    } else {
                        GoogleAnalyticsHandler.instance.addNutration()
                    }
                    AppPopUpHandler.instance.initHintPopUp(container: self, message: "Request sent succesfully", type: "back")
                    break
                case .error:
                    AppPopUpHandler.instance.initHintPopUp(container: self, message: error ?? "")
                    break
                }
            }
        }
    }
    
    func checkData() -> Bool {
        for item in arrayDays {
            if item.from == "" || item.to == "" {
                AppPopUpHandler.instance.initHintPopUp(container: self, message: "Please choose \(item.name) times")
                return false
            }
        }
        return true
    }
}
