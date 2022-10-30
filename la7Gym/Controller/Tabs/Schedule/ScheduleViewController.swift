//
//  ScheduleViewController.swift
//  la7Gym
//
//  Created by Mohamed on 6/22/21.
//

import UIKit
import FSCalendar

class ScheduleViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var viewCalendar: FSCalendar!
    @IBOutlet weak var viewNoSessions: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedDate = Date()
    var arrayClasses = [ClassModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initCalender()
        GoogleAnalyticsHandler.instance.screenView(screenName: "ScheduleVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }

    func initCalender() {
        viewCalendar.scope = .week
        viewCalendar.select(Date())
        let calanderDate = Calendar.current.dateComponents([.weekday], from: Date())
        viewCalendar.firstWeekday = UInt(calanderDate.weekday ?? 1)
        viewCalendar.appearance.titleFont = .systemFont(ofSize: 15)
        viewCalendar.appearance.subtitleFont = .systemFont(ofSize: 20)
    }
    
    func getData() {
        showIndicator()
        viewNoSessions.isHidden = true
        tableView.isHidden = true
        arrayClasses.removeAll()
        tableView.reloadData()
        AppConnectionsHandler.get(url: AppUrl.instance.getSessionsInDate(getSelectedDateFormatted()), headers: GET_DEFAULT_HEADERS(), type: SessionsResponseModel.self) { (status, model, error) in
            self.showIndicator(false)
            switch status {
            case .sucess:
                let model = model as! SessionsResponseModel
                self.arrayClasses = model.classes ?? [ClassModel]()
                if self.arrayClasses.count == 0 {
                    self.tableView.isHidden = true
                    self.viewNoSessions.isHidden = false
                } else {
                    self.tableView.isHidden = false
                    self.viewNoSessions.isHidden = true
                    self.tableView.reloadData()
                }
                break
            case .error:
                self.viewNoSessions.isHidden = false
                break
            }
        }
    }
    
    func getSelectedDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: selectedDate)
    }
}

class SessionsResponseModel: Codable {
    let classes: [ClassModel]?
}
