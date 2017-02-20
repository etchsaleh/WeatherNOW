//
//  Constants.swift
//  WeatherNOW
//
//  Created by Hesham Saleh on 2/7/17.
//  Copyright © 2017 Hesham Saleh. All rights reserved.
//

import Foundation

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=f5549953a5b2873dff7a203717f0b90f"

typealias DownloadComplete = () -> ()

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=f5549953a5b2873dff7a203717f0b90f"
