//
//  FreezingAccountViewController.swift
//  la7Gym
//
//  Created by Mohamed on 18/09/2021.
//

import UIKit
import FSCalendar

class FreezingAccountViewController: UIViewController {

    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var labelDateRange: CustomLabel!
    @IBOutlet weak var viewCalendar: FSCalendar!
    
    var firstDate: Date?
    var lastDate: Date?
    var datesRange: [Date]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCalendar()
        GoogleAnalyticsHandler.instance.screenView(screenName: "FreezingVC")
    }
    
    func initCalendar() {
        viewCalendar.allowsMultipleSelection = true
        btnSubmit.layer.cornerRadius = 20
    }

    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submit(_ sender: Any) {
        if datesRange?.count ?? 0 < 2 {
            AppPopUpHandler.instance.initHintPopUp(container: self, message: "You have to choose date interval")
        } else {
            showIndicator()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let params = ["date_from": formatter.string(from: datesRange?.first ?? Date()),
                          "date_to": formatter.string(from: datesRange?.last ?? Date()),
                          "user_id": UserDefaults.standard.getUser()?.id ?? ""]
                AppConnectionsHandler.post(url: AppUrl.instance.freezRequest(), params: params, headers: GET_DEFAULT_HEADERS(), type: StatusModel.self) { (status, model, error) in
                    self.showIndicator(false)
                    switch status {
                    case .sucess:
                        AppPopUpHandler.instance.initHintPopUp(container: self, message: "Your request sent successfully, and we will review it soon", type: "back")
                        break
                    case .error:
                        AppPopUpHandler.instance.initHintPopUp(container: self, message: error ?? "")
                        break
                    }
                }
        }
    }
}
