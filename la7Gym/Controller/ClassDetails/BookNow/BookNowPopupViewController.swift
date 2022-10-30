//
//  BookNowPopupViewController.swift
//  la7Gym
//
//  Created by Mohamed on 16/09/2021.
//

import UIKit

protocol BookClassPopupDelegate {
    func classBooked()
}

class BookNowPopupViewController: UIViewController {

    @IBOutlet weak var viewClassData: UIView!
    @IBOutlet weak var imageViewClass: UIImageView!
    @IBOutlet weak var labelNameClass: UILabel!
    @IBOutlet weak var labelTrainer: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    
    var modelClass: ClassModel?
    var delegate: BookClassPopupDelegate?
    
    init(modelClass: ClassModel) {
        self.modelClass = modelClass
        super.init(nibName: "BookNowPopupViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewClassData.layer.cornerRadius = 20
        imageViewClass.layer.cornerRadius = 8
        viewTime.layer.cornerRadius = 25
        btnConfirm.setBorder(color: .white, radius: 25, borderWidth: 1)
        imageViewClass.loadFromUrl(url: modelClass?.image_path ?? "")
        labelNameClass.text = modelClass?.title ?? ""
        labelTrainer.text = modelClass?.instructor ?? ""
        labelDay.text = modelClass?.date ?? ""
        labelTime.text = "\(modelClass?.time_from ?? "") - \(modelClass?.time_to ?? "")"
        GoogleAnalyticsHandler.instance.screenView(screenName: "BookNowPopupVC")
    }

    @IBAction func book(_ sender: Any) {
        showIndicator()
        let params = ["class_id": modelClass?.id ?? "",
                      "user_id": UserDefaults.standard.getUser()?.id ?? ""]
        AppConnectionsHandler.post(url: AppUrl.instance.bookClass(), params: params, headers: GET_DEFAULT_HEADERS(), type: StatusModel.self) { (status, model, error) in
            self.showIndicator(false)
            switch status {
            case .sucess:
                GoogleAnalyticsHandler.instance.bookClass(classId: self.modelClass?.id ?? "")
                self.mz_dismissFormSheetController(animated: true) { [weak self] _ in
                    self?.delegate?.classBooked()
                }
                break
            case .error:
                AppPopUpHandler.instance.initHintPopUp(container: self, message: error ?? "")
                break
            }
        }
    }
}
