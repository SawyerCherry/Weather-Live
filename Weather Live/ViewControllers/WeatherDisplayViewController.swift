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
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let weatherData = WeatherData(temperature: 60.0, highTemperature: 75.0, lowTemperature: 53.0, condition: .fog)
//        print(weatherData.temperature)
//        print(weatherData.highTemperature)
//        print(weatherData.lowTemperature)
//        print(weatherData.condition.icon)
        
        setUpDefaultUI()
        
        let apiKeys = APIKeys()
        
        let darkSkyURL =  "https://api.darksky.net/forecast/"
        let darkSkyKey = apiKeys.darkSkyKey
        let latitude = "37.004842"
        let longitude = "-85.925876"
        
        let url = darkSkyURL + darkSkyKey + "/" + latitude + "," + longitude
        
        let request = Alamofire.request(url)
        
        request.responseJSON { response in switch response.result {
            
        case .success(let value):
            let json = JSON(value)
            print(json)
        case .failure(let error):
            print(error.localizedDescription)
            }
            
        }
        let googleBaseURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
        let googleRequestURL = googleBaseURL + "Glasgow,+Kentucky" + "&key=" + apiKeys.googleKey
        let googleRequest = Alamofire.request(googleRequestURL)
        googleRequest.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func setUpDefaultUI() {
        locationLabel.text = ""
        iconLabel.text = "⚡️"
        currentTempLabel.text = "Enter in a location!"
        highTempLabel.text = "-"
        lowTempLabel.text = "-"
    }
}
