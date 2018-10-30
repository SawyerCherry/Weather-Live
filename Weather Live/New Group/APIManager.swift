//
//  APIManager.swift
//  Weather Live
//
//  Created by Sawyer Cherry on 10/29/18.
//  Copyright © 2018 Sawyer Cherry. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class APIManager {
    private let darkSkyURL = "https://api.darksky.net/forecast/"
    private let googleURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
    //Instance of the APIKEys struct
    private let apiKeys = APIKeys()
    enum APIErrors: Error {
        case noData
        case noResponse
        case invalidData
    }
    func getWeather(latitude: Double, longitude: Double, onCompletion: @escaping (WeatherData?, Error?) -> Void) {
        
        let url = darkSkyURL + apiKeys.darkSkyKey + "/" + "\(latitude)" + "," + "\(longitude)"
        let request = Alamofire.request(url)
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                print(json)
                
                if let weatherData = WeatherData(json: json) {
                    onCompletion(weatherData, nil)
                } else {
                    onCompletion(nil, APIErrors.invalidData)
                }
            case .failure(let error):
                onCompletion(nil, error)
            }
        }
    }
    //Attempt to geocode the address that is passed in.
    func geocode(address: String, onCompletion: @escaping (GeocodingData?, Error?) -> Void) {
        
        let url  = googleURL + address + "&key=" + apiKeys.googleKey
        
        
        let request = Alamofire.request(url)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let geocodingData = GeocodingData(json: json) {
                    onCompletion(geocodingData, nil)
                } else {
                    onCompletion(nil, APIErrors.invalidData)
                }
            case .failure(let error):
                onCompletion(nil, error)
            }
        }
    }
}
