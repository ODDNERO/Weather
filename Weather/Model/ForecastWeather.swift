//
//  ForecastWeather.swift
//  Weather
//
//  Created by NERO on 7/13/24.
//

import Foundation

struct ForecastWeather: Decodable {
    let list: [ForecastInfo]
}

struct ForecastInfo: Decodable {
    let dt: Int
    let main: WeatherDetail
    let weather: [WeatherInfo]
    let clouds: CloudInfo
    let wind: WindInfo
    let dt_txt: String
}
