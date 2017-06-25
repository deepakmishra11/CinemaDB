//
//  ReusableCell.swift
//  CinemaDB
//
//  Created by Deepak on 6/25/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit

protocol ReusableCell: class {}

extension ReusableCell where Self: UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}
