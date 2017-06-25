//
//  UIImageViewExtensions.swift
//  CinemaDB
//
//  Created by Deepak on 6/25/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = UIImage()
        weak var weakSelf: UIImageView! = self
        URLSession.shared.dataTask(with: NSURL(string: "\(IMAGE_URL)\(urlString)")! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }else if let imageData = data {
                let image = UIImage(data: imageData)
                DispatchQueue.main.async(execute: { () -> Void in
                    if weakSelf != nil {
                        self.image = image
                    }
                })
            }
        }).resume()
    }
}
