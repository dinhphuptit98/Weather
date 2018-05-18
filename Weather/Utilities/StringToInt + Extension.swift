//
//  StringToInt + Extension.swift
//  Weather
//
//  Created by dinhphu on 5/18/18.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit

extension String {
    func toInt (from string: String?) -> Int? {
        if string != nil && string != "" {
            return (Int(string!))!/100
        }
        else {
            return nil
        }
    }
}
