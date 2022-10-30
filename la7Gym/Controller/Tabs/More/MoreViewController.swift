//
//  MoreViewController.swift
//  la7Gym
//
//  Created by Mohamed on 16/09/2021.
//

import UIKit

class MoreViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSubscriptionType: UILabel!
    @IBOutlet weak var labelExpiration: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewPT: UIView!
    @IBOutlet weak var labelPTProgress: UILabel!
    @IBOutlet weak var labelPTTrainer: UILabel!
    @IBOutlet weak var viewNutration: UIView!
    @IBOutlet weak var labelNutrationProgress: UILabel!
    @IBOutlet weak var labelNutrationTrainer: UILabel!
    @IBOutlet weak var viewPTAssesment: UIView!
    @IBOutlet weak var viewAllClasses: UIView!
    @IBOutlet weak var viewComplaints: UIView!
    @IBOutlet weak var viewAbout: UIView!
    @IBOutlet weak var viewFreezing: UIView!
    @IBOutlet weak var viewInvite: UIView!
    @IBOutlet weak var viewError: UIView!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var imageViewProfile: UIImageView!
    
    var userModel: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewNutration.layer.cornerRadius = 20
        viewPT.layer.cornerRadius = 20
        viewAllClasses.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openAllClasses)))
        viewComplaints.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openComplaints)))
        viewFreezing.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openFreezing)))
        viewInvite.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openInvite)))
        viewProfile.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openProfile)))
        viewAbout.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openAbout)))
        viewPTAssesment.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openGraph)))
        if UserDefaults.standard.getDatabaseToken() == "" {
//            viewProfile.isHidden = false
            labelName.text = "Hi There!"
            labelExpiration.text = "Become a member to access all features"
            labelSubscriptionType.text = ""
            imageViewProfile.isHidden = true
            viewPT.isHidden = true
            viewNutration.isHidden = true
            viewInvite.isHidden = true
            viewFreezing.isHidden = true
            viewPTAssesment.isHidden = true
            viewError.isHidden = true
        } else {
            getData()
        }
        GoogleAnalyticsHandler.instance.screenView(screenName: "MoreVC")
    }
    
    @objc func openAllClasses() {
        navigationController?.pushViewController(AllClassesViewController(), animated: true)
    }
    
    @objc func openComplaints() {
        navigationController?.pushViewController(SuggestionsViewController(), animated: true)
    }
    
    @objc func openFreezing() {
        navigationController?.pushViewController(FreezingAccountViewController(), animated: true)
    }
    
    @objc func openInvite() {
        navigationController?.pushViewController(InvitationRequestViewController(), animated: true)
    }
    
    @objc func openProfile() {
        navigationController?.pushViewController(EditProfileViewController(userModel: userModel!), animated: true)
    }
    
    @objc func openAbout() {
        navigationController?.pushViewController(AboutViewController(), animated: true)
    }
    
    @objc func openGraph() {
        navigationController?.pushViewController(GraphViewController(), animated: true)
    }

    func getData() {
        showIndicator()
        scrollView.isHidden = true
        viewProfile.isHidden = true
        viewError.isHidden = true
        AppConnectionsHandler.get(url: AppUrl.instance.getUser(), headers: GET_DEFAULT_HEADERS(), type: UserResponseModel.self) { (status, model, error) in
            self.showIndicator(false)
            switch status {
            case .sucess:
                let model = model as! UserResponseModel
                self.scrollView.isHidden = false
                self.viewProfile.isHidden = false
                self.userModel = model.user
                self.updateViews()
                break
            case .error:
                self.viewError.isHidden = false
                self.labelError.text = error ?? ""
                break
            }
        }
    }
    
    func updateViews() {
        labelName.text = "\(userModel?.first_name ?? "") \(userModel?.last_name ?? "")"
        labelExpiration.text = "Till \(userModel?.subscription_end_date ?? "")"
    }
    
    @IBAction func retry(_ sender: Any) {
        getData()
    }
}
