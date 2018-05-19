//
//  Extention.swift
//  Weather
//
//  Created by NguyenDinhPhu on 5/17/18.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit

extension UIImageView {
    func download (from urlString : String){
        if let url = URL(string : urlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf : url){
                    DispatchQueue.main.async {
                        self.image = UIImage(data : data)
                    }
                }
            }
        }
    }
}
extension UIImageView {
    func getGifCell(urlString : String) {
        if let url = URL(string: urlString){
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.image = UIImage.animatedImage(data: data)
                    }
                }
                
            }
        }
        
    }
}
