//
//  AboutViewController.swift
//  la7Gym
//
//  Created by Mohamed on 23/09/2021.
//

import UIKit
import FSPagerView

class AboutViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewPager: FSPagerView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var imageViewFacebook: UIImageView!
    @IBOutlet weak var imageViewInsta: UIImageView!
    @IBOutlet weak var imageViewWebsite: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contraintHeightTableView: NSLayoutConstraint!
    @IBOutlet weak var imageViewLocation: UIImageView!
    @IBOutlet weak var imageViewCall: UIImageView!
    
    var selectedImage = UIImageView()
    var detailsModel: BranchModel?
    var arrayFacilities = [FacilityModel]()
    var arrayBranches = [BranchModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        initViewPager()
        initTableView()
        imageViewFacebook.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openFacebook)))
        imageViewInsta.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openInstagram)))
        imageViewWebsite.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openBranchWebsite)))
        imageViewLocation.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openLocation)))
        imageViewCall.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openCall)))
        GoogleAnalyticsHandler.instance.screenView(screenName: "AboutAppVC")
    }
    
    @objc func openFacebook() {
        openWebsite(url: detailsModel?.contact_data?.facebook ?? "")
    }
    
    @objc func openInstagram() {
        openWebsite(url: detailsModel?.contact_data?.instagram ?? "")
    }
    
    @objc func openBranchWebsite() {
        openWebsite(url: detailsModel?.contact_data?.website ?? "")
    }
    
    @objc func openLocation() {
        openWebsite(url: detailsModel?.contact_data?.location ?? "")
    }
    
    @objc func openCall() {
        call(phoneNumber: detailsModel?.contact_data?.phone ?? "")
    }
    
    func getData() {
        showIndicator()
        AppConnectionsHandler.get(url: AppUrl.instance.aboutGym(), headers: GET_DEFAULT_HEADERS(), type: BranchDetailsResponseModel.self) { (status, model, error) in
            self.showIndicator(false)
            switch status {
            case .sucess:
                let model = model as! BranchDetailsResponseModel
                self.detailsModel = model.details ?? BranchModel()
                self.arrayBranches = model.other_branches ?? [BranchModel]()
                self.updateViews()
                break
            case .error:
//                AppPopUpHandler.instance.initHintPopUp(container: self, message: error ?? "")
                break
            }
        }
    }
    
    func updateViews() {
        guard let branchDetails = detailsModel else { return }
        arrayFacilities = branchDetails.facilities ?? [FacilityModel]()
        viewPager.reloadData()
        labelName.text = branchDetails.name ?? ""
        labelDescription.text = branchDetails.desc ?? ""
        contraintHeightTableView.constant = CGFloat(arrayBranches.count * 350)
        tableView.reloadData()
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
