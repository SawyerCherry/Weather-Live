//
//  LocatinSelectorViewController.swift
//  Weather Live
//
//  Created by Sawyer Cherry on 10/26/18.
//  Copyright © 2018 Sawyer Cherry. All rights reserved.
//

import UIKit

class LocatinSelectorViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var locationSearchBar: UISearchBar!
    
    let apiManager = APIManager()
    
    var geocodingData: GeocodingData?
    var weatherData: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationSearchBar.delegate = self
        // Do any additional setup after loading the view.
    }
  
    func handleError() {
        geocodingData = nil
        weatherData = nil
    }
    // THIS RETRIEVES THE GEOCODING ADDRESS AND STRING FORMATS IT
    func retrieveGeocodingData(searchAddress: String) {
        apiManager.geocode(address: searchAddress) { (geoCodingData, error) in
            if let reciecedError = error {
                print(reciecedError.localizedDescription)
                self.handleError()
                return
            }
            if let recievedData = geoCodingData {
                self.geocodingData = recievedData
                self.retrieveWeatherData(latitude: recievedData.latitude, longitude: recievedData.longitude)
            } else {
                self.handleError()
                return
            }
        }
    }
    // THIS RETRIEVES THE WEATHER DATAAND STRING FORMATS IT INTO A DOUBLE
    func retrieveWeatherData(latitude: Double, longitude: Double) {
        apiManager.getWeather(latitude: latitude, longitude: longitude) { (weatherData, error) in
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handleError()
                return
            }
            
            if let recievedData = weatherData {
                self.weatherData = recievedData
                self.performSegue(withIdentifier: "unwindToWeatherDisplay", sender: self)
            } else {
                self.handleError()
                return
            }
        }
    }
    // USES THE  POWERFUL API TO DISPLAY WHEN SEARCH BUTTON IS CLICKED
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: "+") else {
            return
        }
        retrieveGeocodingData(searchAddress: searchAddress)
    }
    // THIS WILL OVERRIDE THE DATA AND TIE IT, PREPARES FOR THE SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? WeatherDisplayViewController, let retrieveGeocodingData = geocodingData, let retrieveWeatherData = weatherData {
            destinationVC.displayGeoCodingData = retrieveGeocodingData
            destinationVC.displayWeatherData = retrieveWeatherData
        }
    }

}
