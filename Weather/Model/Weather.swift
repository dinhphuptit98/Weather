//
//  Weather.swift
//  Weather
//
//  Created by NguyenDinhPhu on 5/17/18.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

//import UIKit
//
//typealias DICT = Dictionary<AnyHashable,Any>
//
//class Weather {
//    var name: String
//    var localtime_epoch: TimeInterval
//    var temp_c: Double
//    var wind_kph: Double
//    var cloud: Double
//    var condition: Condition
//
//    var weatherDays: [WeatherDay] = []
//
//    init?(dict: DICT) {
//        // location
//        guard let location = dict["location"] as? DICT else { return nil }
//
//        guard let name = location["name"] as? String else { return nil }
//        guard let localtime_epoch = location["localtime_epoch"] as? TimeInterval else { return nil }
//
//        // current
//        guard let current = dict["current"] as? DICT else { return nil }
//
//        guard let cloud = current["cloud"] as? Double else { return nil }
//        guard let temp_c = current["temp_c"] as? Double else { return nil }
//        guard let wind_kph = current["wind_kph"] as? Double else { return nil }
//
//        guard let conditionObject = current["condition"] as? DICT else { return nil }
//        guard let condition = Condition(dict: conditionObject) else { return nil }
//
//        guard let forecastday = dict["forecast"] as? [DICT] else { return nil }
//        for dayObject in forecastday {
//            if let day = WeatherDay(dict: dayObject) {
//                weatherDays.append(day)
//            }
//        }
//
//        self.name = name
//        self.localtime_epoch = localtime_epoch
//        self.temp_c = temp_c
//        self.wind_kph = wind_kph
//        self.cloud = cloud
//        self.condition = condition
//    }
//}
//
//struct WeatherDay {
//    var date_epoch: TimeInterval
//    var maxtemp_c: Double
//    var mintemp_c: Double
//    var condition: Condition
//
//    init?(dict: DICT) {
//        guard let date_epoch = dict["date_epoch"] as? TimeInterval else { return nil }
//        guard let day = dict["day"] as? DICT else { return nil }
//        guard let maxtemp_c = day["maxtemp_c"] as? Double else { return nil }
//        guard let mintemp_c = day["mintemp_c"] as? Double else { return nil }
//        guard let conditionObject = day["condition"] as? DICT else { return nil }
//        guard let condition = Condition(dict: conditionObject) else { return nil }
//
//        self.date_epoch = date_epoch
//        self.maxtemp_c = maxtemp_c
//        self.mintemp_c = mintemp_c
//        self.condition = condition
//    }
//}
//
////condition được sử dụng nhiều lần
//struct Condition {
//    var icon: String
//    var text: String
//    init?(dict: DICT) {
//        guard let text = dict["text"] as? String else { return nil }
//        guard let icon = dict["icon"] as? String else { return nil }
//        self.icon = "http:"+icon
//        self.text = text
//    }
//}



import UIKit

typealias DICT = Dictionary<AnyHashable,Any>

class Weather {
    var name: String
    var localtime_epoch: TimeInterval
    var temp_c: Double
    var wind_kph: Double
    var cloud: Double
    var text : String
    var icon : String
    
    var weatherDays: [WeatherDay] = []
    
    init?(dict: DICT) {
        // location
        guard let location = dict["location"] as? DICT else { return nil }
        
        guard let name = location["name"] as? String else { return nil }
        guard let localtime_epoch = location["localtime_epoch"] as? TimeInterval else { return nil }
        
        // current
        guard let current = dict["current"] as? DICT else { return nil }
        
        guard let cloud = current["cloud"] as? Double else { return nil }
        guard let temp_c = current["temp_c"] as? Double else { return nil }
        guard let wind_kph = current["wind_kph"] as? Double else { return nil }
        
        // condition trong current
        guard let condition = current["condition"] as? DICT else { return nil }
        
        guard let text = condition["text"] as? String else { return nil }
        guard let icon = condition["icon"] as? String else { return nil }
        
        //forecast
        guard let forecast = dict["forecast"] as? DICT else { return nil }
        guard let forecastday = forecast["forecastday"] as? [DICT] else { return nil }
        
        for dayObject in forecastday {
            if let day = WeatherDay(dict: dayObject) {
                weatherDays.append(day)
            }
        }
        
        self.name = name
        self.localtime_epoch = localtime_epoch
        self.temp_c = temp_c
        self.wind_kph = wind_kph
        self.cloud = cloud
        self.text = text
        self.icon = "http:"+icon
        
    }
}

class WeatherDay {
    //forecast
    var date_epoch : TimeInterval
    var maxtemp_c : Double
    var mintemp_c : Double
    var text : String
    var icon : String
    
    init?(dict : DICT) {
        
        guard let date_epoch = dict["date_epoch"] as? TimeInterval else { return nil }
        guard let day = dict["day"] as? DICT else { return nil }
        guard let maxtemp_c = day["maxtemp_c"] as? Double else { return nil }
        guard let mintemp_c = day["mintemp_c"] as? Double else { return nil }
        guard let condition = day["condition"] as? DICT else { return nil }
        guard let text = condition["text"] as? String else { return nil }
        guard let icon = condition["icon"] as? String else { return nil }
        
        self.date_epoch = date_epoch
        self.maxtemp_c = maxtemp_c
        self.mintemp_c = mintemp_c
        self.text = text
        self.icon = "http:"+icon
    }
}


