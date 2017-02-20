//
//  WeatherVC.swift
//  WeatherNOW
//
//  Created by Hesham Saleh on 2/7/17.
//  Copyright © 2017 Hesham Saleh. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class  WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var currentWeatherLbl: UILabel!
    @IBOutlet weak var currentWeatherImg: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        currentWeather = CurrentWeather()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather.downloadWeatherData {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        //Downloading forecast weather data for TableView
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,Any> {
                
                if let list = dict["list"] as? [Dictionary<String,Any>] {
                    
                    for object in list {
                        let forecast = Forecast(weatherDict: object)
                        self.forecasts.append(forecast)
                        print(object)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func updateMainUI() {
        
        dateLbl.text = currentWeather.date
        currentTempLbl.text = "\(currentWeather.currentTemp)°"
        currentWeatherLbl.text = currentWeather.weatherType
        locationLbl.text = currentWeather.cityName
        currentWeatherImg.image = UIImage(named: currentWeather.weatherType)
    }
    
    //Degrees Celsius: ℃


}

