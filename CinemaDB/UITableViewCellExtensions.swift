//
//  UITableViewCellExtensions.swift
//  CinemaDB
//
//  Created by Deepak on 6/25/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit

extension UITableViewCell: ReusableCell {}

extension UITableView {
    func dequeCellForIndexPath<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.cellIdentifier)")
        }
        return cell
    }
}
