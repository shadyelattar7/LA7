//
//  UIImageExtension.swift
//  Safir El3rood
//
//  Created by mohamed elmaazy on 7/26/18.
//  Copyright © 2018 Internet Plus. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func getThumbnial() -> UIImage {
        var width:CGFloat = 0.0
        var height:CGFloat = 0.0
        if self.size.width > 512 {
            width = 512
            let ratio = self.size.width / width
            height = self.size.height / ratio
        } else {
            width = self.size.width
            height = self.size.height
        }
        let originalImage = self
        let destinationSize = CGSize.init(width: width, height: height)
        UIGraphicsBeginImageContext(destinationSize)
        originalImage.draw(in: CGRect.init(x: 0, y: 0, width: destinationSize.width, height: destinationSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func getBase64() -> String {
        let imageData:NSData = self.getThumbnial().jpegData(compressionQuality: 1.0)! as NSData
        let imageBase64 = imageData.base64EncodedData(options: NSData.Base64EncodingOptions.endLineWithLineFeed)
        var imageString = String(data: imageBase64 as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        imageString = imageString.replacingOccurrences(of: " ", with: "")
        imageString = imageString.replacingOccurrences(of: "\n", with: "")
        imageString = "data:image/png;base64," + imageString
        return imageString
    }
    
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }

}
