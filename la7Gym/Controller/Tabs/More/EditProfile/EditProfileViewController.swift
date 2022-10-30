//
//  EditProfileViewController.swift
//  la7Gym
//
//  Created by Mohamed on 20/09/2021.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var viewData: UIView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageViewEdit: UIImageView!
    @IBOutlet weak var labelMember: UILabel!
    @IBOutlet weak var labelGender: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelWeight: UILabel!
    @IBOutlet weak var labelHeight: UILabel!
    @IBOutlet weak var labelNotes: UILabel!
    
    var userModel: UserModel?
    
    init(userModel: UserModel) {
        self.userModel = userModel
        super.init(nibName: "EditProfileViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewData.layer.cornerRadius = 20
        btnLogout.setBorder(color: .white, radius: 20, borderWidth: 1)
        imageViewEdit.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editData)))
        labelName.text = "\(userModel?.first_name ?? "") \(userModel?.last_name ?? "")"
        labelMember.text = userModel?.membership_id ?? ""
        labelGender.text = userModel?.gender ?? ""
        labelPhone.text = userModel?.phone ?? ""
        labelEmail.text = userModel?.email ?? ""
        labelWeight.text = userModel?.weight ?? ""
        labelHeight.text = userModel?.height ?? ""
        labelNotes.text = userModel?.notes ?? ""
        GoogleAnalyticsHandler.instance.screenView(screenName: "EditProfileVC")
    }
    
    @objc func editData() {
        
    }

    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changePassword(_ sender: Any) {
        navigationController?.pushViewController(ChangePasswordViewController(), animated: true)
    }
    
    @IBAction func logout(_ sender: Any) {
        AppPopUpHandler.instance.initOptionPopUp(container: self, message: "Are you sure you  want to logout?", type: "logout")
    }
}

extension EditProfileViewController: OptionPopupDelegate {
    
    func makeConfirm(ok: Bool, type: String) {
        if ok {
            if type == "logout" {
                let firebaseToken = UserDefaults.standard.getFirebaseToken()
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                UserDefaults.standard.setFirebaseToken(firebaseToken)
                navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
