//
//  GeoCodingData.swift
//  Weather Live
//
//  Created by Sawyer Cherry on 10/26/18.
//  Copyright © 2018 Sawyer Cherry. All rights reserved.
//

import Foundation
import SwiftyJSON

class GeocodingData {
    // These are the keys that we will need to get the correct info from the GeoCoding API
    
    enum GeoCodingDataKeys: String {
        case results = "results"
        case formattedAddress = "formatted_address"
        case geometry = "geometry"
        case location = "location"
        case latitude = "lat"
        case longitude = "lng"
        
    }
    //MARK:- Properties
    
    var formattedAddress: String
    var latitude: Double
    var longitude: Double
    
    //MARK:- Methods
    
    init(formattedAddress: String, latitude: Double, longitude: Double) {
        self.formattedAddress = formattedAddress
        self.latitude = latitude
        self.longitude = longitude
        
    }
    //Failable convenience init for the breaking down data from JSON and creating Geocoding Data
    convenience init?(json: JSON) {
        
        guard let results = json[GeoCodingDataKeys.results.rawValue].array else {
            return nil
        }
        // IF NONE OF THESE WORK THEN THE PRINTS WILL THEN IT WILL ALL RETURN NIL!!!!!!
        guard let formattedAddress = results[0][GeoCodingDataKeys.formattedAddress.rawValue].string else {
            return nil
        }
        // UP
        guard let latitude = results[0][GeoCodingDataKeys.geometry.rawValue][GeoCodingDataKeys.location.rawValue][GeoCodingDataKeys.latitude.rawValue].double else {
            return nil
        }
        // UP
        guard let longitude = results[0][GeoCodingDataKeys.geometry.rawValue][GeoCodingDataKeys.location.rawValue][GeoCodingDataKeys.longitude.rawValue].double else {
                return nil
        }
        // INIT ALL OF THE options portrayed in the code IF FAIL RETURN NIL
        self.init(formattedAddress: formattedAddress, latitude: latitude, longitude: longitude)
    }
}

