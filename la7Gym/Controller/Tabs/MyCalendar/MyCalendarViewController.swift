//
//  MyCalendarViewController.swift
//  la7Gym
//
//  Created by Mohamed on 06/09/2021.
//

import UIKit
import FSCalendar

class MyCalendarViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBOutlet weak var viewCalendar: FSCalendar!
    @IBOutlet weak var viewNoSessions: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnBookATour: UIButton!
    @IBOutlet weak var labelLogin: UILabel!
    @IBOutlet weak var viewNotAAMember: UIView!
    
    var selectedDate = Date()
    var arrayClasses = [ClassModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initCalender()
        GoogleAnalyticsHandler.instance.screenView(screenName: "MyCalenderVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.getDatabaseToken() == "" {
            viewNotAAMember.isHidden = false
            labelLogin.setSpecificAttributes(texts: ["Already have an account? ", "Log In"], fonts: [.systemFont(ofSize: 14), .boldSystemFont(ofSize: 14)], colors: [.white, .fromHex(hex: "FFE800")])
            labelLogin.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gotoLogin)))
            viewNoSessions.isHidden = true
            btnBookATour.layer.cornerRadius = 25
        } else {
            viewNotAAMember.isHidden = true
            getData()
        }
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
        
        print("GetSessionsInDate: \(AppUrl.instance.getSessionsInDate(getSelectedDateFormatted()))")

        
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
    
    @IBAction func bookATour(_ sender: Any) {
        navigationController?.pushViewController(BookATourViewController(), animated: true)
    }
    
    @objc func gotoLogin() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}
