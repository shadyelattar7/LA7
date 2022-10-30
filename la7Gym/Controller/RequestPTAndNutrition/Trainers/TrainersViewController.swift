//
//  TrainersViewController.swift
//  la7Gym
//
//  Created by Mohamed on 16/09/2021.
//

import UIKit

protocol TrainerControllerDelegate {
    func selectedTrainers(_ trainers: [TrainerModel])
}

class TrainersViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAdd: UIButton!
    
    var arrayTrainers = [TrainerModel]()
    var arraySelectedTrainers = [TrainerModel]()
    var delegate: TrainerControllerDelegate?
    var gender = ""
    
    init(arraySelectedTrainers: [TrainerModel], gender: String) {
        self.arraySelectedTrainers = arraySelectedTrainers
        self.gender = gender
        super.init(nibName: "TrainersViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        btnAdd.setBorder(color: .white, radius: 25, borderWidth: 1)
        getData()
        GoogleAnalyticsHandler.instance.screenView(screenName: "RequestPtOrNutrationTrainersVC")
    }
    
    func getData() {
        showIndicator()
        let url = "\(AppUrl.instance.getTrainers())?gender=\(gender)"
        AppConnectionsHandler.get(url: url, headers: GET_DEFAULT_HEADERS(), type: TrainersResponseModel.self) { (status, model, error) in
            self.showIndicator(false)
            switch status {
            case .sucess:
                let model = model as! TrainersResponseModel
                self.arrayTrainers = model.trainers ?? [TrainerModel]()
                for selectedTrainer in self.arraySelectedTrainers {
                    for trainer in self.arrayTrainers {
                        if selectedTrainer.id == trainer.id {
                            trainer.selected = true
                            break
                        }
                    }
                }
                self.tableView.reloadData()
                break
            case .error:
//                self.viewError.isHidden = false
//                self.labelError.text = error ?? ""
                break
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func add(_ sender: Any) {
        delegate?.selectedTrainers(arrayTrainers.filter({$0.selected ?? false}))
        navigationController?.popViewController(animated: true)
    }
}

class TrainersResponseModel: Codable {
    let trainers: [TrainerModel]?
}
