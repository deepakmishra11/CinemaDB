//
//  BaseNavigationController.swift
//  CinemaDB
//
//  Created by Deepak on 6/24/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor.white
        navigationBarAppearance.barTintColor = UIColor(color: .AppColor)
        navigationBarAppearance.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationBarAppearance.isTranslucent = false
        navigationBarAppearance.setBackgroundImage(UIImage(), for: .default)
        navigationBarAppearance.shadowImage = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
