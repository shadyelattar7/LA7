//
//  GetStartViewController.swift
//  la7Gym
//
//  Created by Mohamed on 6/2/21.
//

import UIKit
import AVFoundation

class GetStartViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var labelLogin: UILabel!
    @IBOutlet weak var btnVisitor: UIButton!
    @IBOutlet weak var viewVideo: UIView!
    
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelLogin.setSpecificAttributes(texts: ["Already have an account? ", "Log In"], fonts: [.systemFont(ofSize: 14), .boldSystemFont(ofSize: 14)], colors: [.white, .fromHex(hex: "FFE800")])
        btnVisitor.setBorder(color: .white, radius: 23, borderWidth: 2)
        playVideo()
        labelLogin.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(login)))
        GoogleAnalyticsHandler.instance.screenView(screenName: "GetStartedVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let player = player {
            player.play()
        }
    }
    
    func playVideo() {
        guard let path = Bundle.main.path(forResource: "LA7 - V20 Teaser 9-16_1_1_3 2", ofType: "mp4") else {
            return
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resize
        viewVideo.layer.addSublayer(playerLayer)        
        player?.play()
    }
    
    @IBAction func visitor(_ sender: Any) {
        player?.pause()
        navigationController?.pushViewController(BranchesViewController(gotoLogin: false), animated: true)
    }
    
    @objc func login() {
        player?.pause()
        navigationController?.pushViewController(BranchesViewController(gotoLogin: true), animated: true)
    }
}
