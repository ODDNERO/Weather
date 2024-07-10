//
//  APIRouter.swift
//  Weather
//
//  Created by NERO on 7/11/24.
//

import Alamofire
import Foundation

final class APIRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        <#code#>
    }
    
    enum WeatherRequest {
        case current(cityID: Int)
        case forecast(cityID: Int)
        case icon
        
        private var baseURL: String {
            return "https://api.openweathermap.org/data/"
        }
        private var APIVersion: String {
            return "2.5/"
        }
        
        var endpoint: URL {
            switch self {
            case .current(cityID: let cityID):
                URL(string: baseURL + APIVersion + "weather")
            case .forecast(cityID: let cityID):
                URL(string: baseURL + APIVersion + "forecast")
            case .icon:
                URL(string: baseURL + APIVersion + "weather")
            }
            
            var method: HTTPMethod {
                return .get
            }
            
            var header: HTTPHeaders {
                return
            }
            
            var parameter: Parameters {
                switch self {
                case .current(cityID: let cityID):
                    <#code#>
                case .forecast(cityID: let cityID):
                    <#code#>
                case .icon:
                    <#code#>
                }
            }
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        <#code#>
    }
}
