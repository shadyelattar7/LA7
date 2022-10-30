//
//  ClassDetailsViewControllerExtensions.swift
//  la7Gym
//
//  Created by Mohamed on 6/19/21.
//

import Foundation
import FSPagerView

extension ClassDetailsViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    
    func initViewPager() {
        viewPager.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        viewPager.automaticSlidingInterval = 5
        viewPager.contentMode = .scaleAspectFill
        viewPager.layer.cornerRadius = 20
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return arrayPager.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.loadFromUrl(url: arrayPager[index])
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
//        let configuration = ImageViewerConfiguration { config in
//            config.imageView = selectedImage
//        }
//        let imageViewerController = ImageViewerController(configuration: configuration)
//        present(imageViewerController, animated: true)
        OPEN_IMAGE_VIEW(imageView: selectedImage, vc: self)
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        selectedImage = cell.imageView!
//        labelViewPagerCount.text = "\(index + 1)/\(itemModel?.photos?.count ?? 0)"
    }
}

extension ClassDetailsViewController: BookClassPopupDelegate {
    
    func classBooked() {
        getData()
    }
}

extension ClassDetailsViewController: OptionPopupDelegate {
    
    func makeConfirm(ok: Bool, type: String) {
        if ok {
            if type == "cancel" {
                showIndicator()
                var params = GET_DEFAULT_PARAMS()
                params.updateValue(classDetails?.id ?? "", forKey: "class_id")
                params.updateValue(UserDefaults.standard.getUser()?.id ?? "", forKey: "user_id")
                AppConnectionsHandler.post(url: AppUrl.instance.cancelClass(), params: params, headers: GET_DEFAULT_HEADERS(), type: ClassDetailsResponseModel.self) { (status, model, error) in
                    self.showIndicator(false)
                    switch status {
                    case .sucess:
                        AppPopUpHandler.instance.initHintPopUp(container: self, message: "Class cancelled", type: "back")
                        break
                    case .error:
                        AppPopUpHandler.instance.initHintPopUp(container: self, message: error ?? "")
                        break
                    }
                }
            }
        }
    }
}

extension ClassDetailsViewController: HintPopupDelegate {
    
    func hintPopupReturn(type: String) {
        if type == "back" {
            navigationController?.popViewController(animated: true)
        }
    }
}
