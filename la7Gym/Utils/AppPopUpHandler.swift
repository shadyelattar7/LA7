//
//  AppPopUpHandler.swift
//  Rateb
//
//  Created by Ebrahim on 6/3/18.
//  Copyright © 2018 Ebrahim. All rights reserved.
//

import Foundation
import PopupDialog
import MZFormSheetController

class AppPopUpHandler {
    
    static let instance = AppPopUpHandler()
    private init () {}
    
    func initListPopup(container:UIViewController, arrayNames: [String], title: String, type: String , center: Bool = false) {
//        let vc = ListPopupViewController(arrayNames: arrayNames, header: title, type: type)
//        vc.listPopupDelegate = container as? ListPopupDelegate
//        let formSheet = MZFormSheetController.init(viewController: vc)
//        formSheet.shouldDismissOnBackgroundViewTap = true
//        formSheet.transitionStyle = .slideFromBottom
//        formSheet.cornerRadius = GET_RATIO(20)
//        formSheet.portraitTopInset = UIScreen.main.bounds.height * 0.5
//        formSheet.presentedFormSheetSize = CGSize.init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.45)
//        formSheet.present(animated: true, completionHandler: nil)
    }
    
    func initHintPopUp(container: UIViewController, message: String, type: String = "") {
        let vc = HintPopupViewController(message: message, type: type)
        vc.delegate = container as? HintPopupDelegate
        let popup = PopupDialog(viewController: vc, buttonAlignment: .horizontal, transitionStyle: .zoomIn, preferredWidth: 300, tapGestureDismissal: false)
        container.present(popup, animated: true, completion: nil)
    }
    
    func initOptionPopUp(container: UIViewController, message: String, type: String = "") {
        let vc = OptionPopupViewController.init(message: message, type: type)
        vc.delegate = container as? OptionPopupDelegate
        let popup = PopupDialog(viewController: vc, buttonAlignment: .horizontal, transitionStyle: .zoomIn, preferredWidth: 300, tapGestureDismissal: true, panGestureDismissal: true)
        container.present(popup, animated: true, completion: nil)
    }
    
    func openVC(_ vc: UIViewController, height: CGFloat, centerInScreen: Bool = true, width: CGFloat = UIScreen.main.bounds.width) {
        let formSheet = MZFormSheetController.init(viewController: vc)
        formSheet.shouldDismissOnBackgroundViewTap = true
        formSheet.transitionStyle = .slideFromTop
        formSheet.presentedFormSheetSize = CGSize.init(width: width, height: height)
        if centerInScreen {
            formSheet.shouldCenterVertically = true
        } else {
            formSheet.portraitTopInset = GET_RATIO(60)
        }
        formSheet.present(animated: true, completionHandler: nil)
    }
}
