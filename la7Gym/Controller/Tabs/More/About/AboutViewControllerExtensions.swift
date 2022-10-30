//
//  AboutViewControllerExtensions.swift
//  la7Gym
//
//  Created by Mohamed on 24/09/2021.
//

import Foundation
import FSPagerView

extension AboutViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    
    func initViewPager() {
        viewPager.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        viewPager.automaticSlidingInterval = 5
        viewPager.contentMode = .scaleAspectFill
        viewPager.layer.cornerRadius = 20
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return arrayFacilities.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.loadFromUrl(url: arrayFacilities[index].image_path ?? "")
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

extension AboutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTableView() {
        tableView.register(BranchAboutTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayBranches.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as BranchAboutTableViewCell
        cell.selectionStyle = .none
        cell.index = indexPath.row
        cell.delegate = self
        cell.setData(arrayBranches[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension AboutViewController: BranchCellDelegate {
    
    func openBranchLocation(_ index: Int) {
        openWebsite(url: arrayBranches[index].contact_data?.location ?? "")
    }
    
    func callBranch(_ index: Int) {
        call(phoneNumber: arrayBranches[index].contact_data?.phone ?? "")
    }
    
    
}
