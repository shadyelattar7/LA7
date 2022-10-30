//
//  SubmitPTRequestViewControllerExtensions.swift
//  la7Gym
//
//  Created by Mohamed on 17/09/2021.
//

import Foundation

extension SubmitPTRequestViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTableView() {
        tableViewsDays.register(DayWithTimesTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDays.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as DayWithTimesTableViewCell
        cell.selectionStyle = .none
        cell.index = indexPath.row
        cell.delegate = self
        cell.setData(arrayDays[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension SubmitPTRequestViewController: DayWithTimeDelegate {
    
    func openFrom(_ index: Int) {
        let vc = ChooseTimePopupViewController(isFrom: true, index: index)
        vc.delegate = self
        AppPopUpHandler.instance.openVC(vc, height: 350)
    }
    
    func openTo(_ index: Int) {
        if arrayDays[index].fromHour == -1 {
            AppPopUpHandler.instance.initHintPopUp(container: self, message: "Please choose time from first")
        } else {
            let vc = ChooseTimePopupViewController(isFrom: false, index: index)
            vc.delegate = self
            AppPopUpHandler.instance.openVC(vc, height: 350)
        }
    }
}

extension SubmitPTRequestViewController: ChooseTimePopupDelegate {
    
    func returnWithTime(date: Date, isFrom: Bool, index: Int) {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "hh:mm"
        if isFrom {
            arrayDays[index].toHour = -1
            arrayDays[index].toMin = -1
            arrayDays[index].to = ""
            arrayDays[index].toCell = ""
            arrayDays[index].fromHour = hour
            arrayDays[index].fromMin = minute
            arrayDays[index].fromCell = formatter.string(from: date)
            arrayDays[index].from = formatter2.string(from: date)
            if arrayDays.filter({$0.fromHour == -1}).count > 0 {
                for item in arrayDays {
                    item.toHour = -1
                    item.toMin = -1
                    item.to = ""
                    item.toCell = ""
                    item.fromHour = hour
                    item.fromMin = minute
                    item.fromCell = formatter.string(from: date)
                    item.from = formatter2.string(from: date)
                }
            }
        } else {
            if arrayDays[index].fromHour > hour || (arrayDays[index].fromHour == hour && arrayDays[index].fromMin >= minute) {
                AppPopUpHandler.instance.initHintPopUp(container: self, message: "Time to should be greater than time from")
            } else {
                arrayDays[index].toHour = hour
                arrayDays[index].toMin = minute
                arrayDays[index].toCell = formatter.string(from: date)
                arrayDays[index].to = formatter2.string(from: date)
                if arrayDays.filter({$0.toHour == -1}).count > 0 {
                    for item in arrayDays {
                        item.toHour = hour
                        item.toMin = minute
                        item.toCell = formatter.string(from: date)
                        item.to = formatter2.string(from: date)
                    }
                }
            }
        }
        tableViewsDays.reloadData()
    }
}

extension SubmitPTRequestViewController: HintPopupDelegate {
    
    func hintPopupReturn(type: String) {
        if type == "back" {
            guard let nav = navigationController else { return }
            nav.popToViewController(nav.viewControllers[nav.viewControllers.count - 3], animated: true)
        }
    }
}
