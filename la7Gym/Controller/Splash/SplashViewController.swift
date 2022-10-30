//
//  ViewController.swift
//  la7Gym
//
//  Created by Mohamed on 4/20/21.
//

import UIKit

class SplashViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GoogleAnalyticsHandler.instance.screenView(screenName: "SplashVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.navigationController?.pushViewController(UserDefaults.standard.getDatabaseToken() == "" ? GetStartViewController() : TabsViewController(), animated: true)
        }
    }
}
