//
//  WeatherDisplayViewController.swift
//  Weather Live
//
//  Created by Sawyer Cherry on 10/23/18.
//  Copyright © 2018 Sawyer Cherry. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherDisplayViewController: UIViewController {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    var displayWeatherData: WeatherData! {
        didSet {
            iconLabel.text = displayWeatherData.condition.icon
            currentTempLabel.text = "\(displayWeatherData.temperature)º"
            highTempLabel.text = "\(displayWeatherData.highTemperature)º"
            lowTempLabel.text = "\(displayWeatherData.lowTemperature)º"
        }
    }
    var displayGeoCodingData: GeocodingData! {
        didSet {
            locationLabel.text = displayGeoCodingData.formattedAddress
    }
}
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let weatherData = WeatherData(temperature: 60.0, highTemperature: 75.0, lowTemperature: 53.0, condition: .fog)
        //        print(weatherData.temperature)
        //        print(weatherData.highTemperature)
        //        print(weatherData.lowTemperature)
        //        print(weatherData.condition.icon)
        
        setUpDefaultUI()
        
//        let apiManager = APIManager()
//        apiManager.geocode(address: "Glasgow,+Kentucky"){ (data, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            guard let data = data else {
//                return
//            }
//            print(data.formattedAddress)
//            print(data.latitude)
//            print(data.longitude)
//
//    }
//        apiManager.getWeather(latitude: 36.9958839, longitude: -85.91192149999999) { (data, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            guard let data = data else {
//                return
//            }
//            print(data.temperature)
//            print(data.highTemperature)
//            print(data.lowTemperature)
//            print(data.condition.icon)
//
//        }
    }
    
    func setUpDefaultUI() {
        locationLabel.text = ""
        iconLabel.text = "⚡️"
        currentTempLabel.text = "Enter in a location!"
        highTempLabel.text = "-"
        lowTempLabel.text = "-"
    }
        @IBAction func unwindToWeatherDisplay(segue: UIStoryboardSegue) {
        
    }
}
