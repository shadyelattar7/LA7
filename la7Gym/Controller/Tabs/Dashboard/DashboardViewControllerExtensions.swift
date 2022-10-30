//
//  DashboardViewControllerExtensions.swift
//  la7Gym
//
//  Created by Mohamed on 6/3/21.
//

import Foundation
import FSPagerView

extension DashboardViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    
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

import UIKit

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func initCollectionView() {
        collectionViewClasses.register("ClassCollectionViewCell")
        collectionViewNextClasses.register("NextClassCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewClasses {
            return CGSize(width: collectionView.frame.width * 0.75, height: collectionView.frame.height)
        }
        return CGSize(width: collectionView.frame.width * 0.95, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewClasses {
            return arrayClasses.count
        }
        return arrayNextClasses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewClasses {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassCollectionViewCell", for: indexPath) as! ClassCollectionViewCell
            cell.setData(arrayClasses[indexPath.row])
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NextClassCollectionViewCell", for: indexPath) as! NextClassCollectionViewCell
        cell.setData(arrayNextClasses[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewClasses {
            navigationController?.pushViewController(ClassDetailsViewController(classId: arrayClasses[indexPath.row].id ?? ""), animated: true)
        } else {
            navigationController?.pushViewController(ClassDetailsViewController(classId: arrayNextClasses[indexPath.row].id ?? ""), animated: true)
        }
    }
}
