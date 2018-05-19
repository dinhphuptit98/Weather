//
//  Weather24h.swift
//  Weather
//
//  Created by NguyenDinhPhu on 5/18/18.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit


class WeatherOneDay {
    
    var weatherHours : [Weather24h] = []
    
    init?(dict : DICT) {
        guard let data = dict["data"] as? DICT else { return nil }
        guard let weather = data["weather"] as? [DICT] else { return nil }
        guard let hourly = weather[0]["hourly"] as? [DICT] else { return nil}
        
        for hourObject in hourly {
            if let hour = Weather24h(dict: hourObject){
                weatherHours.append(hour)
            }
        }
    }
}

struct Weather24h {
    var time : String
    var tempC : String
    var windspeedKmph : String
    var winddir16Point : String
    var value : String
    
    init?(dict : DICT) {
        guard let time = dict["time"] as? String else { return nil }
        guard let tempC = dict["tempC"] as? String else { return nil }
        guard let windspeedKmph = dict["windspeedKmph"] as? String else { return nil }
        guard let winddir16Point = dict["winddir16Point"]  as? String else { return nil }
        guard let weatherIconUrl = dict["weatherIconUrl"] as? [DICT] else { return nil  }
        guard let value = weatherIconUrl[0]["value"] as? String else { return nil }
        
        self.time = time
        self.tempC = tempC
        self.windspeedKmph = windspeedKmph
        self.winddir16Point = winddir16Point
        self.value = value
    }
}
