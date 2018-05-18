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
    
    // Weather 7 days
    var weather: Weather?
    
    func getDataDay() {
        let urlString = "http://api.apixu.com/v1/forecast.json?key=9e44af53443843b3bcc03842181705&q=Hanoi&days=7&lang=vi"
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
                            NotificationCenter.default.post(name: Notification.Name.init("update1"), object: nil)
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
    
    //weather 24h
    var weatherOneDay : WeatherOneDay?
    
    func getDataHour() {
        let urlString = "http://api.worldweatheronline.com/premium/v1/weather.ashx?key=1077b818e76a4315a6a80859181805&q=Hanoi&format=json&num_of_days=1&fx24=yes&tp=1&lang=vi"
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
                        self.weatherOneDay = WeatherOneDay(dict: result)
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: Notification.Name.init("update2"), object: nil)
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
