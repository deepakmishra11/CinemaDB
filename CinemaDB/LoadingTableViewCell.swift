//
//  LoadingTableViewCell.swift
//  CinemaDB
//
//  Created by Deepak on 6/25/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var loadingView: NVActivityIndicatorView! {
        didSet {
            loadingView.isHidden = true
            loadingView.type = .lineScalePulseOutRapid
            loadingView.color = UIColor(color: .AppColor)
        }
    }
}
