//
//  DashboardViewController.swift
//  la7Gym
//
//  Created by Mohamed on 6/3/21.
//

import UIKit
import FSPagerView

class DashboardViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var labelHi: UILabel!
    @IBOutlet weak var viewPager: FSPagerView!
    @IBOutlet weak var viewError: UIView!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var collectionViewClasses: UICollectionView!
    @IBOutlet weak var btnBookATour: UIButton!
    @IBOutlet weak var btnPickAnotherBranch: UIButton!
    @IBOutlet weak var labelLogin: UILabel!
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var labelStatusName: UILabel!
    @IBOutlet weak var labelStatusCapacity: UILabel!
    @IBOutlet weak var labelStatusDate: UILabel!
    @IBOutlet weak var viewSliderHolder: UIView!
    @IBOutlet weak var viewPickAnotherBranch: UIView!
    @IBOutlet weak var viewBookATour: UIView!
    @IBOutlet weak var viewProgress: UIProgressView!
    @IBOutlet weak var viewToDayClasses: UIView!
    @IBOutlet weak var viewNextClasses: UIView!
    @IBOutlet weak var collectionViewNextClasses: UICollectionView!
    @IBOutlet weak var viewRequestPT: UIView!
    @IBOutlet weak var viewRequestNutrition: UIView!
    @IBOutlet weak var viewRequestPTNutrition: UIView!
    
    var selectedImage = UIImageView()
    var branchDetails: BranchModel?
    var arrayFacilities = [FacilityModel]()
    var arrayClasses = [ClassModel]()
    var arrayNextClasses = [ClassModel]()
    let group = DispatchGroup()
    var apisReturnSuccess = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        labelHi.text = "Hi \(UserDefaults.standard.getUserName())!"
        GoogleAnalyticsHandler.instance.screenView(screenName: "DashboardVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initViews()
    }
    
    func initViews() {
        if UserDefaults.standard.getDatabaseToken() == "" {
            viewStatus.isHidden = true
            getBranchData()
            initViewPager()
            labelLogin.setSpecificAttributes(texts: ["Already have an account? ", "Log In"], fonts: [.systemFont(ofSize: 14), .boldSystemFont(ofSize: 14)], colors: [.white, .fromHex(hex: "FFE800")])
            labelLogin.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gotoLogin)))
            btnBookATour.layer.cornerRadius = 23
            btnPickAnotherBranch.setBorder(color: .white, radius: 23, borderWidth: 2)
            viewNextClasses.isHidden = true
            viewRequestPTNutrition.isHidden = true
        } else {
            viewSliderHolder.isHidden = true
            labelLogin.isHidden = true
            viewBookATour.isHidden = true
            viewPickAnotherBranch.isHidden = true
            showIndicator()
            viewError.isHidden = true
            scrollView.isHidden = true
            getBranchCapacity()
            getHomeData()
            group.notify(queue: .main) {
                self.showIndicator(false)
                if self.apisReturnSuccess {
                    self.scrollView.isHidden = false
                    if self.arrayClasses.count == 0 {
                        self.viewToDayClasses.isHidden = true
                    }
                    if self.arrayNextClasses.count == 0 {
                        self.viewNextClasses.isHidden = true
                    } else {
                        self.viewNextClasses.isHidden = false
                    }
                    self.collectionViewClasses.reloadData()
                    self.collectionViewNextClasses.reloadData()
                } else {
                    self.viewError.isHidden = false
                }
            }
            viewRequestPT.layer.cornerRadius = 8
            viewRequestNutrition.layer.cornerRadius = 8
            viewRequestPT.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(requestPT)))
            viewRequestNutrition.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(requestNutrition)))
        }
    }

    func getBranchData() {
        showIndicator()
        viewError.isHidden = true
        scrollView.isHidden = true
        AppConnectionsHandler.get(url: AppUrl.instance.branchDetails(UserDefaults.standard.getSelectedBranch()?.id ?? ""), headers: GET_DEFAULT_HEADERS(), type: BranchDetailsResponseModel.self) { (status, model, error) in
            self.showIndicator(false)
            switch status {
            case .sucess:
                self.scrollView.isHidden = false
                let model = model as! BranchDetailsResponseModel
                self.branchDetails = model.details
                self.updateViews()
                break
            case .error:
                self.viewError.isHidden = false
                self.labelError.text = error ?? ""
                break
            }
        }
    }
    
    func getBranchCapacity() {
        group.enter()
        AppConnectionsHandler.get(url: AppUrl.instance.branchCapacity(UserDefaults.standard.getSelectedBranch()?.id ?? ""), headers: GET_DEFAULT_HEADERS(), type: BranchCapacityResponseModel.self) { (status, model, error) in
            self.showIndicator(false)
            switch status {
            case .sucess:
                let model = model as! BranchCapacityResponseModel
                self.labelStatusName.text = "\(model.details?.name ?? "") Capacity"
                self.labelStatusCapacity.text = model.details?.capacity ?? ""
                self.labelStatusDate.text = model.details?.last_updated ?? ""
                print((model.details?.capacity ?? "").lowercased())
                switch (model.details?.capacity ?? "").lowercased() {
                case "low":
                    self.viewProgress.setProgress(0.30, animated: true)
                    self.viewProgress.tintColor = .green
                    self.labelStatusCapacity.textColor = .green
                    break
                case "medium":
                    self.viewProgress.setProgress(0.60, animated: true)
                    self.viewProgress.tintColor = .orange
                    self.labelStatusCapacity.textColor = .orange
                    break
                case "high":
                    self.viewProgress.setProgress(1, animated: true)
                    self.viewProgress.tintColor = .red
                    self.labelStatusCapacity.textColor = .red
                    break
                default:
                    break
                }
                break
            case .error:
                self.apisReturnSuccess = false
                self.labelError.text = error ?? ""
                break
            }
            self.group.leave()
        }
    }
    
    func getHomeData() {
        group.enter()
        AppConnectionsHandler.get(url: AppUrl.instance.homeData(), headers: GET_DEFAULT_HEADERS(), type: HomeResponseModel.self) { (status, model, error) in
            self.showIndicator(false)
            switch status {
            case .sucess:
                let model = model as! HomeResponseModel
                self.arrayClasses = model.todays_classes ?? [ClassModel]()
                self.arrayNextClasses = model.next_appointments ?? [ClassModel]()
                break
            case .error:
                self.apisReturnSuccess = false
                self.labelError.text = error ?? ""
                break
            }
            self.group.leave()
        }
    }
    
    func updateViews() {
        guard let branchDetails = branchDetails else { return }
        arrayFacilities = branchDetails.facilities ?? [FacilityModel]()
        viewPager.reloadData()
        viewToDayClasses.isHidden = true
//        arrayClasses = branchDetails.classes ?? [ClassModel]()
//        collectionViewClasses.reloadData()
    }
    
    @IBAction func retry(_ sender: Any) {
        if UserDefaults.standard.getDatabaseToken() == "" {
            getBranchData()
        } else {
            showIndicator()
            viewError.isHidden = true
            scrollView.isHidden = true
            getBranchCapacity()
            getHomeData()
        }
    }
    
    @IBAction func pickAnotherBranch(_ sender: Any) {
        if navigationController?.viewControllers.count ?? 0 > 3 {
            navigationController?.popToViewController(navigationController!.viewControllers[2], animated: true)
        }
    }
    
    @IBAction func bookATour(_ sender: Any) {
        navigationController?.pushViewController(BookATourViewController(), animated: true)
    }
    
    @objc func requestNutrition() {
        navigationController?.pushViewController(RequestPTAndNutritionViewController(isPT: false), animated: true)
    }
    
    @objc func requestPT() {
        navigationController?.pushViewController(RequestPTAndNutritionViewController(isPT: true), animated: true)
    }
    
    @objc func gotoLogin() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}

class BranchDetailsResponseModel: Codable {
    let details: BranchModel?
    let other_branches: [BranchModel]?
}

class BranchCapacityResponseModel: Codable {
    let details: BranchCapacityModel?
}

class HomeResponseModel: Codable {
    let next_appointments: [ClassModel]?
    let todays_classes: [ClassModel]?
}
