//
//  InterestsViewControllerExtensions.swift
//  la7Gym
//
//  Created by Mohamed on 6/7/21.
//

import Foundation
import TTGTags

extension InterestsViewController: TTGTextTagCollectionViewDelegate {
    
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTap tag: TTGTextTag!, at index: UInt) {
        interests[Int(index)].selected = tag.selected ? "1" : "0"
        if viewTags.allSelectedTags()?.count ?? 0 > 0 {
            btnContinue.isHidden = false
        } else {
            btnContinue.isHidden = true
        }
    }
}
