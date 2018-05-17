//
//  DataSerVice.swift
//  Weather
//
//  Created by NguyenDinhPhu on 5/17/18.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit

class DataService {
    static let shared: DataService = DataService()
    
    var weather: Weather?
    
    func getData() {
        let urlString = "http://api.apixu.com/v1/forecast.json?key=c34dc1a7180545b381731540181705&q=Hanoi&days=8"
        let url = URL(string : urlString)!
        
        let urlRequest = URLRequest(url: url)
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                guard let aData = data else { return}
                
                do {
                    if let result = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers) as? DICT {
                        self.weather = Weather(dict: result)
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: Notification.Name.init("update"), object: nil)
                        }
                        print(result)
                    }
                    
                    
                }
                catch {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
        }
    }
