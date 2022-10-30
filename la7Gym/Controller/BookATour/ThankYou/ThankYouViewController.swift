//
//  ThankYouViewController.swift
//  la7Gym
//
//  Created by Mohamed on 6/22/21.
//

import UIKit

class ThankYouViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            guard let nav = self.navigationController else { return }
            nav.popToViewController(nav.viewControllers[nav.viewControllers.count - 3], animated: true)
        }
        GoogleAnalyticsHandler.instance.screenView(screenName: "ThankYouVC")
    }
}
