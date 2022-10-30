//
//  InterestsViewController.swift
//  la7Gym
//
//  Created by Mohamed on 6/7/21.
//

import UIKit
import TTGTags

class InterestsViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var viewTags: TTGTextTagCollectionView!
    
    var interests = [InterestModel]()
    
    init(interests: [InterestModel]) {
        super.init(nibName: "InterestsViewController", bundle: nil)
//        self.interests = interests
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnContinue.isHidden = true
        btnContinue.layer.cornerRadius = 23
        viewTags.verticalSpacing = 20
        viewTags.horizontalSpacing = 20
        viewTags.delegate = self
        getIntersets()
        GoogleAnalyticsHandler.instance.screenView(screenName: "InterestsVC")
    }
    
    func initViews() {
        for text in interests {
            let content = TTGTextTagStringContent.init(text: text.title ?? "")
            content.textColor = .white
            content.textFont = UIFont.boldSystemFont(ofSize: 20)
            
            let normalStyle = TTGTextTagStyle.init()
            normalStyle.backgroundColor = .fromHex(hex: "363636")
            normalStyle.extraSpace = CGSize.init(width: 20, height: 20)
            
            let selectedStyle = TTGTextTagStyle.init()
            selectedStyle.backgroundColor = .fromHex(hex: "1E988A")
            selectedStyle.extraSpace = CGSize.init(width: 20, height: 20)
            
            let tag = TTGTextTag.init()
            tag.content = content
            tag.style = normalStyle
            tag.selectedStyle = selectedStyle
            tag.selected = text.selected ?? "0" == "1"
            viewTags.addTag(tag)
        }
        viewTags.reload()
        if interests.filter({$0.selected ?? "0" == "1"}).count > 0 {
            btnContinue.isHidden = false
        }
    }
    
    func getIntersets() {
        showIndicator()
        AppConnectionsHandler.get(url: AppUrl.instance.getinterests(), headers: GET_DEFAULT_HEADERS(), type: BranchModel.self) { (status, model, error) in
            self.showIndicator(false)
            switch status {
            case .sucess:
                let model = model as! BranchModel
                self.interests = model.interests ?? [InterestModel]()
                self.initViews()
                break
            case .error:
                AppPopUpHandler.instance.initHintPopUp(container: self, message: error ?? "")
                break
            }
        }
    }

    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func `continue`(_ sender: Any) {
        let selectedArray = interests.filter({$0.selected ?? "0" == "1"})
        var params = GET_DEFAULT_PARAMS()
        params.updateValue(selectedArray.map({$0.id ?? ""}), forKey: "interests")
        showIndicator()
        AppConnectionsHandler.post(url: AppUrl.instance.addInterests(), params: params, headers: GET_DEFAULT_HEADERS(), type: UserResponseModel.self) { (status, model, error) in
            self.showIndicator(false)
            self.navigationController?.pushViewController(TabsViewController(), animated: true)
        }
    }
}
