//
//  ClassDetailsViewController.swift
//  la7Gym
//
//  Created by Mohamed on 6/19/21.
//

import UIKit
import FSPagerView

class ClassDetailsViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var scrollVoew: UIScrollView!
    @IBOutlet weak var viewBook: UIView!
    @IBOutlet weak var viewPager: FSPagerView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCaptinName: UILabel!
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet weak var labelDetails: UILabel!
    @IBOutlet weak var btnBookNow: UIButton!
    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelFul: UILabel!
    
    var selectedImage = UIImageView()
    var classId = ""
    var classDetails: ClassModel?
    var arrayPager = [String]()
    
    init(classId: String) {
        self.classId = classId
        super.init(nibName: "ClassDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBookNow.layer.cornerRadius = 20
        initViewPager()
        getData()
        GoogleAnalyticsHandler.instance.screenView(screenName: "ClassDetailsVC")
    }
    
    func getData() {
        showIndicator()
        scrollVoew.isHidden = true
        viewBook.isHidden = true
        AppConnectionsHandler.get(url: AppUrl.instance.classDetails(classId), headers: GET_DEFAULT_HEADERS(), type: ClassDetailsResponseModel.self) { (status, model, error) in
            self.showIndicator(false)
            switch status {
            case .sucess:
                self.scrollVoew.isHidden = false
                self.viewBook.isHidden = false
                let model = model as! ClassDetailsResponseModel
                self.classDetails = model.details
                self.updateViews()
                break
            case .error:
//                self.viewError.isHidden = false
//                self.labelError.text = error ?? ""
                break
            }
        }
    }
    
    func updateViews() {
        arrayPager.append(classDetails?.image_path ?? "")
        viewPager.reloadData()
        labelName.text = classDetails?.title ?? ""
        labelCaptinName.text = classDetails?.instructor ?? ""
        labelAge.text = classDetails?.age ?? ""
        getDate()
        labelDetails.text = classDetails?.about ?? ""
        if classDetails?.booked_by_user ?? "" == "1" {
//            btnBookNow.isEnabled = false
//            btnBookNow.alpha = 0.5
            btnBookNow.setTitle("Cancel", for: .normal)
            btnBookNow.backgroundColor = .red
            btnBookNow.setTitleColor(.white, for: .normal)
        } else if (classDetails?.target_type ?? "").lowercased().contains("laides") || (classDetails?.target_type ?? "").lowercased().contains("women") {
            if (UserDefaults.standard.getUser()?.gender ?? "").lowercased() == "female" {
                btnBookNow.isEnabled = true
                btnBookNow.alpha = 1
                btnBookNow.setTitle("Book now", for: .normal)
            } else {
                btnBookNow.isEnabled = false
                btnBookNow.alpha = 0.5
                btnBookNow.setTitle("Women only", for: .normal)
            }
        }
        if classDetails?.is_full ?? "" == "1" {
            labelFul.text = "Full"
        } else {
            labelFul.text = ""
        }
    }
    
    func getDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:classDetails?.date ?? "") ?? Date()
        dateFormatter.dateFormat = "EEE"
        labelDay.text = "\(dateFormatter.string(from: date))"
        labelTime.text = "\(classDetails?.time_from ?? "") - \(classDetails?.time_to ?? "")"
        labelType.text = classDetails?.target_type ?? ""
    }

    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bookNow(_ sender: Any) {
        if UserDefaults.standard.getDatabaseToken() == "" {
            AppPopUpHandler.instance.initOptionPopUp(container: self, message: "You have to login to use this feature", type: "login")
        } else {
            if classDetails?.booked_by_user ?? "" == "1" {
                AppPopUpHandler.instance.initOptionPopUp(container: self, message: "Are you sure you want to cancel this class?", type: "cancel")
            } else {
                let vc = BookNowPopupViewController(modelClass: classDetails!)
                vc.delegate = self
                AppPopUpHandler.instance.openVC(vc, height: 400)
            }
        }
    }
}

class ClassDetailsResponseModel: Codable {
    let details: ClassModel?
}
