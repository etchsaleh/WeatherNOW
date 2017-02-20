//
//  Location.swift
//  WeatherNOW
//
//  Created by Hesham Saleh on 2/8/17.
//  Copyright © 2017 Hesham Saleh. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
