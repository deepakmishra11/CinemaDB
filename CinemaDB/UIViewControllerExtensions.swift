//
//  UIViewControllerExtensions.swift
//  CinemaDB
//
//  Created by Deepak on 6/25/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController: NVActivityIndicatorViewable { }

extension UIViewController {
    func performSegue(segue: Segue, sender: Any? = nil) {
        self.performSegue(withIdentifier: segue.rawValue, sender: sender)
    }
}
