//
//  APIRouter.swift
//  Weather
//
//  Created by NERO on 7/11/24.
//

import Alamofire
import Foundation


enum APIRouter {
    case current(cityID: Int)
    case forecast(cityID: Int)
    
    private var baseURL: String {
        return "https://api.openweathermap.org/data/"
    }
    private var APIVersion: String {
        return "2.5/"
    }
    
    var endpoint: URL {
        switch self {
        case .current:
            URL(string: baseURL + APIVersion + "weather")!
        case .forecast:
            URL(string: baseURL + APIVersion + "forecast")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .current(cityID: let cityID), .forecast(cityID: let cityID):
            ["id": cityID, "appid": WeatherAPI.key, "lang": "kr"]
        }
    }
}

