//
//  DateManager.swift
//  CinemaDB
//
//  Created by Deepak on 6/25/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import Foundation

extension Date {
    static func today() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = .current
        
        let currentDate = Date()
        return dateFormatter.string(from: currentDate)
    }
}
