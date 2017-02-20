//
//  Forecast.swift
//  WeatherNOW
//
//  Created by Hesham Saleh on 2/8/17.
//  Copyright © 2017 Hesham Saleh. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: String!
    private var _lowTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String,Any>) {
        
        if let temp = weatherDict["temp"]  as? Dictionary<String,Any> {
            
            if let min = temp["min"] as? Double {
            
                let kelvinToCelsius = round(300 - min)
                
                self._lowTemp = "\(kelvinToCelsius)"
            }
            
            if let max = temp["max"] as? Double {
                
                let kelvinToCelsius = round(300 - max)
                
                self._highTemp = "\(kelvinToCelsius)"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String,Any>] {
            
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}

