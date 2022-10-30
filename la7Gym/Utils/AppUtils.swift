//
//  AppUtils.swift
//  Youmeda
//
//  Created by Mohamed on 1/9/21.
//

import Foundation
import UIKit

func GET_DEFAULT_HEADERS() -> [String: String] {
    print("Bearer \(UserDefaults.standard.getDatabaseToken())")
    return["Accept": "application/json",
//           "Accept-Language": "\(MOLHLanguage.currentAppleLanguage())",
           "Authorization": "Bearer \(UserDefaults.standard.getDatabaseToken())",
           "sico-sico": "9b62d9787d5777e6a18b58f581e31245"]
}

func GET_DEFAULT_PARAMS() -> [String: Any] {
    return [:]
}

func LOGOUT() {
    UserDefaults.standard.setDatabaseToken("")
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    if let nav = appDelegate.window!.rootViewController as? UINavigationController {
        nav.popToRootViewController(animated: true)
    }
}

func GET_RATIO(_ number: CGFloat) -> CGFloat {
    return number * UIScreen.main.bounds.width / 360
}

func POST_NOTIFICATION(_ name: Notification.Name, object: Notification? = nil) {
    NotificationCenter.default.post(name: name, object: object)
//    let dic = notification.object as? [String: Any] ?? [String: Any]()
}

func GET_FONT_FAMILY_NAME(_ name: String) -> String {
    let nameArr = name.components(separatedBy: "-")
    if nameArr.count > 1 {
        switch nameArr[1].lowercased() {
        case "light":
            return "helvetica_neue_bold"
        case "medium":
            return "helvetica_neue_medium"
        case "roman":
            return "helvetica_neue_oblique"
        case "book":
            return "helvetica_neue_regular"
        case "heavy":
            return "helvetica_neue_bold"
        case "bold":
            return "helvetica_neue_bold"
        default:
            return "helvetica_neue_medium"
        }
    }
    return "helvetica_neue_medium"
}

func OPEN_IMAGE_VIEW(imageView: UIImageView, vc: UIViewController) {
    let imageInfo = JTSImageInfo()
    imageInfo.image = imageView.image
    imageInfo.referenceRect = imageView.frame;
    imageInfo.referenceView = imageView.superview;
    imageInfo.referenceContentMode = imageView.contentMode;
    imageInfo.referenceCornerRadius = imageView.layer.cornerRadius;
    
    let imageViewer = JTSImageViewController(imageInfo: imageInfo, mode:.image, backgroundStyle: .scaled)
    
    imageViewer?.show(from: vc, transition: .fromOriginalPosition)
}
