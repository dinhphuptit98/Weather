//
//  TimeInterval+Extention.swift
//  Weather
//
//  Created by NguyenDinhPhu on 5/18/18.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import Foundation

extension TimeInterval {
    var toDay: String {
        get {
            let date = Date(timeIntervalSince1970: self)
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MMMM-d"
            return formatter.string(from: date)
        }
    }
    var toDate: String {
        get {
            let date = Date(timeIntervalSince1970: self)
            let formatter = DateFormatter()
            formatter.dateFormat = "eeee"
            formatter.locale = Locale(identifier: "vi_VN")
            return formatter.string(from: date)
        }
    }
}
