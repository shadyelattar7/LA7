//
//  RequestPTAndNutritionViewController.swift
//  la7Gym
//
//  Created by Mohamed on 17/08/2021.
//

import UIKit

class RequestPTAndNutritionViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var pickerStartDate: UIDatePicker!
    @IBOutlet weak var viewSun: UIView!
    @IBOutlet weak var viewMon: UIView!
    @IBOutlet weak var viewTue: UIView!
    @IBOutlet weak var viewWed: UIView!
    @IBOutlet weak var viewThu: UIView!
    @IBOutlet weak var viewFri: UIView!
    @IBOutlet weak var viewSat: UIView!
    @IBOutlet weak var btnEither: UIButton!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var imageViewAddNew: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var constraintHeightTableView: NSLayoutConstraint!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var labelPreferredTrainers: UILabel!
    
    var isPT = false
    var arrayDays = [DayModel]()
    var gender = 0
    var arrayTrainers = [TrainerModel]()
    
    init(isPT: Bool) {
        self.isPT = isPT
        super.init(nibName: "RequestPTAndNutritionViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        labelTitle.text = isPT ? "Request PT Session" : "Request Nutrition Session"
        
        for view in pickerStartDate.subviews {
            view.setValue(UIColor.white, forKeyPath: "textColor")
        }
        pickerStartDate.setValue(false, forKey: "highlightsToday")
        pickerStartDate.minimumDate = Date()
        viewSat.layer.cornerRadius = 25
        viewSun.layer.cornerRadius = 25
        viewMon.layer.cornerRadius = 25
        viewTue.layer.cornerRadius = 25
        viewWed.layer.cornerRadius = 25
        viewThu.layer.cornerRadius = 25
        viewFri.layer.cornerRadius = 25
        btnEither.layer.cornerRadius = 25
        btnMale.layer.cornerRadius = 25
        btnFemale.layer.cornerRadius = 25
        btnNext.setBorder(color: .white, radius: 25, borderWidth: 1)
        viewSat.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseSat)))
        viewSun.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseSun)))
        viewMon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseMon)))
        viewTue.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseTue)))
        viewWed.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseWed)))
        viewThu.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseThu)))
        viewFri.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseFri)))
        imageViewAddNew.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openInstuctors)))
        if !isPT {
            labelPreferredTrainers.isHidden = true
            imageViewAddNew.isHidden = true
        }
        GoogleAnalyticsHandler.instance.screenView(screenName: "RequestPtOrNutrationHomeVC")
    }
    
    @objc func chooseSat() {
        viewSat.backgroundColor = checkDayFoundInArray("sat", name: "Saturday", id: "7") ? .clear : .fromHex(hex: "#1E988A")
    }
    
    @objc func chooseSun() {
        viewSun.backgroundColor = checkDayFoundInArray("sun", name: "Sunday", id: "1") ? .clear : .fromHex(hex: "#1E988A")
    }
    
    @objc func chooseMon() {
        viewMon.backgroundColor = checkDayFoundInArray("mon", name: "Monday", id: "2") ? .clear : .fromHex(hex: "#1E988A")
    }
    
    @objc func chooseTue() {
        viewTue.backgroundColor = checkDayFoundInArray("tue", name: "Tuesday", id: "3") ? .clear : .fromHex(hex: "#1E988A")
    }
    
    @objc func chooseWed() {
        viewWed.backgroundColor = checkDayFoundInArray("wed", name: "wednesday", id: "4") ? .clear : .fromHex(hex: "#1E988A")
    }
    
    @objc func chooseThu() {
        viewThu.backgroundColor = checkDayFoundInArray("thu", name: "Thursday", id: "5") ? .clear : .fromHex(hex: "#1E988A")
    }
    
    @objc func chooseFri() {
        viewFri.backgroundColor = checkDayFoundInArray("fri", name: "Friday", id: "6") ? .clear : .fromHex(hex: "#1E988A")
    }
    
    func checkDayFoundInArray(_ symbol: String, name: String, id: String) -> Bool {
        for (i, item) in arrayDays.enumerated() {
            if item.symbol == symbol {
                arrayDays.remove(at: i)
                return true
            }
        }
        let model = DayModel()
        model.symbol = symbol
        model.name = name
        model.id = id
        arrayDays.append(model)
        return false
    }

    @objc func openInstuctors() {
        var trainerGender = ""
        if gender == 0 {
            trainerGender = ""
        } else if gender == 1 {
            trainerGender = "male"
        } else {
            trainerGender = "female"
        }
        let vc = TrainersViewController(arraySelectedTrainers: arrayTrainers, gender: trainerGender)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func either(_ sender: Any) {
        gender = 0
        btnEither.backgroundColor = .fromHex(hex: "1E988A")
        btnMale.backgroundColor = .fromHex(hex: "363636")
        btnFemale.backgroundColor = .fromHex(hex: "363636")
    }
    
    @IBAction func male(_ sender: Any) {
        gender = 1
        btnEither.backgroundColor = .fromHex(hex: "363636")
        btnMale.backgroundColor = .fromHex(hex: "1E988A")
        btnFemale.backgroundColor = .fromHex(hex: "363636")
    }
    
    @IBAction func female(_ sender: Any) {
        gender = 2
        btnEither.backgroundColor = .fromHex(hex: "363636")
        btnMale.backgroundColor = .fromHex(hex: "363636")
        btnFemale.backgroundColor = .fromHex(hex: "1E988A")
    }
    
    @IBAction func nxt(_ sender: Any) {
        if checkData() {
            navigationController?.pushViewController(SubmitPTRequestViewController(isPT: isPT, startDate: pickerStartDate.date, arrayDays: arrayDays, gender: gender, arrayTrainers: arrayTrainers), animated: true)
        }
    }
    
    func checkData() -> Bool {
        if arrayDays.count == 0 {
            AppPopUpHandler.instance.initHintPopUp(container: self, message: "You have to choose suitable days")
            return false
        }
//        else if arrayTrainers.count == 0 {
//            AppPopUpHandler.instance.initHintPopUp(container: self, message: "You have to choose preferred trainers")
//            return false
//        }
        return true
    }
}

class DayModel {
    var id = ""
    var selected = false
    var from = ""
    var to = ""
    var fromCell = ""
    var toCell = ""
    var fromHour = -1
    var fromMin = -1
    var toHour = -1
    var toMin = -1
    var symbol = ""
    var name = ""
}
